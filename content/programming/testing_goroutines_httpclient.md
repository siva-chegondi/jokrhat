---
title: Unit testing - Go routines and http client
description: How to test functions which are calling a go routine inside it and mocking http client
date: "2025-01-27"
published: true
tags: ["unit-tests", "go", "routines", "http-client"]
categories: ["programming"]
---
In this post, we are going to write unit tests for a method which is calling a go routine inside init. We use the `gomock`
to generate mocks and to set expects for the mocked code. To know more about `gomock` lib and `mockgen` CLI you can read
this blog [post](go_unit_testing.md).

### [ Code ]
In the following code, we are recording a purchase in the DB and making a async call to send email to the customer for 
the invoice using go routine.

{{< highlight go "linenos=table" >}}
func (api *APIClient) BuyToy(toyId, userId int) error {

	purchaseRecord := &PurchaseRecord{
		purchaseId: "dummy-unique-uuid",
		toyId:      toyId,
		userId:     userId,
	}
	data, _ := json.Marshal(purchaseRecord)
	reader := strings.NewReader(string(data))
	_, err := api.httpClient.Post("/api/toystore/buy", "application/json", reader)
	if err == nil {
		go api.GenerateAndSendInvoice(purchaseRecord)
	}
	return err
}
{{< / highlight >}}

The problem writing unit testing above code is `GenerateAndSendInvoice` may get executed or not by the end of unit test.
If we test above method with a mock expectation, it may sometimes fail with unexpected call to `GenerateAndSendInvoice`
error.

Inorder to test above method we can leverage `AnyTimes` from the `gomock` framework which will expect a call 0 or more
times. Add following code snippet to the unit test.

{{< highlight go "linenos=table" >}}
// using AnyTimes() to expect it 0 or more times.
s.apiClient.EXPECT().GenerateAndSendInvoice(gomock.Any()).AnyTimes().Return(nil)
{{< / highlight >}}

Following is the complete code for unit testing `BuyToy` method.

{{< highlight go "linenos=table" >}}
func (s *ToyStoreTestSuite) TestBuyToy() {
    // mock api call to the expected result
    s.apiClient.EXPECT().BuyToy(gomock.Any(), gomock.Any()).Return(nil)

	// Internally BuyToy is calling Generate and
	// sending email invitation asynchronously.

	// Following expectation may get called 0 or 1 time based on the execution time.
	// so using AnyTimes() to expect it 0 or more times.
	s.apiClient.EXPECT().GenerateAndSendInvoice(gomock.Any()).AnyTimes().Return(nil)
	err := s.toyStore.BuyToy(100, context.WithValue(context.Background(), "user-id", 213))
	assert.Nil(s.T(), err)
}
{{< / highlight >}}

Hope this blog post helps you, Happy coding!