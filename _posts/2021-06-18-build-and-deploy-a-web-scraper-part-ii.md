---
title: 'Build and deploy a web scraper in JavaScript with Puppeteer, part 2'
date: 2021-06-18 09:00:00
tags: [javascript, puppeteer]
layout: post
---

_This is the second post of a 3-part project that will show you how to build a web scraper, add notifications, deploy it and make sure it runs regularly. This is the series:_

1. [Write the scraping script](https://blog.gnclmorais.com/build-and-deploy-a-web-scraper)
1. Add SMS notifications _(this post)_
1. Deploy and run it automatically _(to be release)_

---

Welcome back! Now that we have a basic script that checks for the data on a page, let’s add an SMS notification that will inform us of the current headline we find.


## Create a Twilio account

We’re going to use Twilio for this, they have a free API that we can quickly reach out to and send a few SMS through it. Head out to https://twilio.com/try-twilio and create your account (if you already have one, read along).

After creating your account and logging in, we want to create a new project (sometimes also called _account_ on their platform). These are containers for your applications (nothing to do with Docker, though).

Look for the _Create New Account_ button or go straight to [twilio.com/console/projects/create](https://www.twilio.com/console/projects/create). Pick a name for your account and click _Verify_:

![New account/project on Twilio](/images/posts/2021-06-18--01--new-account.png)

The next screen asks you to verify yourself. Yeah, it’s a bit annoying, but this also helps them to prevent some less benevolent agents from using their platform, so it’s cool.

![New account/project on Twilio](/images/posts/2021-06-18--02--verify-phone-number.png)

Write your phone number down, go to the next page, type the verification code you got on your phone, submit and you’re almost there! The next screen asks us for some goals, in order to send us to the right place and the right features we intend to use. I’ve picked the following for this example:

![Answers to Twilio welcome screen](/images/posts/2021-06-18--03--answers-to-twilio.png)

After this, we are finally greeted with our account dashboard and… there is a lot of stuff. 😅 Luckily, we’re only here for one thing: a phone number to send SMS from. If you scroll down a bit, you should see a _Get a Twilio trial phone number_ header. Click the button below it, _Get a trial phone number_. You should get a modal with a suggested phone number.

![Modal with a suggested phone number](/images/posts/2021-06-18--04--suggested-phone-number.png)

There is nothing special with the phone number we’re looking for, so grab the first one you get by clicking on _Choose this Number_. Press _Done_ on the next modal and we have now a number! We’re very close to being able to send messages…


### Small gotcha

In order to prevent free accounts from being used to spam people, you’ll only be able tos end SMS to verified numbers. You can check the only one you got so far (the one you used to sign up) at [twilio.com/console/phone-numbers/verified](https://www.twilio.com/console/phone-numbers/verified). If there are other numbers you want to message through your script, you should add them here now.


## Integrate Twilio in our script

We’re ready to use Twilio and send some SMS. To do that, we’ll need their npm package, so install it by running `npm install twilio` (if you have npm 5 of above, this should save the package on your `package.json`).

Start now by creating a separate file where we’ll put out notification code, `notify.js`. This will be our base code to send notifications:

```js
const twilio = require('twilio');

module.exports = {
  sendSMS(msg, toNumber) {
    const fromNumber = process.env.TWILLIO_PHONE_NUMBER;
    const accountSid = process.env.TWILLIO_ACCOUNT_SID;
    const authToken  = process.env.TWILLIO_AUTH_TOKEN;

    const client = twilio(accountSid, authToken);

    return client.messages
      .create({
         body: msg,
         from: fromNumber,
         to: toNumber,
       })
      .then(message => console.log(message.sid))
      .done();
  }
}
```

The code above is almost straight from [their documentation](https://www.twilio.com/docs/sms/quickstart/node) (which is excellent, by the way!) and I’m always amazed about how little code you need to send SMS!

You can also notice how we have three lines accessing `process.env.*`. You do this in Node to access environment variables, i.e., values that you can set on the fly when you run the command. Think of it as function arguments, but for Node scripts.

With our notification module ready, go back to your `index.js` and we’ll import it to give it a spin:

```diff
 const puppeteer = require('puppeteer');
+const { sendSMS } = require('./notify');
+
+const toNumber = process.env.MY_PHONE_NUMBER;

 (async () => {
   const browser = await puppeteer.launch({
@@ -19,7 +22,7 @@ const puppeteer = require('puppeteer');
   const header = await getText(firstArticle, 'h2');
   const summary = await getText(firstArticle, 'p:first-of-type');

-  console.log(`${header}\n${summary}`);
+  sendSMS(`${header}\n${summary}`, toNumber);

   await browser.close();
 })();
```

The text we were passing to `console.log` we’ll not send to our phones with the new `sendSMS` method we created. Don’t forget to also get the number you are sending this message to (should be the same you used to register to Twilio) through an environment variable as well.


## Run the code

We have everything in place now, there are just a few consideration to have before heading to a terminal and running all of this.

The `process.env.*` variables we set in our code must be provided by us in some way — I say this becuase we can do it in several ways, but we’ll follow the simplest. When running our `index.js` script, we’ll pass these environment variables inline. Here’s an example (make sure you use your own credentials that you get from [the console page](https://www.twilio.com/console)):

```bash
TWILLIO_PHONE_NUMBER="+19293949596" \
TWILLIO_ACCOUNT_SID=ACDCadbfe2ce33c691a6dcfdce6e3617bb \
TWILLIO_AUTH_TOKEN=face0a31ee17c4a2c9b3c0vfefeffa1f \
MY_PHONE_NUMBER="+447663342007" \
node index.js
```

The backslashes allow us to split a long command into multiple lines, for readability’s sake. Instead of harcoding this sensitive data into our code, we extracted it to configurable variables. This will permit us to easily set up an integration pipeline in the future that will run this script automatically, and also to make this project reusable by other people with their own Twilio credentials.

And that’s it for the time being! You now have a script that send you an SMS with dynamically fetched data.

See you around soon for the third part of this article…
