---
title: 'Promises from Promises'
date: 2015-06-30 00:00:00 
tags: javascript es6 promises bluebird
layout: post
---
Lately I’ve been pushing myself to make the most out of all the free time I currently have. A big part of that revolves around trying to come up with side projects and new tools & technologies to learn and integrate on them. One of these novelties for me has been JavaScript’s [Promises](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Promise), an upcoming improvement to the common [_callback hell_](http://callbackhell.com) issue. Since Promises are part of the not-yet-final ES6 standard, it is a good practice to use some kind of polyfill or ES6-compliant library to make sure this feature is safely available, something like [Bluebird](https://github.com/petkaantonov/bluebird).

While working on my [latest pet project](https://github.com/gnclmorais/wherewasi), I stumbled upon a situation where I wanted to generate several promises as a follow-up of a first promise. Basically, the first promise would get me a certain value that I required in order to know how many other promises I had to generate. I’ll highlight the key aspects of the code for this:

```javascript
function getAllPlaces(accessToken, limit, sort) {
  var offset = 0;
  var limit = 250;
  
  // Just creates & returns a new Promise;
  // I put this in its own function to be DRY.
  var createRequest = function (lmt, srt, off) {
    return new Promise(function (resolve, reject) {
      // …
    });
  };

  // Returns a sequence of Promises.
  // The first one is resolved and then, with its data,
  // the next promises are created & resolved.
  return createRequest(limit, sort, offset)
    .then(function (checkins) {
      // Where the new promises will be placed
      var further = [];

      // Create N promises and add them to the previous array,
      // using data from the result of the 1st promise,
      // `checkins.count`
      while (checkins.count > offset) {
        further.push(
          createRequest(limit, sort, offset += limit)
        );
      }

      // Returns a promise when all the items are fulfilled
      return Promise.all(further);
    })
    .then(function (moreCheckins) {
      // After all the created promises are resolved,
      // `moreCheckins` is an array of their results.
      return moreCheckins.reduce(function (acc, chunk) {
        // …
        return acc;
      }, []);
    });
}
```

Playing around with promises has been a fun challenge. [Bluebird’s API](https://github.com/petkaantonov/bluebird/blob/master/API.md) is kind of massive, and I believe some documentation could be improved; but I can clearly see Promises’ benefits and I can’t wait to start using all these features in production code!

P.S.: I’m pretty sure the previous `createRequest` could be replace by a [generator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Generator), but this is a ES6 feature I haven’t been into yet.
