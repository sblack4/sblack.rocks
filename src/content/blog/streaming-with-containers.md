---
title: "Streaming With Containers"
date: 2018-04-19T22:13:09-07:00
draft: true
description: "Oracle Stream Analytics - visualize data flows"
tags: ["spark", "osa", "Oracle Stream Analytics"]
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

Here's me using docker on the  
[windows-subshell-for-linux](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux) 
which feels a lot like a super lightweight docker container mapped to your filesystem 
you can also [debug bash on ]()

```sh
gense@LAPTOP-IK26DBRF:/mnt/c/Users/gense/Git/oracle-workshops/oracle-streaming-anallytics-in-the-cloud/osa-dockerfiles/oracle-stream-analytics/dockerfiles$ sh -x buildDockerImage.sh -v 12.2.1 -s -A
+ [ 4 -eq 0 ]
+ STANDALONE=0
+ SPARK=0
+ VERSION=12.2.1
+ SKIPMD5=0
+ NOCACHE=true
+ getopts hsABcv: optname
+ VERSION=12.2.1
+ getopts hsABcv: optname
+ SKIPMD5=1
+ getopts hsABcv: optname
+ STANDALONE=1
+ getopts hsABcv: optname
+ [ 1 -gt 1 ]
+ [ 1 -eq 1 ]
+ DISTRIBUTION=standalone
+ IMAGE_NAME=gschmutz/oracle-osa:12.2.1-standalone
+ cd 12.2.1
+ [ ! 1 -eq 1 ]
+ echo Skipped MD5 checksum.
Skipped MD5 checksum.
+ echo =====================
=====================
+ PROXY_SETTINGS=
+ [  !=  ]
+ [  !=  ]
+ [  !=  ]
+ [  !=  ]
+ [  !=  ]
+ echo Building image 'gschmutz/oracle-osa:12.2.1-standalone' ...
Building image 'gschmutz/oracle-osa:12.2.1-standalone' ...
+ date +%s
+ BUILD_START=1524293373
+ /mnt/c/Program Files/Docker/Docker/resources/bin/docker.exe build --force-rm=true --no-cache=true -t gschmutz/oracle-osa:12.2.1-standalone -f Dockerfile .
Sending build context to Docker daemon  894.4MB
Step 1/10 : FROM oraclelinux:latest
 ---> af8cf7fc5b7e
Step 2/10 : MAINTAINER Guido Schmutz <guido.schmutz@trivadis.com>
 ---> Running in cd27bbc41f94
Removing intermediate container cd27bbc41f94
 ---> 045f5f7d3c70
Step 3/10 : ENV JAVA_PKG=server-jre-8u*-linux-x64.tar.gz        JAVA_HOME=/usr/java/default     PATH=$PATH:/usr/java/default/bin     ORACLE_HOME=/u01/oracle     OSA_PKG=fmw_12.2.1.1.0_osa_Disk1_1of1.zip     OSA_JAR=fmw_12.2.1.1.0_osa.jar     OSA_FOLDER=fmw_12.2.1.1.0_osa_Disk1_1of1
 ---> Running in 6621b2e0618f
Removing intermediate container 6621b2e0618f
 ---> 6555cdd2b9ac
Step 4/10 : ADD downloads/$JAVA_PKG /usr/java/
 ---> c753141728fe
Step 5/10 : RUN mv $(ls -1 -d /usr/java/*) $JAVA_HOME
 ---> Running in 3f35e96af656
Removing intermediate container 3f35e96af656
 ---> b459192c0031
Step 6/10 : COPY downloads/$OSA_PKG setup/install.file setup/oraInst.loc /u01/
 ---> 4e0e14bb8946
Step 7/10 : RUN chmod a+xr /u01 &&      useradd -b /u01 -m -s /bin/bash oracle &&       echo oracle:oracle | chpasswd &&        cd /u01 && $JAVA_HOME/bin/jar xf /u01/$OSA_PKG && cd - &&    su -c "$JAVA_HOME/bin/java -jar /u01/$OSA_JAR -silent -responseFile /u01/install.file -invPtrLoc /u01/oraInst.loc -jreLoc $JAVA_HOME" - oracle &&     chown oracle:oracle -R /u01 &&     rm /u01/$OSA_JAR /u01/$OSA_PKG /u01/oraInst.loc /u01/install.file
 ---> Running in 5d0cde29ccd7
/
Launcher log file is /tmp/OraInstall2018-04-21_06-50-05AM/launcher2018-04-21_06-50-05AM.log.
Extracting files.......
Starting Oracle Universal Installer

Checking if CPU speed is above 300 MHz.   Actual 2811.058 MHz    Passed
Checking swap space: must be greater than 512 MB.   Actual 1023 MB    Passed
Checking if this platform requires a 64-bit JVM.   Actual 64    Passed (64-bit not required)
Checking temp space: must be greater than 300 MB.   Actual 48926 MB    Passed


Preparing to launch the Oracle Universal Installer from /tmp/OraInstall2018-04-21_06-50-05AM
Log: /tmp/OraInstall2018-04-21_06-50-05AM/install2018-04-21_06-50-05AM.log
Copyright (c) 1996, 2016, Oracle and/or its affiliates. All rights reserved.
Reading response file..
Skipping Software Updates
Starting check : CertifiedVersions
Prerequisite Check was skipped and did not execute.
Warning: Check:CertifiedVersions completed with warnings.


Starting check : CheckJDKVersion
Problem: This JDK version was not certified at the time it was made generally available. It may have been certified following general availability.

Recommendation: Check the Supported System Configurations Guide (http://www.oracle.com/technetwork/middleware/ias/downloads/fusion-certification-100350.html) for further details. Press "Next" if you wish to continue.

Expected result: 1.8.0_77
Actual result: 1.8.0_171
Warning: Check:CheckJDKVersion completed with warnings.


Validations are enabled for this session.
Verifying data
Copying Files
Percent Complete : 10
Percent Complete : 20
Percent Complete : 30
Percent Complete : 40
Percent Complete : 50
Percent Complete : 60
Percent Complete : 70
Percent Complete : 80
Percent Complete : 90
Percent Complete : 100

The installation of Oracle Fusion Middleware 12c Stream Analytics 12.2.1.1.0 completed successfully.
Logs successfully copied to /u01/oracle/.inventory/logs.
Removing intermediate container 5d0cde29ccd7
 ---> f5c4df1cbf61
Step 8/10 : USER oracle
 ---> Running in a08017d83204
Removing intermediate container a08017d83204
 ---> e18ad505a304
Step 9/10 : WORKDIR $ORACLE_HOME
Removing intermediate container 9c3c35bf1120
 ---> 709e4d0cfff5
Step 10/10 : CMD ["bash"]
 ---> Running in c7555be5e46f
Removing intermediate container c7555be5e46f
 ---> 813d921d2be1
Successfully built 813d921d2be1
Successfully tagged gschmutz/oracle-osa:12.2.1-standalone
SECURITY WARNING: You are building a Docker image from Windows against a non-Windows Docker host. All files and directories added to build context will have '-rwxr-xr-x' permissions. It is recommended to double check and reset permissions for sensitive files and directories.
+ date +%s
+ BUILD_END=1524293454
+ expr 1524293454 - 1524293373
+ BUILD_ELAPSED=81
+ echo

+ [ 0 -eq 0 ]
+ cat
  WebLogic Docker Image for 'standalone' version 12.2.1 is ready to be extended:

    --> gschmutz/oracle-osa:12.2.1-standalone

  Build completed in 81 seconds.
```

and now just clone 
[https://github.com/sblack4/oracle-streaming-analytics-in-the-cloud.git](https://github.com/sblack4/oracle-streaming-analytics-in-the-cloud.git)
locally! 


[see here for help with a proxy issue](https://askubuntu.com/questions/109673/how-to-use-apt-get-via-http-proxy-like-this)
