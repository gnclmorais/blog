---
title: 'Running bash commands with git alias'
date: 2021-05-08 14:00:00
tags: [git, bash]
layout: post
---

This is a quick tip I learned recently and it allowed me to improve my `git` workflow a bit more.

Here’s a new part of my `.gitconfig`:

```
[alias]
    main = !git checkout main && git pull --no-tags
    sync = !git main && git switch -
    fuse = !git sync && git rebase main
```

This week I added these three alias to my `.gitconfig` but, if you notice, they are not “regular” alias. **The `!` at their beginning tells Git that these are not alias to Git commands, but rather bash commands.**

This gives you a simple but powerful way to chain executions, so I created three related alias that I can call depending on my goal:
- If I finished working on a branch and I want to get back to `main` and start with the most recent codebase, I’ll run `git main`. Notice the `--no-tags`, this is motivated by working on a _large_ monorepo and not needing all the tags of the packages we keep updating;
- If I’m working on a branch and I want to quickly get any changes made to our `main` branch but come back to the branch I’m in right now, I’ll call `git sync`. As a note, `git switch -` gets you back to the branch you were before you moved to the current branch you are now;
- Finally, if I want to bring the current branch I’m at up to speed with the latest code we’ve shipped, I’ll use `git fuse`. It will do everything I described on the other commands so far _and_ rebase our `main` branch onto the current branch I’m at.
