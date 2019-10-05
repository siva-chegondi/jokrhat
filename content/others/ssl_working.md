---
title: "SSL Working - Root and Intermediate Certificates"
description: "Details of SSL working"
publishDate: "2019-04-05"
date: "2019-04-05"
categories: [SSL]
---

Here I am gonna discuss about how TLS works. Components involved were **server**, **client** and **Certificate Authority (CA)**.  
Again CA can be **Root CA** or **Intermediate CA**

**Server**: 		Machine providing any service.  
**Client**: 		Machine requesting service.    
**Certificate Authority**: 		Machine which signs server certificate with its signature. 

Secure Socket Layer (SSL), encrypts data to and from server using SSH Keys in order to make communication between client and server to be reliable, confidential and secure. Any website accepting confidential data should be sure implement TLS in server. But here the problem is client doesn't know where the encryption is doing with (website's/ servers') keys or by any MITM attack is happening.  

Here comes the role of CA (certificate authority), CA is a trusted third party which signs the SSL keys of server with its identity so that browser confirms that response is from server.  

**Steps involving Certificate Requests:**  

- Server, requests CA to initiate certificate signing with information of domain name, public key etc.,
- Now CA verifies whether the server holds the domain by either DNS record or by accessing resource under well known URI.
- Once the server has been verified, server requests certificate by Certificate Signing Request (CSR) for domain. Now CA creates signed certificate.
 

**Steps involving encrypted communication:**

- Client requests messages server to initiate SSL communication.
- Now server responds back with the encrypted SSL certificated signed with CA signature.
- Now client checks the signature and creates _Session Key_ ,encrypts with public key and respond back to server.
- Server decrypts the _session key_ with the private key and use that session key for futher communication. Communication is done with session key using symmetric algorithms.

In this process, we have some manual steps like verification of domain ownership. We can also automate this using **ACME** protocol. [Letsencrypt](https://letsencrypt.org) CA uses this algorithm to provide free SSL certificates to the server.If you want to learn more about ACME working checkout [this](https://letsencrypt.org/how-it-works/). Google Developed one project complianing AMCE protocol, a command line interface to manage SSL certificates, [Project](https://opensource.google.com/projects/acme)
