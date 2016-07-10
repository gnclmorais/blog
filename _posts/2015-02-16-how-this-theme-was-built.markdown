---
title: 'How this theme was built'
date: 2015-02-16 00:00:00
tags: tools process blog
layout: post
---

## Update
This post no longer refers to the current theme you are seeing right now, as I moved my blog from Ghost to Jekyll. You can still check the Ghost theme I created, [Noir](github.com/gnclmorais/Noir), and read about it. Enjoy!

---

The issue that delayed me the most to create a blog was the notion, or rather the goal, of releasing _my_ blog to the world looking like _I_ wanted, not just “good enough” after finally selecting a theme somebody else implemented from a list of dozens of them.

So it took me a while and a couple of restarts to finally have this page online, as I kept rethinking, redesigning and giving up on my own theme.

One thing that I had certain as soon as I thought about creating my own Ghost theme: it would be simple, minimalistic, and (I don’t know exactly why, but) it must be inspired in old _noir_ movies.

Technically speaking, it is quite simple, as you can [see](https://github.com/gnclmorais/Noir) for yourselves. Being a Ghost theme, I used its Casper default theme as base for my Noir theme.

#### Handlebars
Ghost uses Handlebars as its templating engine. This gives it certain advantages, such as reusable partials (small page chunks) and some improved readability on our templates. Each time of page has its own template (`index.hbs` for homepage, `post.hbs` for a single post page, etc.) and there is even the possibility to override certain Ghost behaviours, such as pagination (creating and editing `partials/pagination.hbs`).

#### Fonts
I must admit I’m fairly uneducated regarding fonts and everything font-related. I frequently request the help of close friends with a design background, to make sure I don’t miss some unforgivable details for font aficionados.

That said, I tried to use just a few fonts, but still maintaining the base design I wanted it to have. Four different fonts are being used in this theme:

- __[Montserrat](http://www.google.com/fonts/specimen/Montserrat)__ for sidebar.  
The font used for the blog’s name, _“Crushed by Code”_.
- __[Playfair Display](http://www.google.com/fonts/specimen/Playfair+Display)__ for titles.  
No special reason into choosing this font, it just gives me the classic feeling I was looking for.
- __[Open Sans](http://www.google.com/fonts/specimen/Open+Sans)__ for most of the text.  
This font has been on of my favourites for text since I’ve first found it. It’s just incredibly elegant for a free font.
- __Monospace (default)__ for code snippets.  
Every programming blog will, eventually, have code blocks in its posts.

The regular text is unusually big. Seems like the _rule of thumb_ for body text is using 16px, but that just didn’t work with Open Sans. Thus, the base font size is 18px. This provides a better reading experience, as I find myself pressing Ctrl+ on Chrome on several websites, given their absurdly small body font size. I don’t know about you, but I’m very fond of having my eyeballs an arm’s length away from my computer screen.

Given my current inexperience with fonts & lettering, and since it’s my first Ghost theme, I decided to use the available free fonts provided by Google Fonts. Besides being easy to use, hey, they’re free! :)

#### JavaScript
I envisioned this Ghost theme having no JavaScript at all. No huge background images that fill your whole screen and push the content below the “[fold](http://www.iamthefold.com)”. No image or text lazy-load. Just a lot of white space and the content.

However, some of this blog’s sidebar interactions were designed considering _hovering_ states in mind. And mobile devices don’t have such ability (although some of them emulate it, allowing you to trigger `mouseenter`/`mouseleave` events by touching). So a few lines of JavaScript were employed to create alternatives for this issue. I’ll definitely take this into account on my next version of this website and/or theme.

#### CSS
I like to use CSS pre-processors mostly for the variables feature. It’s a great relief to have the website’s palette in a few lines of code, providing a quick way to review and change them. For this matter, I chose to use Sass on this theme; I’m more experienced with LESS and never used Stylus, so Sass looked like a good option for the first version of this website.

However, I can already pinpoint a few details to improve next, on the following version. The main one being designing __and__ implementing stylesheets having _mobile first_ in mind. Start with the essencial and, as soon as you get more screen space, enhance the users’ experience.

#### Favicon
This is another matter where I have no experience whatsoever, so the current favicon is the (very) basic result of a quick online survey to understand the basis of it. It will probably be improved in the near future.

The favicon itself came from a [previous design](TODO) on my Dribbble account, which I thought it went perfectly along with the blog title, _“Crushed by Code”_.

#### Extras
One of the few details I found missing on Ghost is code highlight. I can’t say it’s a mandatory requirement for a programming blog, but at least a light code highlight is appretiated, at least I found it helpful while trying to read code.

[Lea Verou](TODO)’s amazing [Prism.js](TODO) is almost a dream come true, with several themes, programming languages supported, and the ability to add plugins to increase its features. The only thing I found it missing was line wrapping, which I’ll further investigate properly.

[Dan Eden](https://twitter.com/_dte)’s [Basehold](https://github.com/daneden/Basehold.it) tool was incredibly precious to work out the [vertical rhythm](http://24ways.org/2006/compose-to-a-vertical-rhythm) I was looking for. I can honestly save is the best/easiest piece of software I found to work this out. Just put `<link rel="stylesheet" href="http://basehold.it/24">` on your page and you can easily see if everything falls into position.
