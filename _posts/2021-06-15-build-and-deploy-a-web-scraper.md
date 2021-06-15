---
title: 'Build and deploy a web scraper in JavaScript with Puppeteer, part 1'
date: 2021-06-15 09:00:00
tags: [javascript, puppeteer]
layout: post
---

_This is the first post of a 4-part project that will show you how to build a web scraper, add notifications, deploy it and make sure it runs regularly. This is the series:_

1. Write the scraping script _(this post)_
1. Add SMS notifications _(to be release)_
1. Deploy and run it automatically _(to be release)_
1. Bonus: add email notifications _(to be release)_

---

I’ve had a few situations in the past where I was waiting for something to get updated on a website and just kept refreshing the page every so often… But when you don’t know when that update is going to happen, this can get tedious and hey, we’re programmers, we can build something to do this for us. 😃

_“[Puppeteer](https://www.npmjs.com/package/puppeteer) is a Node library which provides a high-level API to control Chrome”_ and it’s the one I usually use just because it makes building a simple web scraper super simple. Let’s dig in and build a Minimum Viable Product that, for the sake of this example, grabs the top news from The New York Times’ [_Today’s Paper_](https://www.nytimes.com/section/todayspaper).


## Project start

Begin by creating a `package.json` that will hold the project’s dependencies. You can use `npm init` for this, but for simplicity’s sake, I’ll create a stripped-down version:

```js
// package.json
{
  "name": "web-scraper-with-puppeteer",
  "version": "1.0.0",
  "private": true
}
```

Now we add our only dependency, Puppeteer. Run this on the terminal:

```bash
npm install puppeteer
```

Your `package.json` has changed a bit now, here’s the difference:

```diff
 {
   "name": "web-scraper-with-puppeteer",
   "version": "1.0.0",
-  "private": true
+  "private": true,
+  "dependencies": {
+    "puppeteer": "^9.1.1"
+  }
 }
```

Let’s start with our main script now. Open up a brand new `index.js` and write the following:

```js
// index.js
const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({
    headless: false,
  });
  const page = await browser.newPage();

  await page.goto(
    'https://nytimes.com/section/todayspaper'
  );
  await browser.close();
})();
```

For now, this is a simple script that you can run right now with `node index.js` in order to see if everything is going well so far. You should see a Chrome window opening up (because we specified `headless: false`) and closing as soon as the page stops loading. So far so good! Let’s now grab from the DOM the first article on the page.

Add the next lines to your script to grab the first article and just output its HTML, so we can see if we’re retrieving the right thing:

```diff
   await page.goto(
     'https://nytimes.com/section/todayspaper'
   );
+
+  const firstArticle = await page.$eval(
+    'article:first-of-type',
+    e => e.outerHTML
+  );
+
+  console.log(firstArticle);
+
   await browser.close();
 })();
```

Run your script with `node index.js` and you should see a lot of HTML inside an `<article>` tag on your console. We’re almost there!

Now, we don’t want the full article, only its headline and summary. Looking closer at the HTML we get, we see an `h2` and the first `p` that look promising. Let’s refactor our code a bit to have `firstArticle` as a variable we can use, create a function to be used for both the header and the summary, and pluck both of them to show on the console:

```diff
     'https://nytimes.com/section/todayspaper'
   );
 
-  const firstArticle = await page.$eval(
-    'article:first-of-type',
-    e => e.outerHTML
-  );
+  const firstArticle = await page.$('article:first-of-type');
+
+  const getText = (parent, selector) => {
+    return parent.$eval(selector, el => el.innerText);
+  };
+
+  const header = await getText(firstArticle, 'h2');
+  const summary = await getText(firstArticle, 'p:first-of-type');
 
-  console.log(firstArticle);
+  console.log(`${header}\n${summary}`);
 
   await browser.close();
 })();
```

Go ahead, run that on the terminal and you show see two lines, the top on as the header and the bottom one as the summary of the article!

To be honest, that’s it! 🎉 **A web scraper doesn’t need to be fancy or complicated**, it really depends on what you are trying to fetch from a page. I had one running for a few days a while back (which I’ll write about on a following article) and it was basically doing thigs on another page, just checking if a specific string of text has changed already or not.

Having said that, there is _so much more_ you can do with Puppeteer — the sky is the limit. Check [their documentation](https://devdocs.io/puppeteer/) to see the available methods, [official examples](https://github.com/puppeteer/examples) of wild things you can use it for, and you can even use it to [automate performance work](https://addyosmani.com/blog/puppeteer-recipes/)!

See you around soon for the second part of this article…
