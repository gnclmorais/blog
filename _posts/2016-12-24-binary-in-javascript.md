---
title: 'Binary in JavaScript'
date: 2016-12-24 00:00:00
tags: binary javascript
layout: post
---

_This article is based on a [lightning talk](https://www.youtube.com/watch?v=Qyh_QcgotUY&hd=1) I recently did at dotJS and it was written for [Mariko](https://twitter.com/kosamari)’s [Web Advent Calendar](http://web.advent.today). Check all the other interesting articles, specially [Pam’s](http://thewebivore.com/async-await-and-why-its-great/) and [Ricardo’s](http://blog.ricardofilipe.com/post/light-my-house)!_

---

I’m not entirely sure about how many web developers know about (or even use) it, but JavaScript is capable of binary. 0s and 1s can easily be manipulated with bitwise operators on our favourite language and that’s what I’ll present on this post.

First of all, _why?_ Why would you care about this? In your years of web development, you probably never had the need to use any of these operations, so why are you even reading this? OMG is it one more thing to know and add to my [JavaScript fatigue](https://medium.com/@ericclemmons/javascript-fatigue-48d4011b6fc4#.d36qvkc5h)??

Don’t worry, this is just a piece of curiosity. Please keep reading if you love quirks! This article will be a brief introduction to the available bitwise operations, but I can already recommend you a [great post](https://danthedev.com/2015/07/25/binary-in-javascript) from [Dan Prince](https://twitter.com/_danprince). In short, he was able to greatly reduce the memory footprint of a game we was developing using bitwise operators. He was working on a 512x512 pixel matrix, using Plain Old JavaScript Objects to represent each pixel. However, using just the strictly necessary bits to save the game’s state, each object was replaced by an integer, reducing the memory consumption four times! You’ll find more info in his blog post.


## A few technicalities first

Let me quickly tell you a few important technical details about how JavaScript deals with numbers and binary operators.

### Numbers are stored using 64 bits
Basically, all numbers in JavaScript are floating point. A single bit for sign (0 for positive and 1 for negative numbers), 11 bits exponent bits to indicate where the point is, and finally 52 bits representing the actual digits of the number.

```
   sign | exponent | fraction
(1 bit) | (11 bit) | (52 bit)
     63 | 62 -- 52 | 51 --- 0
```

### Numbers with more than 32 bits get truncated
It means that, from the 64 bits you read on the previous paragraph, we’ll only keep the 32 at the right (i.e. the least significant).

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

### Bitwise operations are performed on pairs of bits
Operations are performed by pairing up each bit in the first operand with the corresponding bit in the second operand. Example:

```js
// Using only eight bits here for illustration purposes:
var a = 9; // 0000 1001
var b = 5; // 0000 0101

a & b -> a // 0000 1001
              &&&& &&&&
         b // 0000 0101
              ---------
              0000 0001 -> 1 (base 10)
```


## Bitwise operators

JavaScript has seven bitwise operators, all of them convert their operands to 32-bit numbers.

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
| a | b | a | b |
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

Different bits will result in `1`, simply put. I must admit XOR is my favourite, it can be quite baffling. 10 points to whoever knows what the following code does:

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
`NOT` operator simply inverts all the bits, including the sign. It’s like inverting the colours of an image.

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

`>>>` is a specific case of right shift, where the new bits coming from the left towards the right are always 0, independent of the sign of the number. A consequence of it is that it turns any negative number into positive.

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


## Fun with bitwise operators

So what can we do with these operators? Given their quirks and behaviour, let’s see some weirdness in action. A lot of these quirks stem from the transformation from 64-bit to 32-bit.

### Truncate numbers

```js
var a =  3.14;
var b = -3.14;
console.log(a & a, b & b); //  3, -3
console.log(a | 0, b | 0); //  3, -3
console.log(~~a, ~~b);     //  3, -3
```

### Convert strings to numbers, emulating `parseInt`

```js
var a = '15' >>> 0;
var b = '15.4' >>> 0;
console.log(a, b); // 15, 15

var c = '3.14';
var d = c | 0;
var e = c & c;
console.log(d, e); // 3, 3
```

### Multiply a number by multiples of 2

```js
console.log(7 << 1); // 7 * 2 * 1 = 14
console.log(7 << 2); // 7 * 2 * 2 = 28
console.log(7 << 3); // 7 * 2 * 3 = 56
// …
```

### Different sub-string search
```js
var string = 'javacript';
var substr = 'java';

// If the sub-string is found,
// appying NOT to the index will return a negative number,
// which is a truthy value;
// If not found, `indexOf` will return -1,
// which in turn ~(-1) == 0, into the `else` case.
if (~string.indexOf(substr)) {
  // Found the sub-string!
} else {
  // Nope, no match
}
```


## So… should you use this?

Short answer… no.  
Long answer… it depends. As you’ve seen, there are a lot of gotchas and quirks people need to be aware of when using this. You need to know the variable types you’re dealing with, and that’s hard(er) to do in a dynamically typed language like JavaScript. You wouldn’t want to accidentally truncate numbers with decimals or make a negative number positive.

Other issue you should have in consideration is the consequent code obfuscation when you decide to write `x << 1` instead or `x * 2`, for example. However, this might be a compromise you are willing to do, which becomes pretty manageable with wrappers like [tiny-binary-format](https://github.com/danprince/tiny-binary-format).

Finally, keep in mind that [Douglas Crockford doesn’t like it](http://stackoverflow.com/questions/1908492/unsigned-integer-in-javascript/1909320#1909320), considering it one of the bad parts of JavaScript.

__However__, for side projects or applications where you need to squeeze more out of the hardware you are working on, why not? I write JavaScript for fun on my personal projects, and in those cases I like to do different things than I do on my daily job. If that involves shifting bits left & right, good for you! Keep your code weird and interesting — and learn something along the way.
