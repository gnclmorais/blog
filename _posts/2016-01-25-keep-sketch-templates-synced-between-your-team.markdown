---
title: 'Keep Sketch templates in sync between your team'
date: 2016-01-25 00:00:00
tags: sketch ln
layout: post
---
Any developer that worked with a design team before probably went (several time) through the process of gathering the most up-to-date resources and templates for a given task. Unless you have a very clear & streamlined process into place, you’ll probably run into several outdated versions of the same files, leaving you confused and/or enraged for having to deal with this.

As I saw my team’s next two weeks getting filled with more and more design tasks, I decided to take on a few of them. However, this meant getting the most recent Sketch resources we might have, in order to keep our design consistent.

So in order to keep these resource files synced between the team, I employed a simple and old technique: [symbolic links](http://linux.die.net/man/1/ln) + [Dropbox](https://db.tt/2IBEiIP).

My goal was simple, to keep [Sketch](https://www.sketchapp.com)’s _Templates_ folder linked among the team so it would always be up to date. There’s a familiar practice to keep in sync folders that you cannot move into Dropbox. When I say _Dropbox_, I might say Google Drive, Microsoft OneDrive, SpiderOak, or any other way to keep files synced between devices.

The method is simple in theory, although the terminal commands might paint it a bit dauting for people who are not familiar with them. Here it goes:

## 1. Share the Templates folder with your team
Pick where you want that folder to be and create it (as long as it’s inside Dropbox or other syncing/sharing mechanism). It doesn’t really matter where you put it, what that matters is to share it between everyone you want to give access to.

## 2. Open up a terminal window…
… and run the following command:

```
cd /Users/{{username}}/Library/Application\ Support/com.bohemiancoding.sketch3/
```

Don’t forget to replace `{{username}}` with your OS X alias. You should now be able to see folders like _Plugins_ and _Templates_, if you run `ls -la`.

## 3. Rename your _Templates_ folder
This is the folder we are going to replace with a synced version, so make sure you rename it (or you can even delete it, if it’s empty).

## 4. Create the symbolic link
Now that you are in the right place and have all that you need, run the following command:

```
ln -s {{Dropbox_folder_path}} Templates
```

Replace the `Dropbox_folder_path` above with the path of the shared folder you have in Dropbox. This simply creates a symbolic link called _Templates_ that points to your original shared folder, where your important files are up to date.

![Mathematical!](http://media.tumblr.com/tumblr_meojs73rGS1r6h22v.gif)

This is a simple process to keep files synced for other programs, not just Sketch. Any other piece fo software that requires its own folder structure where important files are kept, just use the same technique. Happy syncing!

---

### Resources:
* [Use symbolic links in a Dropbox folder](http://hints.macworld.com/article.php?story=20120803093247391)
