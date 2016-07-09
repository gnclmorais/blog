---
title: 'Jekyll & Heroku: the simple way'
date: 2016-04-25 00:00:00 
tags: blog heroku jekyll deployment tutorial
layout: post
---
This will be a simple, step-by-step guide from going to 0 to a live Heroku instance running a Jekyll blog you just created. All the tutorials I’ve found were missing a couple of steps, so I felt that something a little bit more detailed would be useful for other people. Who likes to spend time trying to figure out how to deploy stuff, right?

## Prerequisites
- Make sure you have [Jekyll installed](https://jekyllrb.com/docs/installation/).
- Make sure you have [Bundler installed](https://devcenter.heroku.com/articles/bundler).
- Make sure you have a [Heroku account](https://signup.heroku.com/login).
- Make sure you have the [Heroku toolbelt](https://toolbelt.heroku.com) installed and you are [logged in](https://devcenter.heroku.com/articles/getting-started-with-ruby#set-up).

## 1. Create a local Jekyll blog
To create a new Jekyll blog, [their documentation](https://jekyllrb.com/docs/quickstart/) is probably the best source to read, so I’ll just put here the TL;DR version you can write on your terminal:
```bash
$ jekyll new adventuretime
$ cd adventuretime
```

## 2. Make it a Git repository
Having your project as a Git repository is the [default option](https://devcenter.heroku.com/articles/git) to deploy code to Heroku (besides the other obvious advantages, like tracking changes), so let’s just start:
```bash
$ git init
$ git add .
$ git commit -m 'My first Jekyll blog about Adventure Time.'
```

## 3. Get your settings ready for deployment
Let’s preemptively do a bit of settings tweaking. There are a few caveats regarding deploying, building, and serving from Heroku.

### Jekyll
We need a `Gemfile` file so that Heroku knows what to install before running anything we tell it to. In our case, we only need the following:
```
source 'https://rubygems.org'
gem 'jekyll'
```

This tells Bundler to [manage our dependencies](https://devcenter.heroku.com/articles/bundler). Heroku also requires the `Gemfile.lock` file, so you’ll need to add it to Git as well:
```bash
$ bundler install
$ git add Gemfile Gemfile.lock
& git commit -m 'Get dependencies in line using Bundler.'
```


### Heroku
I can’t do better that [Heroku’s page](https://devcenter.heroku.com/articles/procfile) on this, but basically you need a `Procfile` that tells Heroku how to run your app. There’s a lot of stuff you can do with this file, but in our case we’re only interested on the `web` process.

Writing `web: …` on a Procfile will tell Heroku to launch whatever is after the colon and the `web` process type will allow your process to receive HTTP traffic from Heroku’s routers.

In our case, we’ll need something like this inside `Procfile`:
```
web: jekyll serve --no-watch --port $PORT --host 0.0.0.0
```
- `jekyll serve` simply runs a development server.
- `--no-watch` tells the server to stop watching for changes.
- `--port $PORT` binds the server to listen on the specified port. The `$PORT` variable is set by Heroku and it’s the port locally binded to the external world.
- `--host 0.0.0.0` will bind Jekyll to all available IPs, rather than just to `localhost` (more info about this issue [here](https://github.com/jekyll/jekyll/issues/3907)).

Don’t forget to commit this file as well:
```bash
$ git add Procfile
$ git commit -m 'Add Procfile required by Heroku.'
```

Since we’re deploying this to Heroku, there’s a catch I’ve found while doing it. Just as [this issue suggests](https://github.com/jekyll/jekyll/issues/2938#issuecomment-56237068), we need to tell Jekyll to exclude a folder when building the static assets to serve. Just add the following to the end of your `_config.yml`:
```
exclude:
  - vendor
```
Oh, and commit that:
```bash
$ git commit -am 'Exclude /vendors.'
```


## 4. Create a Heroku instance
Alright, now we just need to tell Heroku to spin up a new [dyno](https://devcenter.heroku.com/articles/dynos) where we can deploy our soon-to-be-up-and-running Jekyll blog. Their Toolbelt makes everything accessible:
```bash
$ heroku create --buildpack heroku/ruby
Creating app... done, stack is cedar-14
Setting buildpack to heroku/ruby... done
https://pacific-lowlands-98725.herokuapp.com/ | https://git.heroku.com/pacific-lowlands-98725.git
```
Setting a [`--buildpack`](https://devcenter.heroku.com/articles/buildpacks) when creating an instance will tell Heroku we want (in this case) Ruby support ready by default on our dyno.


## 5. Deploy your blog
Finally, now that we have our blog created, our Heroku instance available to run our code, and all the bits & bobs configured for a smooth deploy, we just need to send them our code, running the following on the terminal:
```bash
$ git push heroku master
Counting objects: 37, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (34/34), done.
Writing objects: 100% (37/37), 10.50 KiB | 0 bytes/s, done.
Total 37 (delta 5), reused 0 (delta 0)
remote: Compressing source files... done.
remote: Building source:
remote:
remote: -----> Using set buildpack heroku/ruby
remote: -----> Ruby app detected
remote: -----> Compiling Ruby
remote: -----> Using Ruby version: ruby-2.2.4
remote: -----> Installing dependencies using bundler 1.11.2
remote:        Running: bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin -j4 --deployment
remote:        Fetching gem metadata from https://rubygems.org/............
remote:        Fetching version metadata from https://rubygems.org/...
remote:        Fetching dependency metadata from https://rubygems.org/..
remote:        Installing colorator 0.1
remote:        Installing ffi 1.9.10 with native extensions
remote:        Installing sass 3.4.22
remote:        Installing rb-fsevent 0.9.7
remote:        Installing kramdown 1.10.0
remote:        Installing liquid 3.0.6
remote:        Installing mercenary 0.3.6
remote:        Installing rouge 1.10.1
remote:        Using bundler 1.11.2
remote:        Installing safe_yaml 1.0.4
remote:        Installing jekyll-sass-converter 1.4.0
remote:        Installing rb-inotify 0.9.7
remote:        Installing listen 3.0.6
remote:        Installing jekyll-watch 1.3.1
remote:        Installing jekyll 3.1.3
remote:        Bundle complete! 1 Gemfile dependency, 15 gems now installed.
remote:        Gems in the groups development and test were not installed.
remote:        Bundled gems are installed into ./vendor/bundle.
remote:        Bundle completed (18.93s)
remote:        Cleaning up the bundler cache.
remote:
remote: ###### WARNING:
remote:        You have not declared a Ruby version in your Gemfile.
remote:        To set your Ruby version add this line to your Gemfile:
remote:        ruby '2.2.4'
remote:        # See https://devcenter.heroku.com/articles/ruby-versions for more information.
remote:
remote:
remote: -----> Discovering process types
remote:        Procfile declares types     -> web
remote:        Default types for buildpack -> console, rake
remote:
remote: -----> Compressing...
remote:        Done: 19.6M
remote: -----> Launching...
remote:        Released v4
remote:        https://pacific-lowlands-98725.herokuapp.com/ deployed to Heroku
remote:
remote: Verifying deploy.... done.
To https://git.heroku.com/pacific-lowlands-98725.git
 * [new branch]      master -> master
```
This will push the local code we have to our newly created dyno, run the appropriate process from our `Procfile` (in our case, `web`), and hopefully you’ll be able to just type `heroku open` and see your newly created blog, up & running. You can also type `heroku logs -t` to see what’s happening on your active dyno.

### Note
Although we just put a blog online and we’re able to see it and share its link, we can’t exactly say it is ready for production times. Serving directly from Jekyll is not ideal, we could just use it to build the pages and then use a more efficient server to serve our pages. This will be approach in an upcoming blog post, so stay tuned!
