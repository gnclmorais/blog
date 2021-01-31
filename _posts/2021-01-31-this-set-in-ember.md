---
title: '`this.something = 'else'` vs `this.set('something', 'else')` in Ember'
date: 2021-01-31 00:00:00
tags: [ember]
layout: post
---

I’ve been getting deeper into Ember.js in my new job, and I learn something new every day. Sometimes, things you’ve been using here and there are a bit mysterious. Eventually, either you or someone else notices them and raises insightful questions, like Michal asked on [Ember’s Dsicord channel](https://discord.com/channels/480462759797063690/480523424121356298/803933292444909610). The question was basically this:

> What’s the difference between `this.something = 'else'` and `this.set('something', 'else')` in tests?

The answer is surprisingly simple (at the surface, we don’t need to get deep into Ember’s reactivity): `this.set` is the way you have to trigger re-render in test. For example, if you set a value with `this.value = 'test'` and render a component that will use that `this.value`, changing the value of `this.value` now **will not** re-render the partial. If, instead, you set that value with `this.set('value', 'test')`, whenever you change it again with `this.set('value', 'something else')`, the template will automatically re-render.

Small caveat (like everything in like): re-rendering will only occur if the value you are reassigning is different that the value previously there, [as it seems](https://discord.com/channels/480462759797063690/480523424121356298/804027937397276690).
