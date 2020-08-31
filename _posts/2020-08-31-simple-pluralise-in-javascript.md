---
title: 'Simple pluralise in JavaScript'
date: 2020-08-31 00:00:00
tags: javascript
layout: post
---

While working with Vue.js on top of a Ruby on Rails stack, I found myself
replicating on the front end a few of the helpful utilities we had access to in
the back end. One of them was **pluralise**, either [with][0] or [without][1]
number.

After finding several components with similar [ternaries][2] trying to figure
out if the singular or plural version of a word should be used, I saw a good
opportunity to extract that logic to its own piece and I ended up with this:

```js
const pluralize = (count, singular, { plural, number } = {}) => {
  const message = count === 1 ? singular : (plural || `${singular}s`);

  return number === false ? message : `${count} ${message}`;
};

// Uses:
pluralize(1, 'mouse') // 1 mouse
pluralize(2, 'house') // 2 houses
pluralize(2, 'house', { number: false }) // houses
pluralize(2, 'mouse', { plural: 'mice' }) // 10 mice
pluralize(2, 'mouse', { plural: 'mice', number: false }) // mice
```

In a nutshell, this is how it works:
- You always need to pass the number to be considered and the singular form,
  which will give you `<number> <bigger than 1 ? (singular + 's') : singular>`;
- If the plural is irregular (i.e. it’s not just the `singular` plus an `s`),
  you can provide it;
- If you just need the singular/plural without the number, you can say so.

Bonus points: if you’re a bit of a minimalist and enjoy saying some keystrokes,
you could set up something like this:

```js
// plural with number
const pn = (n, s, plural) => pluralize(n, s, { plural });
// plural without number
const p = (n, s, plural) => pluralize(n, s, { plural, number: false });
```



[0]: https://apidock.com/rails/ActionView/Helpers/TextHelper/pluralize
[1]: https://apidock.com/rails/String/pluralize
[2]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Conditional_Operator
