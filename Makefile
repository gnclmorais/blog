serve:
	bundle exec jekyll serve

drafts:
	bundle exec jekyll serve --drafts

build:
	bundle exec jekyll build

# For the file name: https://stackoverflow.com/a/41316280/590525
# For the multiline: https://gist.github.com/azatoth/1030091
FILENAME:=./_drafts/$(shell date +'%Y-%m-%d')-.md
define post
---
title: ''
date: $(shell date +'%Y-%m-%d') 00:00:00
tags:
layout: post
---
endef
export post
draft:
	touch $(FILENAME)
	echo "$$post" > $(FILENAME)
