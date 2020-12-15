---
title: 'Advent of Code 2020 and Ruby'
date: 2020-12-15 00:00:00
tags: [advent-of-code, ruby]
layout: post
---

After a year filled with so much [_sameness_][sameness] and spending way too much time at home for our own sake (and others), I’m surprised that tackling the daily challenges of [Advent of Code][advent-of-code] have been keeping me happy and entertained.

As a break from my daily work with JavaScript and to keep my skills sharp, I’ve picked Ruby for it. Its performance shouldn’t be a problem for this kind of brain teasers and its syntactic sugar is always welcomed.

While trying to solve the second part of [day 14][day-14], I found myself hogging my computer over and over again, trying to validate my algorithm. I was forced to fire up Activity Monitor and kill one of my `ruby` processes over and over again, which would be consuming several gigabytes of RAM! What was happening??

Even after finding a possible solution I was happy with, this kept happening — which meant I couldn’t get the answer to the puzzle. After stopping, reflecting a bit, and probing a few parts of the code, I had an idea — and it worked!

The challenge is about reading an input file and, with the values you get, write certain numbers in memory so you can sum them all up in the end. In my case, I was using an array to emulate the program’s memory and its indexes as the memory addresses. 

This worked out well for a while… until I tried to write a value to the index `14694662143`! 💥 **This** was the culprit and, while I can’t find the maximum number of an array’s index in Ruby, I found a [few places][max-ruby-index] that seem to point out that I was _way_ above the realm of possibility.

The fix was actually quite simple:
- instead of using an array (`[]`) to keep the addresses and `arr.compact.reduce(:+)` to sum all the numbers hold,
- I just changed it to a hash (`{}`) which still allows me to keep the values and use `arr.values.reduce(:+)` to sum them.

I guess Ruby tries to allocate an array as big as your index whenever you do something like this. If the index is _quite big_, Ruby will obey you but create some headaches. A hash won’t, you’ll only allocate what you assign, nothing in between.


[sameness]: https://www.merriam-webster.com/dictionary/sameness
[advent-of-code]: https://adventofcode.com/2020/
[day-14]: https://adventofcode.com/2020/day/14
[max-ruby-index]: https://stackoverflow.com/a/6865199
