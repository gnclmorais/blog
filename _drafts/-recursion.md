---
title: 'Recursion in simple terms'
date: 2014-12-04 00:00:00
tags:
layout: post
---

While pairing with my mentee this past weekend, I (re)realised how hard [recursion](https://www.google.co.uk/search?q=recursion) is as a concept. After getting, it looks simple and quite elegant, but it’s a long way before understanding what it means.

Imagine if you could solve a huge problem doing the same simple step over & over again. Every time you act on the problem, you’re hacking away a small part of it and leaving the rest of the problem for the next time you’ll do that simple step.

That’s the power or recursion: you define the solution of a problem as the sum/group of all these repetitive small steps you perform on a tiny subset of the problem. And you do this over & over until the problem is gone. You solve a bit of the problem now and delay the rest of it for the next iteration, which will occur not on the complete problem that you got on this iteration, but on a smaller set.

Here’s a simple recursive array sum:

```js
function recursiveSum(arr) {
  return arr.length ?
    arr[0] + recursiveSum(arr.slice(1)) : 0;
}
```

The above function returns `0` if the array it gets is empty (because the sum of an empty array is zero), but if the array is not empty, it states the total sum of an array as the sum of its head (the first element) with its tail (the rest of the array). If you keep applying that definition on the rest of the array, you end up unfolding the expression and a sum of single elements appears.  
See how `recursiveSum([1, 2, 3])` unfolds:

```
recursiveSum([1, 2, 3])
↳ 1 + recursiveSum([2, 3])
       ↳ 2 + recursiveSum([3])
              ↳ 3 + recursiveSum([])
                     ↳ 0
   1   +  2   +  3   +  0  =  6
```

The power comes in solving just a piece of the problem and delaying the rest of the solution
Infinite problem described as a finite statement

The way I see it, every time you want to solve a problem recursively, there are three main things that must be present:

- Base case
- Solve a bit of the problem
- Call the solution on a smaller problem


## Base case

This is basically your stop criteria.
- gets to a trivial value without recursion
- it's basically a stoping condition
- if there isn't a clear one, you create one, like "number of times to execute"


## Solve a bit of the problem
stuff


## Call the solution on a smaller problem
moar stuff

---

### Resources

- [How should I explain recursion to a 4-year-old?](https://www.quora.com/How-should-I-explain-recursion-to-a-4-year-old/answer/Aaron-Krolik?srid=p3Pu)
