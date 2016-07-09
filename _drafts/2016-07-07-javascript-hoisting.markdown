---
title: 'JavaScript hoisting'
date: 2016-07-07 00:00:00 
tags: 
layout: post
---
(shoutout to Khalid)

```js
var greeting;
function greeting () { 
    console.log("hi");
}
console.log(typeof greeting);

var greeting = "string";
function greeting () { 
    console.log("hi");
}
console.log(typeof greeting);
```
