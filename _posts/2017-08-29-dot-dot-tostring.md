---
title: '..toString()'
date: 2017-08-29 00:00:00
tags: [javascript]
layout: post
---

```
> 2.toString()
Uncaught SyntaxError: Invalid or unexpected token
> 2..toString()
"2"
```

The reason `2.toString()` doesn’t work in JavaScript but `2..toString()` works is something I always found puzzling but never got to the bottom of it… until now, when I found myself with some free time and this question back in my mind.

The explanation for this quirky behaviour seems to be connected with the JavaScript parser, which acts in a **greedy** way, i.e., it tries to match the longest valid operator each time. In this case, as it parses and evaluates character by character, when it reads the number `2` it expects to be parsing a number, so `2` is valid. The next character, `.`, is also valid in a number (_decimal_ number, but still, valid). Now the following character, `t`, is not valid in a number, so an error is thrown:  
`Uncaught SyntaxError: Invalid or unexpected token`.

In the second case, `2..toString()`, it processes everything the same way but, when it runs into the second dot, it knows it cannot be a number since it found one dot before, the decimal separator. So the number it has so far (`2.`) gets converted to a `Number` (`2.0` which is `2`) and them `toString` is called on it, finally returning `"2"`. A simple way to allow a `toString()` invocation on a number would be to wrap that number with parentheses, clearly encapsulating the number evaluation: `(2).toString()`.

Basilly, `2..toString()` is the same as having `2.0.toString()`:

```
> 2..toString()
"2"
> 2.0.toString()
"2"
```

### Resources
- [Double dot syntax in JavaScript](https://stackoverflow.com/a/24891388/590525)
- [Why does “a + + b” work, but “a++b” doesn't?](https://stackoverflow.com/a/7491960/590525)
