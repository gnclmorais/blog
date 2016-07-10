---
title: 'Deploy your Python bot to Heroku'
date: 2015-02-28 00:00:00
tags: python heroku deploy
layout: post
---
So you got your Python bot running flawlessly on your computer — awesome. Now what?

A bit of context for this post, beforehand. At [Hacker School](https://www.hackerschool.com) we use Zulip as our real time communication tool. In the past, a few students wrote some useful bots to provide us with important services, like the [weather](https://github.com/stephsamson/weather-bot) or [gifs](https://github.com/dariajung/zulip-gif-bot) on demand.

However, I felt that one of the most important things I use in my written communication was missing: [kaomojis](http://en.wikipedia.org/wiki/Emoticon#Japanese_style)! ＼(＾▽＾)／
So instead of wandering around without any specific task, I decided to make a [silly bot](https://github.com/gnclmorais/zulip-bot-kaomoji) that would fill up this gap.

After its development & local testing, it was time to finally deploy it and put it somewhere more reliable than my computer. [Heroku](https://heroku.com) seemed like a good place, with their free plan and simplicity of use & deploy. However, deploying a simple Python bot to it was not as simple and I thought it would be, so I felt the need to write a simple guide to easily deploy simple scripts like mine.

I’m a big fan of lists of bulletproof step to achieve something, easily digestible recipes you can follow and give you the results you expect. So I tried to make this as simple as possible.

## Prerequisites
1. __Heroku toolbelt__ (OS X users can easily install it from [Homebrew](https://github.com/Homebrew/homebrew))
1. __Git__ (I’m assuming you’re project is a git repository)
1. __Python__

## Setup instructions

#### Login
```
$ heroku login
Enter your Heroku credentials.
Email: foo@bar.com
Password (typing will be hidden):
Authentication successful.
updating...done. Updated to X.YY.Z
```

#### Create a new application
```
$ heroku create
Creating radiant-reaches-3973... done, stack is cedar-12
https://radiant-reaches-3973.herokuapp.com/ | https://git.heroku.com/radiant-reaches-3973.git
Git remote heroku added
```

You can check the newly created configuration:

```
$ git remote -v
heroku	https://git.heroku.com/zulip-bot-kaomoji.git (fetch)
heroku	https://git.heroku.com/zulip-bot-kaomoji.git (push)
…
```

You can also rename your application:

```
$ heroku apps:rename zulip-bot-kaomoji
Renaming radiant-reaches-3973 to zulip-bot-kaomoji... done
https://zulip-bot-kaomoji.herokuapp.com/ | https://git.heroku.com/zulip-bot-kaomoji.git
Git remote heroku updated
```

#### Deploy the code
```
$ git push heroku master
Counting objects: 32, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (32/32), done.
Writing objects: 100% (32/32), 9.94 KiB | 0 bytes/s, done.
Total 32 (delta 13), reused 2 (delta 0)
remote: Compressing source files... done.
remote: Building source:
remote:
remote: -----> Python app detected
remote: -----> Stack changed, re-installing runtime
remote: -----> Installing runtime (python-2.7.9)
remote: -----> Installing dependencies with pip
remote:        Collecting requests==2.5.1 (from -r requirements.txt (line 1))
remote:          Downloading requests-2.5.1-py2.py3-none-any.whl (464kB)
remote:        Collecting simplejson==3.6.5 (from -r requirements.txt (line 2))
remote:          Downloading simplejson-3.6.5.tar.gz (73kB)
remote:        Collecting zulip==0.2.2 (from -r requirements.txt (line 4))
remote:          Downloading zulip-0.2.2.tar.gz
remote:        Installing collected packages: zulip, simplejson, requests
remote:          Running setup.py install for zulip
remote:            changing mode of build/scripts-2.7/zulip-send from 600 to 755
remote:            changing mode of /app/.heroku/python/bin/zulip-send to 755
remote:          Running setup.py install for simplejson
remote:            building 'simplejson._speedups' extension
remote:            gcc -pthread -fno-strict-aliasing -g -O2 -DNDEBUG -g -fwrapv -O3 -Wall -Wstrict-prototypes -fPIC -I/app/.heroku/python/include/python2.7 -c simplejson/_speedups.c -o build/temp.linux-x86_64-2.7/simplejson/_speedups.o
remote:            gcc -pthread -shared build/temp.linux-x86_64-2.7/simplejson/_speedups.o -o build/lib.linux-x86_64-2.7/simplejson/_speedups.so
remote:
remote:        Successfully installed requests-2.5.1 simplejson-3.6.5 zulip-0.2.2
remote:
remote: -----> Discovering process types
remote:        Procfile declares types -> (none)
remote:
remote: -----> Compressing... done, 36.3MB
remote: -----> Launching... done, v3
remote:        https://zulip-bot-kaomoji.herokuapp.com/ deployed to Heroku
remote:
remote: Verifying deploy... done.
To https://git.heroku.com/zulip-bot-kaomoji.git
 * [new branch]      master -> master
```

#### Setup environment variables

If your bot relies on variables found through Python’s `os.environ`, you must set them as well in order for your script to work. Just use Heroku’s `config:set` (I have a script called `config_heroku.sh` that basically does `heroku config:set [KEY_NANE=value …]`):

```
$ ./config_heroku.sh
Setting config vars and restarting zulip-bot-kaomoji... done, v6
ZULIP_KEY:         dummyFE~$GT$EH6y&RJKT/9ly(,hjmAS
ZULIP_PRIVATE_KEY: kgyUF&F&gli8Goi9çh8g/F2&Dtfdummy
ZULIP_PRIVATE_ADR: foor@bar.com
ZULIP_ADR:         awesome-bot@awesome.place.com
```

#### Make sure there’s an instance available

Go to your [Heroku’s dashboard](https://dashboard.heroku.com/), then click on your app to see its details. Make sure you have a **1** next to that purple bar (the purple bar might not be visible if you have 0 instances — just drag it to the right).

#### Check the log

`heroku log` will show you something like this:

```
$ heroku logs
…
2015-02-28T19:46:19.422808+00:00 app[worker.1]: Traceback (most recent call last):
2015-02-28T19:46:19.422826+00:00 app[worker.1]:   File "kaomoji.py", line 106, in <module>
2015-02-28T19:46:19.422833+00:00 app[worker.1]:     zulip_usr = os.environ['ZULIP_USR']
2015-02-28T19:46:19.422864+00:00 app[worker.1]:   File "/app/.heroku/python/lib/python2.7/UserDict.py", line 23, in __getitem__
2015-02-28T19:46:19.422898+00:00 app[worker.1]:     raise KeyError(key)
2015-02-28T19:46:19.422932+00:00 app[worker.1]: KeyError: 'ZULIP_ADR'
2015-02-28T19:46:20.112852+00:00 heroku[worker.1]: Process exited with status 1
2015-02-28T19:46:20.119305+00:00 heroku[worker.1]: State changed from up to crashed
2015-02-28T19:52:20.992952+00:00 heroku[api]: Set ZULIP_ADR, ZULIP_KEY, ZULIP_PRIVATE_ADR, ZULIP_PRIVATE_KEY config vars by foo@bar.com
2015-02-28T19:52:20.992952+00:00 heroku[api]: Release v6 created by foo@bar.com
2015-02-28T19:52:21.141191+00:00 heroku[worker.1]: State changed from crashed to starting
2015-02-28T19:52:25.258328+00:00 heroku[worker.1]: Starting process with command `python kaomoji.py`
2015-02-28T19:52:25.859480+00:00 heroku[worker.1]: State changed from starting to up
```
Note the top errors when Heroku tried to start the bot (but didn’t have the required environment variables) and the last five lines, where we set those variables and restart the instance.

#### Conclusion
So this should be enough to deploy, config & run a simple Python script. I’ll keep this guide as up to date as possible, since I’ll be using Heroku a lot more in the next months and I’m just learning how to use it. If you want to discuss something about this, ping me [on Twitter](https://twitter.com/gnclmorais).  
(￣▽￣)ノ

#### Resources
- https://devcenter.heroku.com/articles/git
- http://amertune.blogspot.com/2014/04/tutorial-create-reddit-bot-with-python.html
