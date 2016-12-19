---
title: 'Binary in JavaScript'
date: 2016-12-18 00:00:00
tags: binary javascript
layout: post
---

_This article is based on a lightning talk I recently did at [dotJS](http://2016.dotjs.io/) and it was written for [Mariko](https://twitter.com/kosamari)’s [Web Advent Calendar](http://web.advent.today). Check all the other interesting articles, specially [Pam’s](http://thewebivore.com/async-await-and-why-its-great/) and [Ricardo’s](http://blog.ricardofilipe.com/post/light-my-house)!_

---

I’m not entirely sure about how many web developers know about (and even use) this, but JavaScript is capable of binary. 0s and 1s can easily be manipulated with out favourite language and that’s what I’ll briefly discuss on this post.

First of all, _why_? Why would you care about this? In several years of web development, you probably never had the need to use any of these binary operations, so why are you even reading this?

This article will be a brief introduction to the available operations, but I can already point you out to a [great example](https://danthedev.com/2015/07/25/binary-in-javascript) from [Dan Prince](https://twitter.com/_danprince). In short, he was able to greatly reduce the memory footprint of a game we was developing using binary operators. He was operating on a 512x512 pixel matrix, with an Plain Old JavaScript Object representing each pixel. However, using just the strictly necessary bits to save justenough information, each object was replaced by an integer, reducing the memory consumption four times!


## A few technicalities first

Let me quickly brief you on a few important technical details about how JavaScript deals with numbers and binary operators.

### Numbers are stored using 64 bits
Basically, numbers in JavaScript are all floating point.

```
   sign | exponent | fraction
(1 bit) | (11 bit) | (52 bit)
     63 | 62 -- 52 | 51 --- 0
```

### Numbers with more than 32 bits get truncated
# why?

```
                                   // 15872588537857
Before: 11100110111110100000000000000110000000000001
After:              10100000000000000110000000000001
                                   //     2684379137
```

### Binary operations are fine for integers…
… but not so much for other types. You’ll see what I mean by this soon.


## Binary operators

### `&` (AND)

### `|` (OR)

### `~` (NOT)

### `^` (XOR)

### `<<` (left shift)

### `>>` (Sign-propagating) right shift

### `>>>` (Zero-fill) right shift


## Is this production safe?
