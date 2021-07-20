---
title: 'Run copied CLI commands with a leading "$" sign safer'
date: 2021-07-20 10:00:00
tags: [bash]
layout: post
---

I recently came across [Stefan’s tip](https://www.stefanjudis.com/blog/how-to-run-commands-with-a-leading-usd-sign) on how to run copied commands with a leading dollar sign and I thought it was a great idea! However, this heads-up caught my eye:

> Use at your own risk. 🤓 Before implementing any functionality that makes running copied code easier, be aware that the internet's a bad place. There's always a chance that a command has malicious intent or [even includes hidden commands](http://thejh.net/misc/website-terminal-copy-paste).

This made me think: maybe I can build upon his example and add a small layer of protection, to prevent accidental errors when working a bit absentmindedly — we all do that from time to time.


## Ask for confirmation before

Follow his tutorial and, when you get to the part when you’re writing the script, instead of simply executing the commands it gets, ask the user for _explicit_ confirmation before proceeding. Use this as the content of your `$` executable:

```bash
#!/bin/zsh
read -p "Are you sure you? [y/N]: " -n 1 -r
echo # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    exec "$@"
fi
```

I [used someone’s else suggestion](https://stackoverflow.com/a/1885534/590525) in order to ask for confirmation, but this is a simple way of adding a small confirmation step. Anything that is not `y` or `Y` will skip the execution. This will hopefully help with the [hidden commands issue](http://thejh.net/misc/website-terminal-copy-paste) Stefan made me aware of.
