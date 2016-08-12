---
title: 'Recursion in simple terms'
date: 2016-08-12 00:00:00
tags: recursion
layout: post
---
While pairing with my mentee this past weekend, I (re)realised how hard [recursion](https://www.google.co.uk/search?q=recursion) is. It’s not exactly intuitive. After you understand it, it looks simple and quite elegant, but it’s not an easy place to get to when you’re new to programming.

Imagine if you could solve a huge problem doing the same simple step over & over again. Like iteration, but with a twist. Every time you act on the problem, you’re hacking away a small part of it and leaving the rest for the next time you’ll do that simple step.

That’s the power or recursion: you define the solution of a problem as the sum/group of all these repetitive small steps you perform on a tiny subset of the problem. And you do this over & over again until the problem is gone. You solve a bit of the problem now and delay the rest of it for the next iteration, which will occur not on the complete problem that you got on this iteration, but on a smaller set.

Here’s a simple recursive array sum:

```js
function recursiveSum(arr) {
  return arr.length ?
    arr[0] + recursiveSum(arr.slice(1)) : 0;
}
```

The function above returns `0` if the array it gets is empty (because the sum of an empty array is zero), but if the array is not empty, it states the total sum of an array as the sum of its head (the first element) with its tail (the rest of the array). If you keep applying that definition on the rest of the array, you end up unfolding the expression.  
See how `recursiveSum([1, 2, 3])` unfolds:

```
recursiveSum([1, 2, 3])
↳ 1 + recursiveSum([2, 3])
       ↳ 2 + recursiveSum([3])
              ↳ 3 + recursiveSum([])
                     ↳ 0
   1   +  2   +  3   +  0  =  6
```

The way I see it, every time you want to solve a problem recursively, there are three main things that must be present:

- Base case
- Solve a bit of the problem
- Call the solution on a smaller problem


## Base case

This is basically your __stop criteria__, the condition that will be eventually met in order to stop execution. It usually boils down to returning a trivial value, without recursion involved. For example, in the case of [factorial](https://en.wikipedia.org/wiki/Factorial), the base case is `0! == 1`, so when `n` gets down to 0, our function just returns 1. In some cases, more than one base case might be present.


## Solve part of the problem

Now that we have our base case(s) defined, we can focus on actually solving the big problem. On the recursive array sum example, we’re taking the array’s head and framing it in a sum with the rest of the array. In the case of a [Fibonacci](https://en.wikipedia.org/wiki/Fibonacci_number) sequence, we frame the number we want as the sum of the two previous numbers.


## Call the solution on a smaller problem

Finally, when you solved part of the problem, you call the function you are in, but now on a smaller portion of the problem. On a recursive array sum, for example, you would be calling `recursiveSum` in a smaller array, typically without it’s head. In the case of a Fibonacci sequence, we get to the two previous numbers we need by calling the Fibonacci function twice; one call for one index before and another for two indexes before (thus we get the two previous numbers we need). Eventually, by executing the solution on a gradually smaller problem will get it solved.


And that’s basically it. I hope I did a good job in explaining this concept, which sometimes I still struggle with.


![Recursion in 'Adventure Time'](http://i.imgur.com/8gPEm.gif)


---


### Resources

- [Recursion (computer science)](https://en.wikipedia.org/wiki/Recursion_(computer_science))
- [How should I explain recursion to a 4-year-old?](https://www.quora.com/How-should-I-explain-recursion-to-a-4-year-old/answer/Aaron-Krolik?srid=p3Pu)
