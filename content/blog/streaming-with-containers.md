---
title: "Streaming With Containers"
date: 2018-04-19T22:13:09-07:00
draft: true
description: "blog post"
tags: ["blog"]
---

# Check out Oracle Stream Analytics, Built on Spark 

As with all cool software, you can check it out on github. check out my samples here 

[https://github.com/sblack4/dockerfiles/tree/master/oracle-stream-analytics](ihttps://github.com/sblack4/dockerfiles/tree/master/oracle-stream-analytics)

I'm going to trust you have some familiarity with 
shell 
and 
docker
(or access to 
[containers in the cloud](https://cloud.oracle.com/container-classic)
If so, this should be a cinch! 

## Running 

I've got windows 10 to this is me using 
[cmder](http://cmder.net/)
and 
[windows-subshell-for-linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
although lately I've been really digging 
[Linux Mint](https://linuxmint.com/). 

Here's me installing 
[docker](https://www.docker.com/)
 on the
[windows-subshell-for-linux]() 
what feels a lot like a super lightweight docker container mapped to your filesystem 

```sh
C:\Users\gense
λ bash
gense@LAPTOP-IK26DBRF:/mnt/c/Users/gense$ sudo apt-get install docker
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following NEW packages will be installed:
  docker
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 12.2 kB of archives.
After this operation, 65.5 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu xenial/universe amd64 docker amd64 1.5-1 [12.2 kB]
Fetched 12.2 kB in 6s (2,028 B/s)
Selecting previously unselected package docker.
(Reading database ... 25549 files and directories currently installed.)
Preparing to unpack .../docker_1.5-1_amd64.deb ...
Unpacking docker (1.5-1) ...
Processing triggers for man-db (2.7.5-1) ...
Setting up docker (1.5-1) ...
gense@LAPTOP-IK26DBRF:/mnt/c/Users/gense$

```

and now just clone 
[https://github.com/sblack4/oracle-streaming-analytics-in-the-cloud.git](https://github.com/sblack4/oracle-streaming-analytics-in-the-cloud.git)
locally! 


[see here for help with a proxy issue](https://askubuntu.com/questions/109673/how-to-use-apt-get-via-http-proxy-like-this)
