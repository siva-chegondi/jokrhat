---
title: "Hashicorp Vault - API access with Go Program"
description: "vault API accessing with Go Program"
publishDate: "2019-04-06"
date: "2019-04-05"
tags: ["vault","go","API"]
categories: ["programming"]
---

**Hashicorp Vault**, solution to store secrets, certs, access tokens and sensitive data of your application. It exposes an API by which we can access secrets from our application.To know more about Vault, check out [docs](https://www.vaultproject.io/docs)

In this post, am gonna share basic code template in Golang to access **Vault**. Assuming you have some knowledge of [`Golang`](https://golang.org). I am diving code into two parts.

- **Formater** to prepare request and response to and from server.
- **HTTP Handler** to work on Vault API with methods supporting POST, GET, DELETE for writing, reading and deleting contents. In here, were are working on KV secrets engine of VAULT

### Formatter
Following code consists of method to unmarshal json to `Response` Data struct

{{<highlight go>}}
	package utils

  // Result response struct from vault API
 	type Result struct {
		Request_id     string
		Lease_id       string
		Renewable      bool
		Lease_duration int
		Data           data
		Metadata       resultMetadata
		Wrap_info      string
		Warnings       string
		Auth           string
		Errors         []string
	}

	type data struct {
		Data     map[string]interface{}
		Metadata map[string]interface{}
		Keys     []string
	}

	type resultMetadata struct {
		Created_time  time.Time
		Deletion_time time.Time
		version       int
		Destroyed     bool
	}

 // RequestData request payload for storing data
 type RequestData struct {
		Options options `json:"options"`
		Data map[string]interface{} `json:"data"`
 }

 type options struct {
 		Cas int `json:"cas"` // to label in lowercase while marshalling
	}

 // Formatter formats 
 func Formatter(data []byte) {
		var v Result
		if err := json.Unmarshal(data, &v); err != nil {
			panic(err)
		}
		return v
 }
{{</highlight>}}


### HTTP Handler
This file encaps code for preparing HTTP calls and implementing API calls. `QueryStore`, reads data from vault kv secrets engine. `LoadStore`, loads data from vault kv secrets engine. `Delete` obviously deletes data secrets engine.

{{<highlight go>}}
	package utils

 	func prepareRequest(vaultEndpoint, method string, data []byte) (*http.Client, *http.Request) {

		vaultKey, err := os.GetEnv("VAULT_KEY")
		httpClient := &http.Client{
			Timeout: 30 * time.Second, // 30s timeout
		}

		req, err := http.NewRequest(method, vaultEndpoint, bytes.NewBuffer(data))
		if err != nil {
			panic(err)
		}
		// note we are adding token to header
		req.Header.Add("X-Vault-Token", vaultKey)
		return httpClient, req
	}

 // QueryStore reads data with GET method
	func QueryStore(vaultEndpoint string) Result {
		var data []byte
		client, req := prepareRequest(vaultEndpoint, "GET", nil)
		if res, err := client.Do(req); err != nil {
			panic(err)
		} else {
			data, _ = ioutil.ReadAll(res.Body)
			defer res.Body.Close()
		}
		return Formatter(data)
	}

  // LoadStore loads store with data regarding
	func LoadStore(vaultEndpoint string, data []byte) (Result, error) {
		client, req := prepareRequest(vaultEndpoint, "POST", data)

		res, err := client.Do(req)
		if err != nil {
			return Result{}, err
		}
		data, _ = ioutil.ReadAll(res.Body)
		defer res.Body.Close()
		return FormatResult(data), nil
	}

	// DeleteStore deletes item with key
	func DeleteStore(vaultEndpoint string) (Result, error) {
		client, req := prepareRequest(vaultEndpoint, "DELETE", nil)

		res, err := client.Do(req)
		if err != nil {
			return Result{}, err
		}
		defer res.Body.Close()
		return Result{}, nil
	}
{{</highlight>}}

Here is the example of how to call above API calls. Before using, checkout [vault API](https://www.vaultproject.io/api) to know more API calls of Vault. For this example, lets assume the path for KV engine is **/secrets**

{{<highlight go>}}
  func loadCred() {
		loadUrl = vaultUrl + "v1/secrets/data"
		res, err := utils.QueryStore(vaultStorage.API+storeURL+key)
		if err != nil || len(res.Errors) > 0 {
			 // handle error
		}
		
		// handle response here
  }
{{</highlight>}}
