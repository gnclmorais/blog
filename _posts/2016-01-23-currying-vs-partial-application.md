---
title: 'Currying and partial application'
date: 2017-01-22 00:00:00
tags: [javascript, functional programming]
layout: post
---

From time to time I find myself binding a function in JavaScript to a few values and wondering _I can’t remember now… Is this partial application or currying?_. I know these concepts are related but I keep mizing them, finding them hard to differentiate. I decided then to read about it and try to put it on my own words, so I can finally commit them into my memory, once and for all.


## Partial application

Simply put, **partial application** is the act of taking a function that accepts N arguments and binding values to one or more of those arguments. This returns a new function (with an [arity](https://en.wikipedia.org/wiki/Arity) smaller than N) that accepts the remaining not bounded arguments. Let’s see some examples.

```js
function sumCoordinates(x, y, z) {
    return x + y + z;
}
console.log(sumCoordinates.length); // 3, meaning it accepts three arguments

var sumYandZ = sumCoordinates.bind(null, 1);
sumYandZ.length // 2, meaning it accepts two arguments

sumCoordinates(1, 2, 3) === sumYandZ(2, 3); // true

// A more useful example
const times = (a, b) => a * b;
const double = times.bind(null, 2);
double(10); // 20
double(21); // 42
```

As you can seen, by calling `sumCoordinates.bind(null, 1)` we partially applied the function `sumCoordinates`, binding its first argument to `1`. `sumYandZ` is nothing more than a new function that calls `sumCoordinates` with a prebinded first value.

Partially applying a function usually involves two steps. The first one is binding it to the number of preset arguments we want, and the second step is to call it on the remaining arguments (or none whatsoever).


## Currying

Now currying is a slightly different kind of beast from partial application. **Currying** a function that would take N arguments will return a function that represents a chain of N functions taking a single argument. I know it sounds weird, so let me explain it better with an example.

```js
// JavaScript doesn’t have native currying,
// so we need a helper for that
function curry(fn) {
  // Save the number of required arguments of the original function
  const fnArity = fn.length;

  return (function currier() {
    // Create a cache for arguments, were they will be stored
    let argCache = Array.prototype.slice.call(arguments);

    return function () {
      // Get the next arguments and add them to the argument cache
      let argsSoFar = argCache.concat(...arguments);
      // If we are still short on arguments, keep returning a curried function;
      // Otherwise, apply the original function to all the arguments so far
      let next = argsSoFar.length < fnArity ? currier : fn;
      return next.apply(null, argsSoFar);
    };
  }());
}

function sumCoordinates(x, y, z) {
    return x + y + z;
}

var curriedSum = curry(sumCoordinates);
curriedSum.length // 0, as it relies on the `arguments` object

typeof curriedSum(1)       // "function"
typeof curriedSum(1)(2)    // "function"
typeof curriedSum(1, 2)    // "function"
typeof curriedSum(1)(2)(3) // "number"
typeof curriedSum(1, 2)(3) // "number"
6 === curriedSum(1)(2)(3)  // true
6 === curriedSum(1, 2)(3)  // true
6 === curriedSum(1, 2, 3)  // true
```

A curried function can have up to `N + 1` steps, where N is the number of arguments the original curried function has. The first step is currying the function, and the following steps depend on how many argument at a time you pass onto the function. As you’ve seen above, `curriedSum(1, 2, 3)` will give the same result as `curriedSum(1)(2)(3)`, since both function have the necessary number of arguments to fulfil the originally curried function.
