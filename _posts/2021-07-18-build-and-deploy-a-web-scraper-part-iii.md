---
title: 'Build and deploy a web scraper in JavaScript with Puppeteer, part 3'
date: 2021-07-18 09:00:00
tags: [javascript, puppeteer]
layout: post
---

_This is the third post of a 3-part project that will show you how to build a web scraper, add notifications, deploy it and make sure it runs regularly. This is the series:_
`
1. [Write the scraping script](https://blog.gnclmorais.com/build-and-deploy-a-web-scraper)
1. [Add SMS notifications](https://blog.gnclmorais.com/build-and-deploy-a-web-scraper-part-ii)
1. Deploy and run it automatically _(this post)_

---

Welcome back! Now that we have a script that checks a page and we added SMS notifications, let’s make sure we get this up and running — executing our script regularly.


## Create a Heroku account

This tutorial relies on Heroku for the simple fact that it allows us to be abstracted from most server-side hassle and we can focus on the project at hands. If you have the project we’ve been building tracked with Git, this will be smooth.

Make sure you have a Heroku account and install their [CLI](https://devcenter.heroku.com/articles/heroku-cli#download-and-install). Then [log in](https://devcenter.heroku.com/articles/heroku-cli#getting-started) through it so that you have access to your Heroku account using terminal commands.


## Deploy your app

After making sure you’re on the project folder, run `heroku create` to make a new empty application on Heroku. This doesn’t deploy your code yet.

Before we send our code to Heroku, make sure you have the following lines on your `package.json` — it will help us to run our script with the last amount of work:
```json
{
  "scripts": {
    "start": "node index.js"
  }
}
```

To send your code to be run by Heroku, execute the following: `git push heroku main`. This will take a while and will output a lot of text, keeping you up to date with the remote state of the dyno Heroku is setting up for you. At the end, you’re greeted with a message with a link, something like `https://hidden-socks-12321.herokuapp.com/ deployed to Heroku`. In our case, this is not important since we don’t have a page to look at — we’ll get an SMS notifications whenever we find what we want.


## Schedule regular jobs

Our script is on Heroku, so we’re just missing one last step: making sure it runs regularly. Head out to [your dashboard](https://dashboard.heroku.com/apps) where you’ll see all your current applications. Find the one we just created and select it.

On you app’s page, go to “Resources” then click “Find more add-ons”. You’ll be greeted with a long page full of possible addons, but we’re looking for one on the [Dynos](https://elements.heroku.com/addons#dynos) section. Find [Heroku Scheduler](https://elements.heroku.com/addons/scheduler) and click on it. You’ll see a button near the top right corner of your screen that says “Install Heroku Scheduler”, press it and, on the next screen, type the name of your app and click “Submit Order Form” — don’t worry, this addon is free.

The addon is now enabled and we can see the options we have available. You should be back on your app’s page, on the Resources tab, where you should see your newly installed addons. Click on it to access its configuration page.

On this new page, click “Create job” to show a right-side panel where you can pick if you want to run your script every:
- 10 minutes
- Every hour at 00, 10, 20, 30, 40 or 50 minutes in the hour
- Every day at a certain time (in 30 minutes increments)

Pick the frequence you want, pass the command we have to run the script (`npm start`) and click “Save Job” at the bottom.


## One last step, a missing buildpack

Heroku has this concept of _buildpacks_ that they define as “(…) scripts that are run when your app is deployed. They are used to install dependencies for your app and configure your environment.”

For this particular project, there is one we must add to have access to Puppeteer, created by [Jon Tewksbury](https://github.com/jontewks). It will help Heroku installing all the necessary dependencies (like Chrome) so that our script runs without problems.

On your app’s dashboard page, go to the Settings tab and scroll down to the section Buildpacks. Click “Add buildpack” and paste `https://github.com/jontewks/puppeteer-heroku-buildpack` in the text input of the modal you get. Click “Save changes” and you’re ready to go.

Buildpacks are used the next time our apps are deployed, so just to be sure everything is in place, let’s trigger a redeploy of our app by pushing an empty commit:
```bash
git commit --allow-empty -m "Trigger deploy after buildpack" && git push heroku main
```


## Conclusion

That’s it! You have now created, deployed and scheduled a web scraper that notifies you with an SMS whenever it finds what it is looking for! There are numerous other ways to do what we’ve accomplished, however, I’ve found this the most [Pareto](https://en.wikipedia.org/wiki/Pareto_principle)-like way of spinning something up whenever I have the need to automate checking up on a website. I’ve optimised for simplicity and speed of MVP on these blogs, not for flexibility or power.

As a last tip, if you are looking for logs to see what is happening with your app from time to time or you’re trying to debug something with it, on your app’s dashboard you should see a “More” button on the top right corner. Click on it to expand the options available and you’ll see a “View logs” item. That’s where you can take a closer look at the logs Heroku collects from your running applications.
