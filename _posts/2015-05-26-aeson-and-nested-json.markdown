---
title: 'Aeson and nested JSON'
date: 2015-05-26 00:00:00
tags: haskell aeson
layout: post
---
As some of you might know, these last three months I’ve had the opportunity to join [Recurse Center](https://recurse.com) as a member of Spring 1 ‘15 batch.
After reaching the end of it, it is time to finally put into writing much of what’ve learned with this experience.

My main focus while in New York was, surprisingly, learning Haskell. It was something that came into my attention on the first week over there and basically I thought it would be a fun challenge.

One of the projects I’ve came up with to learn & use Haskell on was [Flickell](https://github.com/gnclmorais/flickell), a rather simple Flickr photo set downloader. The main feature I wanted it to have was to download all of the photos a certain Flickr photo set has. While I was developing this tool, one of the challenges I’ve faced was transforming strings containing JSON objects into Haskell data structures. After a few online searches, the web seemed to agree that [aeson](https://github.com/bos/aeson) was the best tool for the job.

However, aeson documentation is not exactly newbie-friendly, and the examples I’ve found online greatly vary in style and, to be honest, none of them were that helpful to me, anyway. The only exception is __[this tutorial](http://artyom.me/aeson)__, which was brought to my attention totally by accident by a random stranger on a Haskell meetup. _Thank you, random stranger!_

## aeson 101

I’ll skip the details about types & such and go straight to a simple example.

```javascript
{
  "photoset": {
    "id": "72157694654577774",
    "primary": "9774229501",
    "owner": "101926234@N03",
    "ownername": "mayer_tom",
    "photo": [
      {
        "id": "9771234001",
        "secret": "82sd0454a2",
        "server": "7348",
        "farm": 7,
        "title": "TESTConf test",
        "isprimary": "0",
        "ispublic": 1,
        "isfriend": 0,
        "isfamily": 0
      },
      … // a lot more items in this array
    ],
    "page": 1,
    "per_page": 500,
    "perpage": 500,
    "pages": 1,
    "total": "34",
    "title": "TESTConf test"
  },
  "stat": "ok"
}
```

The JSON above will map to the following Haskell types and decoding methods:

```haskell
data Photo = Photo
    { photoid   :: Text
    , secret    :: Text
    , server    :: Text
    , farm      :: Int
    , title     :: Text
    , isprimary :: Text
    , ispublic  :: Int
    , isfriend  :: Int
    , isfamily  :: Int
    } deriving Show

data Photoset = Photoset
    { photosetid :: Text
    , primary    :: Text
    , owner      :: Text
    , ownername  :: Text
    , photo      :: [Photo]
    , page       :: Int
    , per_page   :: Int
    , perpage    :: Int
    , pages      :: Int
    , total      :: Text
    , name       :: Text
    } deriving Show

data FlickrResponse = FlickrResponse
    { photoset :: Photoset
    , stat     :: Text
    } deriving Show

instance FromJSON Photo where
    parseJSON (Object v) =
        Photo <$> v .: "id"
              <*> v .: "secret"
              <*> v .: "server"
              <*> v .: "farm"
              <*> v .: "title"
              <*> v .: "isprimary"
              <*> v .: "ispublic"
              <*> v .: "isfriend"
              <*> v .: "isfamily"
    parseJSON _ = mzero

instance FromJSON Photoset where
    parseJSON (Object o) =
        Photoset <$> o .: "id"
                 <*> o .: "primary"
                 <*> o .: "owner"
                 <*> o .: "ownername"
                 <*> o .: "photo"
                 <*> o .: "page"
                 <*> o .: "per_page"
                 <*> o .: "perpage"
                 <*> o .: "pages"
                 <*> o .: "total"
                 <*> o .: "title"
    parseJSON _ = mzero

instance FromJSON FlickrResponse where
    parseJSON (Object v) =
        FlickrResponse <$> v .: "photoset"
                       <*> v .: "stat"
```

If stated correctly, aeson should even decode nested JSONs, easily inferring the right types & decoders. After setting up your types & decoding functions, using aeson is as easy as doing something like `d -> eitherDecode <your-json-string> :: Either String FlickrResponse`.

Again, I must refer [this link](http://artyom.me/aeson) as the best place to learn virtually everything about aeson’s inner working and quirks. So go ahead and take a look at it, please. Happy decoding!

### Resources
- [Parsing Nested JSON in Haskell with AESON](http://the-singleton.com/2012/02/parsing-nested-json-in-haskell-with-aeson/)
- [Yet Another Aeson Tutorial](http://doingmyprogramming.com/2014/04/14/yet-another-aeson-tutorial/)
- [Aeson: the tutorial](http://artyom.me/aeson)

### Trivia
In Greek mythology, Aeson was the father of Jason. _(Get it?)_
