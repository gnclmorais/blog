---
title: 'Makefile rule for Jekyll drafts'
date: 2020-03-08 00:00:00
tags: [jekyll, makefile]
layout: post
---

I’ve previously written about my [fondness for Makefiles](/makefiles-are-for-the-web), so it feels on brand that I continue talking about it.

My latest idea was to leverage these files for blogging. Jekyll posts follow a simple [`YEAR-MONTH-DAY-title.MARKUP` format](https://jekyllrb.com/docs/posts/), which seemed perfect to be automated. In an ideal world, I would like to just start writing and my computer to figure out these details.

Since I had previously outsourced some Jekyll development commands to my own Makefile (you can check the source code [here](https://github.com/gnclmorais/blog/blob/gh-pages/Makefile)), I guessed this could be another one. I’ll leave you with my final result for now and I’ll explain it afterwords:

```make
FILENAME:=./_drafts/$(shell date +'%Y-%m-%d')-.md
define post
---
title: ''
date: $(shell date +'%Y-%m-%d') 00:00:00
tags:
layout: post
---
endef
export post
draft:
  touch $(FILENAME)
  echo "$$post" > $(FILENAME)
```

If you put this on a Makefile and run `make draft`, this is what you get:

```bash
goncalomorais@amadeus:~/D/g/_/blog|gh-pages✓
➤ make draft
touch ./_drafts/2020-03-08-.md
echo "$post" > ./_drafts/2020-03-08-.md
```

Let’s see what does this create:

```bash
goncalomorais@amadeus:~/D/g/_/blog|gh-pages⚡?
➤ git status
On branch gh-pages
Your branch is ahead of 'origin/gh-pages' by 1 commit.
  (use "git push" to publish your local commits)

Untracked files:
  (use "git add <file>..." to include in what will be committed)
  _drafts/2020-03-08-.md

nothing added to commit but untracked files present (use "git add" to track)

goncalomorais@amadeus:~/D/g/_/blog|gh-pages⚡?
➤ cat _drafts/2020-03-08-.md
---
title: ''
date: 2020-03-08 00:00:00
tags:
layout: post
---
```

What does this all mean, though? Let’s break it down bit by bit to have a better understanding of why we need them.


---


```make
FILENAME:=./_drafts/$(shell date +'%Y-%m-%d')-.md
```
The line above allows us to generate a file with the format `YYYY-MM-DD-.md` on the `_drafts` folder and save it on a _make_ variable (not a regular shell variable), which a [kind soul on StackOverflow](https://stackoverflow.com/a/41316280/590525) made at point to differentiate. 


```make
define post
---
title: ''
date: $(shell date +'%Y-%m-%d') 00:00:00
tags:
layout: post
---
endef
export post
```
Next, we’re using a nice way to [define a multiline string on Makefiles](https://gist.github.com/azatoth/1030091), which allows us to store it on a variable so we can later insert it on the draft file we just created.


```make
draft:
  touch $(FILENAME)
  echo "$$post" > $(FILENAME)
```
Finally, the bow that wraps everything nicely. The rule `draft` now runs two simple commands:
- `touch` sets the modification and access times of files, but if any file does not exist, it gets created;
- `echo` _technically_ display a line of text, but the `>` operator is redirecting the output to the new file we just created, filling it in with the Jekyll post header.


That’s it, we’re now able to run `make draft` and quickly create a draft file for today’s blog entry. This post was created like that!
