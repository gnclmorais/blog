---
title: 'DigitalOcean and Dokku to replace Heroku'
date: 2020-10-21 00:00:00
tags: [heroku, dokku, deployment]
layout: post
---

I’ve had this on my to-do list for ages but I’ve only recently looked into it. [Heroku][heroku] is a great tool to quickly deploy and set up projects but you start accumulating a hefty bill if you start moving your work out of their free plans. $7 a dyno (without counting any addons you might need, like databases) becomes unmanageable if you want to spin up multiple small projects with small traffic but without downtime (remember, Heroku only provides you a certain amount of [free hours][free-hours] per month).

To go around this, I finally started playing around with [Dokku][dokku] on [DigitalOcean][referral]. There is even an app available [straight from their platform][app], so the support seems to be solid. The premise is simple: create a $5 droplet on DigitalOcean with Dokku installed on it (which you can do straight from [here][app]) and you’ll be able to use it as your personal Heroku.

The deployment process is quite similar. Here’s a sample output of what I get when I push a Ruby on Rails app to my own Dokku droplet (a few details removed/changed for privacy reasons):

```
$ git push dokku master

Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 4 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 309 bytes | 309.00 KiB/s, done.
Total 3 (delta 2), reused 0 (delta 0), pack-reused 0
-----> Cleaning up...
-----> Building dokku-test-app from herokuish...
-----> Adding BUILD_ENV to build environment...
-----> Warning: Multiple default buildpacks reported the ability to handle this app. The first buildpack in the list below will be used.
       Detected buildpacks: multi ruby nodejs
-----> Multipack app detected
=====> Downloading Buildpack: https://github.com/heroku/heroku-buildpack-ruby.git
=====> Detected Framework: Ruby
-----> Installing bundler 2.1.4
-----> Removing BUNDLED WITH version in the Gemfile.lock
-----> Compiling Ruby/Rails
-----> Using Ruby version: ruby-2.5.8
-----> Installing dependencies using bundler 2.1.4
       Running: BUNDLE_WITHOUT='development:test' BUNDLE_PATH=vendor/bundle BUNDLE_BIN=vendor/bundle/bin BUNDLE_DEPLOYMENT=1 bundle install -j4
       Using rake 12.3.2
       …
       Using webpacker 3.6.0
       Bundle complete! 29 Gemfile dependencies, 74 gems now installed.
       Gems in the groups development and test were not installed.
       Bundled gems are installed into `./vendor/bundle`
       Bundle completed (0.79s)
       Cleaning up the bundler cache.
-----> Installing node-v12.16.2-linux-x64
-----> Installing yarn-v1.22.4
-----> Detecting rake tasks
-----> Preparing app for Rails asset pipeline
       Running: rake assets:precompile
       yarn install v1.22.4
       [1/4] Resolving packages...
       [2/4] Fetching packages...
       [3/4] Linking dependencies...
       [4/4] Building fresh packages...
       Done in 87.94s.
       Webpacker is installed 🎉 🍰
       Using /tmp/build/config/webpacker.yml file for setting up webpack paths
       Compiling…
       Compiled all packs in /tmp/build/public/packs
       Asset precompilation completed (308.00s)
       Cleaning assets
       Running: rake assets:clean
-----> Detecting rails configuration

=====> Downloading Buildpack: https://github.com/heroku/heroku-buildpack-nodejs
=====> Detected Framework: Node.js

-----> Creating runtime environment

       NPM_CONFIG_LOGLEVEL=error
       USE_YARN_CACHE=true
       NODE_ENV=production
       NODE_MODULES_CACHE=true
       NODE_VERBOSE=false

-----> Installing binaries
       engines.node (package.json):  unspecified
       engines.npm (package.json):   unspecified (use default)
       engines.yarn (package.json):  unspecified (use default)

       Resolving node version 12.x...
       Downloading and installing node 12.19.0...
       Using default npm version: 6.14.8
       Resolving yarn version 1.22.x...
       Downloading and installing yarn (1.22.10)
       Installed yarn 1.22.10
       !     node_modules checked into source control
       https://devcenter.heroku.com/articles/node-best-practices#only-git-the-important-bits


-----> Restoring cache
       - yarn cache

-----> Installing dependencies
       Installing node modules (yarn.lock)
       yarn install v1.22.10
       [1/4] Resolving packages...
       [2/4] Fetching packages...
       [3/4] Linking dependencies...
       [4/4] Building fresh packages...
       Done in 45.75s.

-----> Build

-----> Pruning devDependencies
       yarn install v1.22.10
       [1/4] Resolving packages...
       [2/4] Fetching packages...
       [3/4] Linking dependencies...
       [4/4] Building fresh packages...
       Done in 16.75s.

-----> Caching build
       - yarn cache

-----> Build succeeded!
       !     Unmet dependencies don't fail yarn install but may cause runtime issues
       https://github.com/npm/npm/issues/7494

       Using release configuration from last framework (Node.js).
-----> Discovering process types
       Procfile declares types -> release, web
-----> Releasing dokku-test-app...
-----> Deploying dokku-test-app...
 !     Release command declared: 'rake db:migrate 2>/dev/null || rake db:setup'
       D, [2020-10-24T18:04:32.244136 #13] DEBUG -- :    (2.0ms)  SELECT pg_try_advisory_lock(7827836239135902150)
       D, [2020-10-24T18:04:32.272390 #13] DEBUG -- :    (2.9ms)  SELECT "schema_migrations"."version" FROM "schema_migrations" ORDER BY "schema_migrations"."version" ASC
       D, [2020-10-24T18:04:32.281930 #13] DEBUG -- :   ActiveRecord::InternalMetadata Load (0.8ms)  SELECT  "ar_internal_metadata".* FROM "ar_internal_metadata" WHERE "ar_internal_metadata"."key" = $1 LIMIT $2  [["key", "environment"], ["LIMIT", 1]]
       D, [2020-10-24T18:04:32.290196 #13] DEBUG -- :    (0.3ms)  BEGIN
       D, [2020-10-24T18:04:32.291934 #13] DEBUG -- :    (0.3ms)  COMMIT
       D, [2020-10-24T18:04:32.292759 #13] DEBUG -- :    (0.4ms)  SELECT pg_advisory_unlock(7827836239135902150)
-----> App Procfile file found
       DOKKU_SCALE declares scale -> release=0 web=1
=====> Processing deployment checks
       No CHECKS file found. Simple container checks will be performed.
       For more efficient zero downtime deployments, create a CHECKS file. See http://dokku.viewdocs.io/dokku/deployment/zero-downtime-deploys/ for examples
-----> Attempting pre-flight checks (web.1)
       Waiting for 10 seconds ...
       Default container check successful!
-----> Running post-deploy
-----> Configuring dokku-test-app.Dokku...(using built-in template)
-----> Creating http nginx.conf
       Reloading nginx
-----> Renaming containers
       Found previous container(s) (11c86d03fec9) named dokku-test-app.web.1
       Renaming container (11c86d03fec9) dokku-test-app.web.1 to dokku-test-app.web.1.1603562703
       Renaming container (154edf6916aa) inspiring_mayer to dokku-test-app.web.1
-----> Shutting down old containers in 60 seconds
       11c86d03fec92a9f08e4d3c1dfa33ffad428d621ed951195684ab5255a529f19
=====> Application deployed:
       http://dokku-test-app.Dokku

To 151.242.42.151:dokku-test-app
   92bf7df..a5b5166  master -> master
```

P.S.: If you are interested in trying out DigitalOcean, you can use [this referral link][referral] and get $100 straight into your account to spin up some droplets and try it yourself.


## Troubleshooting

Since everyone runs into a few hiccups when we’re trying something new, I’m going to keep this section as a living document of issues I’ve ran into while playing around with Dokku. Whenever I find a new issue that I’ve solved, I’ll come back to this blog post and update it.


### virtual memory exhausted: Cannot allocate memory

This one took me a while to find a solution for, but I believe that was just because I was not using the right terms. The [documentation even has a solution][swap-solution] for it, it just took me a while to notice it. While installing the `sassc` gem, my droplet was running out of memory. This seems to happen because DigitalOcean’s basic droplets only have 512MB available, which might not be enough in a few situations. The documentation provides some instructions to follow that solved my issue, by creating a bigger [swap file][swap] (acting like extra RAM):

```bash
cd /var
touch swap.img
chmod 600 swap.img

dd if=/dev/zero of=/var/swap.img bs=1024k count=1000
mkswap /var/swap.img
swapon /var/swap.img
free

echo "/var/swap.img    none    swap    sw    0    0" >> /etc/fstab
```


## Further reading

- [The Ultimate Digitalocean Dokku Deploy Guide (Rails & other environemnts)](https://medium.com/@herowebdev1/the-ultimate-digitalocean-dokku-deploy-guide-rails-other-environemnts-d28110f3dc86)
- [The Ultimate Guide to Dokku and Ruby On Rails 5](https://medium.com/@dpaluy/the-ultimate-guide-to-dokku-and-ruby-on-rails-5-9ecad2dba4a3)


[heroku]: https://heroku.com
[free-hours]: https://devcenter.heroku.com/articles/free-dyno-hours#dyno-sleeping
[dokku]: https://github.com/dokku/dokku#dokku
[referral]: https://m.do.co/c/56af94308a04
[app]: https://marketplace.digitalocean.com/apps/dokku
[swap-solution]: http://dokku.viewdocs.io/dokku~v0.11.0/getting-started/advanced-installation/#vms-with-less-than-1gb-of-memory
[swap]: https://en.wikipedia.org/wiki/Paging#Implementations
