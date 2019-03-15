---
title: "Blog Setup - Part 1"
description: "Blog Development Process and tools"
publishDate: "2019-03-05"
date: "2019-03-05"
keywords: "Hugo, AWS, Jenkins"
---

When I first got idea of writing blog to stream my activities, I listed out base requirements.

- Static site generator
- Server to run my site

First thing is _Static site generator_, I found **[Hugo](https://gohugo.io)**, fastest static site generator written in Go with ultimate features like _image processing_ etc.,   
All these with out installing any plugins.

Basic commands to get started

{{<highlight bash>}}
# creates new website
hugo new site-name

# runs site with local server
# with default port :1313
hugo server

# build project, artifacts under /public folder
hugo
{{</highlight>}} 

You can add your favourite [theme(s)](https://themes.gohugo.io), by placing theme content under **`/themes`** folder

With `config.toml` file, you configure hugo and theme params, see following file for reference

{{<highlight toml>}}
baseURL = "http://jokrhat.in"
languageCode = "en-us"

title = "JokrHat"
theme = "m10c"

[params]
	author = "Siva Chegondi"
	description = "Web Engineer with good knowledge of *nix and DevOps"

	[[params.social]]
		name = "github"
		url = "https:///github.com/siva-chegondi"
	[[params.social]]
		name = "linkedin"
		url = "https://linkedin.com/in/siva-chegondi"
{{</highlight>}}

After setting up basic configuration, now start writing your posts _/content_ folder. I personally prefer markdown to write posts.

In next post, we are going to discuss about containerizing of our blog to deploy on server.
