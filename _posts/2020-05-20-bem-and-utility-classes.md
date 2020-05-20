---
title: 'BEM and Utility Classes for a scalable CSS architecture'
date: 2020-05-20 00:00:00
tags: css
layout: post
---

I’ve been trying to define my way of writing and thinking about CSS for a while now, and I think I’ve cracked it. However, I’ve found that someone else wrote it down for me!

I’ve came across [this article][0] by [Sebastiano Guerriero][1] titled “Building a Scalable CSS Architecture With BEM and Utility Classes” that describes what I believe my current approach is. It has been evolving throughout the years but I think I finally landed on solid ground.

This approach works especially well for a _component-less_ application (i.e. no React/Vue/etc. tool that allows you to _trully_ modularise components). There is global CSS everywhere but you have to put practices into place that will help you **reduce side effects** and write **refactoring-friendly** CSS.

- **Use BEM to build logical components**  
  Use this mostly to describe the inner parts of your components (cards, navbars, footers, forms, etc.)
- **Rely on utility classes for non-crucial details**  
  This means animations, variations on fonts, margins and paddings, and other small visual attributes

This is a small summary of the [whole article][0] (please go read it, it is worth your time), but it crystallizes my view quite well. As someone that has been working in the same fast-moving startup for almost five years, I can’t tell you how many component variations we end up doing. We don’t have time to stop all development work and spend a few weeks creating a design system. We have to do this as we build features and, to be honest, that’s like trying to change parts of a car while you’re driving on the highway going somewhere.

![I don’t want to be doing this with my code…](https://media2.giphy.com/media/Wc48iceXhpvtm/source.gif)

In a situation like this, you learn how to **write CSS defensively** and to be kinder to your future self. You start seeing the problems you can encounter when you tie things together and leave no room for a fast, clean removal of things. Using BEM for the skeleton of components and finishing them off with utility classes has allowed us to quickly iterate on modules as we reuse and polish them. When I can’t rely on tools like React, Vue, and the like, this is what I go for.


[0]: https://css-tricks.com/building-a-scalable-css-architecture-with-bem-and-utility-classes
[1]: https://twitter.com/guerriero_se
