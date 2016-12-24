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
Basically, numbers in JavaScript are all floating point. One bit for sign (0 for positive and 1 for negative numbers), 11 bits exponent bits to indicate where the point is, and finally 52 bits representing the actual digits of the number

```
   sign | exponent | fraction
(1 bit) | (11 bit) | (52 bit)
     63 | 62 -- 52 | 51 --- 0
```

### Numbers with more than 32 bits get truncated
That means that, from the 64 bits you read on the previous line, we’ll only keep the 32 at the right (i.e. the least significant). The sign bit is dropped as well, so negative numbers become positive, for example.

```js
                                   // 15872588537857
Before: 11100110111110100000000000000110000000000001
After:              10100000000000000110000000000001
                                   //     2684379137

var a = (-5 >>> 0).toString(2);
// "11111111111111111111111111111011"
parseInt(a, 2);
// 4294967291
```

### Binary operations are fine for integers…
… but not so much for other types. You’ll see what I mean by this soon.


## Binary operators

### `&` (AND)
```
| a | b | a & b |
|---|---|-------|
| 0 | 0 |   0   |
| 0 | 1 |   0   | 
| 1 | 0 |   0   |
| 1 | 1 |   1   |
```

Simply speaking, `&` results in `0` if there is at least one `0`.

### `|` (OR)
```
| a | b | a / b |
|---|---|-------|
| 0 | 0 |   0   |
| 0 | 1 |   1   |
| 1 | 0 |   1   |
| 1 | 1 |   1   |
```

In the case of `|`, the output will be `1` if there is at least one `1`.

### `^` (XOR)
```
| a | b | a ^ b |
|---|---|-------|
| 0 | 0 |   0   |
| 0 | 1 |   1   |
| 1 | 0 |   1   |
| 1 | 1 |   0   |
```

Different bits will result in `1`, simply put. I must admit XOR is my favourite, there’s a case where it works just like magic. 10 points to whoever knows what the following code does:

```js
var a = 1, b = 2;
a ^= b; b ^= a; a ^= b; // wat?
```

If you didn’t get it, don’t worry, you are not alone. It’s a very obfuscated __value swap without a third variable__ (only between integers, though). Check this out:

```js
var a = 1;  // 0001
var b = 2;  // 0010

a ^= b;  // 0001 ^ 0010 = 0011
b ^= a;  // 0010 ^ 0011 = 0001
a ^= b;  // 0011 ^ 0001 = 0010

console.log(a); // 2 (0010)
console.log(b); // 1 (0001)
```

![Mind. Blown.](http://mrwgifs.com/wp-content/uploads/2013/11/Finns-Mind-Is-Blown-In-Space-On-Adventure-Time.gif)

### `~` (NOT)
`NOT` operator simply inverts all the bits, including the sign. It’s like inverting the colours of an image, only simpler.

```
 9 = 00000000000000000000000000001001
     --------------------------------
~9 = 11111111111111111111111111110110 = -10 (base 10)
```

Applying `~` on any number x results on -(x + 1). In the example above, ~9 yields -10. This is related to the way JavaScript represents 32-bit numbers using [two’s complement](https://en.wikipedia.org/wiki/Two%27s_complement) (something that we will not get into detail here).

### `<<` (left shift)

`<<` pushes 0-bits from the right __towards the left__, droping as many from its left as the ones pushed from its right.

```
9      : 0000 0000 1001
9 << 2 : 0000 0010 0100  // 36
                     ^^
                     new bits
```

### `>>` (Sign-propagating) right shift

`>>` shifts bits towards the right, but it is not simply called _right shift_ because unlike the left shift, it doesn’t push always zeros. The bit pushed depends on the sign of the number: if the number is positive, 0-bits will be pushed; if the number is negative, 1-bits will be used instead.

```
 9      : 0000 0000 1001
 9 >> 2 : 0000 0000 0010  // 2
          ^^
          new bits

-9      : 1111 1111 0111
-9 >> 2 : 1111 1111 1101
          ^^
          new bits
```

### `>>>` (Zero-fill) right shift

`>>>` is a specific case of right shift, where the new bits coming from the left towards the right are always 0, independent of the sign of the number.

```
 9       : 0000 0000 1001
 9 >>> 2 : 0000 0000 0010
           ^^
           new bits

-9       : 1111 1111 0111
-9 >>> 2 : 0011 1111 1101
           ^^
           new bits
```

## So… should you use this? Is this production safe?

Short answer… no.

Long answer… it depends. As you’ve seen, there are a lot of gotchas and quirks people need to be aware of when using this. You need to know the variable types you’re dealing with, and that’s hard(er) to do in a dynamically typed language like JavaScript.

Other issue you should have in consideration is the consequent obfuscation you are performing when you decide to user `x << 1` instead or `x * 2`, for example. However, this might be a compromise you are willing to do, which becomes pretty manageable with a small wrapper layer like [TODO: Insert example of tiny-bit-etc]().

Finally, [Douglas Crockford doesn’t like it](http://stackoverflow.com/questions/1908492/unsigned-integer-in-javascript/1909320#1909320).

__However__, you might ask _‘What about for side projects or very specific cases?’_ For this, I say, __Why not?__

I write JavaScript for fun on my side projects, and in those cases I like to do different things than I do on my daily job. If that revolves around shifting bits left & right, good for you! I say keep your code weird and interesting — and learn something on the way.

## Resources
- http://www.2ality.com/2014/01/binary-bitwise-operators.html
- http://www.2ality.com/2012/04/number-encoding.html
