---
title: 'OAuth2 in Node.js'
date: 2016-07-07 00:00:00 
tags: node express passport oauth2
layout: post
---
Let’s be honest: OAuth2 is a pain. It shouldn’t be, but the final product ended up being a [designed-by-committee product](http://hueniverse.com/2012/07/26/oauth-2-0-and-the-road-to-hell/). A couple of months ago I went through this bumpy road, and after a few days, I finally found a way that worked, using __Node.js__ + __Express__ + __Passport__.

The project in question is [Alumnum](https://github.com/gnclmorais/alumnum), a simple Node.js app where [Recurse Center](https://recurse.com) students can easily add entire batches’ contacts to their Google Contacts with a few clicks. I’ll try to highlight the most important bits of the code, the ones that made all the difference regarding OAuth2.

---


