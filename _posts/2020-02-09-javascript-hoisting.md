---
title: 'JavaScript hoisting'
date: 2020-02-09 00:00:00 
tags: [javascript, hoisting]
layout: post
---

[Storm Ciara][storm-ciara] is outside battering the UK and I’m going through old drafts and notes I took years ago about things I wished to write about… one day. Well, today is one of those days.

Something that caught my eye were a few lines of code that boggled my mind a long time ago:
```js
var greeting;
function greeting () { 
    console.log("hi");
}
console.log(typeof greeting); // function

var greeting = "string";
function greeting () { 
    console.log("hi");
}
console.log(typeof greeting); // string
```

When I first encountered this, I couldn’t really explain it. It’s one of those things that, even thought you’ve been working with JavaScript for a while, might caught you off-guard.

I’m a bit more knowledgeable now so the code above makes some sense. I’m not going to write a full blown article about hosting in JavaScript, but I’ll point you to an excellent one by Scotch.io, [Understanding Hoisting in JavaScript][hoisting]. Nevertheless, I’ll try to explain what’s happening in the snippet above, because if you can’t explain something, you don’t understand it that well.

`function greeting ()` is a **function declaration**, which takes precedence over the **variable declaration** performed right before it (`var greeting;`). On the other hand, the second part of the code has a **variable assignment** (`var greeting = "string";`) which takes precedence over the function declaration below it.

The order of the declarations doesn’t matter and that’s the focus of this short post. **JavaScript reorders your code** according a few rules — in this case, [_only declarations are hoisted_][only-declarations].

_“Why hoist things in the first place??”_, you might ask. I had the same question and I found a [great answer on StackOverflow][why-hoist]! It seems to be quite useful (necessary even?) for mutually recursive functions and everything else that uses variable references in a circular fashion. Using the code from the answer as an example, we can have an `even` function that tries to use another function only declared after itself:
```js
function even(n) { return n == 0 || !odd(n-1); }
function odd(n) { return !even(n-1); }
```

[storm-ciara]: https://www.theguardian.com/uk-news/2020/feb/09/storm-ciara-hurricane-force-winds-batter-uk-transport
[hoisting]: https://scotch.io/tutorials/understanding-hoisting-in-javascript
[only-declarations]: https://developer.mozilla.org/en-US/docs/Glossary/Hoisting#Only_declarations_are_hoisted
[why-hoist]: https://stackoverflow.com/a/52880419/590525
