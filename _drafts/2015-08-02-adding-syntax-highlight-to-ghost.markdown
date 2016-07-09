---
title: 'Adding syntax highlight to Ghost'
date: 2015-08-02 00:00:00 
tags: javascript prism markdown syntax-highlighting
layout: post
---
Have you ever stopped and thought about something we (developers) take for granted, like [syntax highlighting](https://en.wikipedia.org/wiki/Syntax_highlighting)? We rely so much on it that I believe everyone will consider it a mandatory feature on any kind of text editor or IDE we might think about picking up.

I’ve read my share of articles pro and against it, but coming from a background in Computer Engineering, where I had to write code for several written tests using just pen & paper, I’m thankful for every little bit of help I can get.

Thus, enters syntax highlighting. While building this [blog theme](https://github.com/gnclmorais/noir), one of the personal requirements I set up for it was proper code support. However, I did not want to build it myself, as I believe it would take longer than estimated and would end up demotivating me from ever finishing the Ghost theme.

Luckily, you can always count with the web to provide you with great tools for virtually anything, allowing you to start building on the [shoulders of giants](https://en.wikipedia.org/wiki/Standing_on_the_shoulders_of_giants). In this case, I have [Lea Verou](https://twitter.com/leaverou) and her [Prism.js project](http://prismjs.com) to thank for.

As you can see on the [basic usage](http://prismjs.com/#basic-usage) example provided in the project page, using this tool to provide syntax highlighting to your website is as simple as including the JavaScript and the CSS files on your page, and you’re good to go!

However, there is a bit of wisdom I can add to all of this. To get the right syntax highlighting, you __must provide the code language beforehand__. You can read more about it on the [basic usage description](http://prismjs.com/#basic-usage), but the snippets provided are in HTML, and if you’re using Ghost as your blogging platform (like myself), you are probably writing these articles using Markdown, not HTML. How do you provide the code language then?

Well, the same way you do it on [GitHub](https://help.github.com/articles/github-flavored-markdown/#syntax-highlighting), for example. Just wrap your code with \`\`\` and add the language of your choice right after it, like the following:

```
 ```javascript
 // code
 ```
```

You can check all the languages it supports [here](http://prismjs.com/#languages-list), and the best thing is that you can cherry-pick just the languanges you want to include on your page.
