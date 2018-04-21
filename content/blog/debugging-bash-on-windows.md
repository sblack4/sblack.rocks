---
title: "Debugging Bash on Windows"
date: 2018-04-20T11:52:09-07:00
draft: false
description: "Using the WSL and vscode to debug bash scripts on windows"
tags: ["debugging", "bash", "vscode", "windows"]
---

- I wrote this on an airplane bach from HQ! I got a lot of practice 
presenting, had fun with our team mates from Austin TX, 
and saw how we were underutilizing docker and a few other 
devops tools. 

# Debugging Bash on Windows
## Using the WSL and vscode to debug bash scripts on windows

[bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) 
(in this case the [windows subsystem for linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10)), 
[visual studio code](https://code.visualstudio.com), 
[docker](https://www.docker.com/) 
these are a few of my favorite things! 

![bash on ubuntu on windows](/img/ubuntu-on-windows-cmder.png)

is it overkill when your running [wsl](https://docs.microsoft.com/en-us/windows/wsl/about) 
in a terminal emulator ([cmder](http://cmder.net/))

I've toyed with docker but hadn't seriously used it for work. With access to the cloud 
it's (usually) easy to get a VM with the services I want on it! That changed when I saw how a 
easy it was for a few of my peers to spin up containers with docker and werker! 
There's a great tutorial by a friend of mine, [here on github](https://oracle.github.io/learning-library/workshops/container-native-development/) 
that covers container native development. 

## The problem 
I want to play with [oracle streaming analytics in docker](https://github.com/gschmutz/dockerfiles/tree/master/oracle-stream-analytics) 
and some of the other docker images in [oracle's docker library](https://github.com/oracle/docker-images). 
There are shell scripts to assist in setting up the image which would be *super helpful* if I 
was running linux! Working in a large corporation that makes heavy use of certain programs, 
*cough, office, cough*, makes using windows a lot more conveinient. Not to mention I never have to 
worry about drivers for third party devices (anyone who has tried to use linux as their personal computer will know what I mean)! 

Although with google's [chrome os](#TODO:wiki chomeos) 
becoming so common, and most services moving to a subscription-based SaaS model (Office 365, G-Suite) 
it has never been easier for everyday use of linux. 


## The fix

### Windows Subsystem for Linux (wsl)
Windows 10 introduced the [wsl](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux) 
starting out with ubuntu on windows, which is why you'll see me use `apt-get`. 
I love [ubuntu](https://en.wikipedia.org/wiki/Ubuntu_(operating_system))
but I work most with red-hat based distrubutions like 
[oracle linux](#TODO: wiki oracle linux). 
[Linux Mint](https://linuxmint.com/) has caught my eye recently though... :smiley:


<div>
    <img src="/img/vscode-logo.png" width="200" style="position:absolute;z-index:-1;" />
</div>
### VS Code 
I love [VS Code](https://code.visualstudio.com/) 
of all the text editors I've used it's the fastest as well as the one with the best community/plugins. 

In this case [Bash Debug](#TODO: bash debug page) 
lets you step through bash scripts (I didn't know you could debug bash at all!) 


#### Bash Debug
Bash debug takes a little set-up. Here's my `$BASEDIR/.vscode/launch.json` 
it launches the bash script in view with three arg `-v 12.2.1 -A -s`

```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        
        {
            "type": "bashdb",
            "request": "launch",
            "pathBash": "C:\\Windows\\System32\\bash.exe",
            "name": "Bash-Debug (simplest configuration)",
            "program": "${file}",
            "args": [
                "-v 12.2.1",
                "-A",
                "-s"
            ]
        }
    ]
}
```

## The Results 

Very simply, this is awesome.  I've been struggling to improve my bash recently, this will help. 

![bash debug on windows](/img/bash-debug-on-windows.PNG)

I managed to figure out how to launch docker from the wsl too! Even though `docker` is aliased in 
the `~/.bash_aliases` bash doesn't automatically extend these aliases in scripts. 
By substituting `docker` for the absolute path and call to launch `docker.exe`

This was the script that needed fixing - some of the downloads turned out to be outdated and the links were broken
```sh
# BUILD THE IMAGE (replace all environment variables)
BUILD_START=$(date '+%s')
/mnt/c/Program\ Files/Docker/Docker/resources/bin/docker.exe build --force-rm=$NOCACHE --no-cache=$NOCACHE $PROXY_SETTINGS -t $IMAGE_NAME -f osa-dockerfiles/oracle-stream-analytics/dockerfiles/12.2.1/Dockerfile.$DISTRIBUTION . || {
  echo "There was an error building the image."
  exit 1
}
```
- from [this script to start a oracle-stream-analytics docker container](https://github.com/gschmutz/dockerfiles/tree/master/oracle-stream-analytics/dockerfiles/buildDockerImage.sh)

