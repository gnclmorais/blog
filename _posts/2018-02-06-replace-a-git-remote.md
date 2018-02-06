---
title: 'Replace a `git` remote'
date: 2018-02-06 00:00:00
tags: [git]
layout: post
---

I’ve found myself a few times waiting to move a whole project away from GitHub, but I keep forgetting about the process for such. Don’t get me wrong, there is nothing wrong with GitHub. But regarding projects I wish to keep private, when I think I could keep them on [Bitbucket](https://bitbucket.org) or [GitLab](https://about.gitlab.com) for free _and_ still keep their privacy, I start to wonder if I should jsut move them all to these platforms and keep on GitHub only what I wish to publicaly release.
OK, so let’s assume you have a project on GiHub but you want to move it to, say, GitLab. The process to do so can be quite simple, mostly relying on changing the `origin` remote of that git repository.

First, make sure you create a new project on GitLab:
![Click ‘New project’](/images/posts/gitlab_new_project.png)

Fill up all the information you need and click ‘Create project’:
![Click ‘Create project’](/images/posts/gitlab_create_project.png)

Now that we have a new project, grab the `git` link of the project (just click and it will be copied):
![Click the clipboard button](/images/posts/gitlab_copy_project.png)

Sweet, we got ourselves a remote link to point to. Now we go into out project’s folder (the one we had hosted on GitHub) and we replace the `origin` remote, basically telling git to push its changes into a different place in the cloud:

``` bash
cd my_awesome_project

# Just check the current remotes you have
git remote -v
# origin  git@github.com:gnclmorais/my_awesome_project.git (fetch)
# origin  git@github.com:gnclmorais/my_awesome_project.git (push)

# Replace the current origin to GitLab's project
git remote set-url origin git@gitlab.com:gnclmorais/my_awesome_project.git

# Check the changes, notice how it doesn't say 'github' anymore
git remote -v
# origin  git@gitlab.com:gnclmorais/my_awesome_project.git (fetch)
# origin  git@gitlab.com:gnclmorais/my_awesome_project.git (push)

# Now just `git push` and your project will be on GitLab
git push
```
