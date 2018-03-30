---
title: "Deploying Gh Pages With Hugo"
date: 2018-03-30T14:23:44-04:00
draft: false
---

# Deploying GitHub Pages with Hugo

Learn more about hugo as [gohugo.io](https://gohugo.io/)
<br>

## Create a [Hugo site](https://gohugo.io/getting-started/quick-start/)
Install Hugo (see [chocolatey](https://chocolatey.org/))
```shell
choco install hugo -confirm
```
<br>

## Follow Directions to install [Minimal](https://github.com/calintat/minimal)

```shell
git submodule add https://github.com/calintat/minimal.git themes/minimal
git submodule init
git submodule update
```
<br>

## Set up GitHub Pages

![](/img/hugo-vs-code.PNG)
<br>
<br>

### Checkout `dev` branch
```shell
git checkout -b dev
```
<br>

### Change `master` branch to `.../sblack.github.io/public`

From the root of my project (`.../sblack.github.io`)
```shell
 git clone -b master https://github.com/sblack4/sblack4.github.io.git public
```
<br>
