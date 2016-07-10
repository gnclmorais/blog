---
layout: post
title:  "Makefiles are for the web"
date:   2016-05-30 07:18:53 +0100
category: test
tags: [markdown, first, layout]
---

I still remember how confused I was several years ago, when I was first introduced to [Makefiles](http://en.wikipedia.org/wiki/Makefile). Together with the [Make](http://en.wikipedia.org/wiki/Make_%28software%29) utility, we can compile & build software from its source files. Back in university, this was a necessary tool in several classes, specially the ones dealing with C or C++. As soon as I left these languages behind and moved towards Java, Python and JavaScript, I lost contact with all this mess… until a few months ago, when [a friend of mine](https://twitter.com/coutoantisocial) started writing his own.

Funny enough, looking at his makefiles didn’t look confusing anymore. Actually, everything looked quite… logic and organised. I started looking at makefiles as good ways to keep common commands (some rather complex and/or long) organised and in a single place, easily invoked and catalogued.
They started to look a good alternative to stop going though my terminal command history (using `ctrl+r`) to find the right command(s) to run and start putting them in a single place. A place where I could give simple & memorable aliases to long, boring & complex commands, and run those commands using the newly created aliases.

Concerning web development (mostly front-end), if you’re already using [Grunt](http://gruntjs.com), [Gulp](http://gulpjs.com), [Broccoli](http://broccolijs.com) or [npm scripts](https://docs.npmjs.com/misc/scripts), you might not need this. But I’ve already found myself in situations where my projects had little or none dependencies, like [SCSScandinavian Flags](https://github.com/gnclmorais/scsscandinavian-flags). This project is (S)CSS-only, so the only real dependency is [Sass](http://sass-lang.com). If you already played around with Sass, you know how [long the commands can get](http://sass-lang.com/documentation/file.SASS_REFERENCE.html#using_sass); but, more than long, this is something I 1) don’t want to keep in mind all the time and 2) don’t want to browser around my terminal command history looking for the right commands every time I want to compile or watch my SCSS files.

The best way I’ve found to fix this was to write a [`Makefile`](https://github.com/gnclmorais/scsscandinavian-flags/blob/master/Makefile) for this project:

```
build:
	sass scss/main.scss:dist/flags.css --style compressed

watch:
	sass --watch scss/main.scss:dist/flags.css --style compressed

test:
	make
	open "test/index.html"
	make watch

clean:
	rm -rf dist/ .sass-cache/

# More info about this hack:
# http://chrisadams.me.uk/2012/10/21/understanding-make/
.PHONY: test
```

---

Let’s analyse each block:

### `build`
Simple command where I define the _source:destination_ of the _SCSS-to-CSS_ compilation. The `--style` flag defines the [CSS output style](http://sass-lang.com/documentation/file.SASS_REFERENCE.html#output_style).

### `watch`
Much like the `build` rule, but I want to recompile the CSS every time my Sass files change.

### `test`
This one is just a personal shortcut, to automatically open the browser on a test page I created. It’s very useful while debugging.

### `clean`
Cleans compiled CSS files (which can always be created by compiling the Sass files) and [Sass’ cache](http://sass-lang.com/documentation/file.SASS_REFERENCE.html#cache_stores).

So next time you’re tempted to grab Grunt, Gulp, or any other modern day task runner, remember Unix’s tools and its old, time-tested wisdom.
