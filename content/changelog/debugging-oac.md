---
title: "Debugging a OAC-BDC Connection"
date: 2018-05-21T13:56:29-04:00
draft: false
description: "Debuggn a connection between Oracle Analytics Cloud & Big Data Cloud"
tags: ["blog", "oac", "bdc", "spark"]
---


## Debugging Oracle Analytics Cloud &amp; Big Data Cloud 

My job is pretty varied but one thing that stays constant is requests to connect OAC to BDC. 

### Tail OSA logs 
Not everyone knows where to find these logs but just run the below command! 

```bash
tail -f /u01/data/domain/fmw/user_projects/domains/bi/servers/AdminServer/logs/bi.log
```

In our case it reveals some cryptic output... but it seems that there is a network timeout. That means the issue probably isn't on the OAC side

```log
####<May 16, 2018 3:28:13,804 PM UTC> <Error> <oracle.bi.tech.services.dataset.StandaloneDatasetService> <aeoacs-bi-1> <bi_server1> <[STANDBY] ExecuteThread: '40' for queue: 'weblogic.kernel.Default (self-tuning)'> <<anonymous>> <> <0bda8caa-ead8-4bb9-ac04-2173ae17e26c-000faa87> <1526484493804> <[severity-value: 8] [rid: 0] [partition-id: 0] [partition-name: DOMAIN] > <BEA-000000> <Failed to create and convert dataset: javax.ws.rs.ProcessingException: java.net.SocketTimeoutException: Read time out after 300000 millis
```


### Tail BDC Logs 

```bash
tail -f /data/var/log/spark2-thrift/spark-hive-org.apache.spark.sql.hive.thriftserver.HiveThriftServer2-1-aebigdata-bdcsce-1.out
```

reveals more cryptic errors... it looks like maybe the JVM ran out of space during a GC? 

```bash
18/05/16 15:27:42 ERROR ResourceLeakDetector: LEAK: ByteBuf.release() was not called before it's garbage-collected. Enable advanced leak reporting to find out where the leak occurred. To enable advanced leak reporting, specify the JVM option '-Dio.netty.leakDetection.level=advanced' or call ResourceLeakDetector.setLevel() See http://netty.io/wiki/reference-counted-objects.html for more information.
18/05/16 15:27:43 ERROR Utils: Uncaught exception in thread task-result-getter-0
java.lang.OutOfMemoryError: Java heap space
Exception in thread "task-result-getter-0" java.lang.OutOfMemoryError: Java heap space
18/05/16 15:37:37 ERROR LiveListenerBus: Listener EventLoggingListener threw an exception
java.io.IOException: All datanodes DatanodeInfoWithStorage[100.65.22.122:50010,DS-f8d560be-7098-4529-9b01-7e26b089b17e,DISK] are bad. Aborting...
        at org.apache.hadoop.hdfs.DFSOutputStream$DataStreamer.setupPipelineForAppendOrRecovery(DFSOutputStream.java:1142)
        at org.apache.hadoop.hdfs.DFSOutputStream$DataStreamer.processDatanodeError(DFSOutputStream.java:904)
        at org.apache.hadoop.hdfs.DFSOutputStream$DataStreamer.run(DFSOutputStream.java:411)
```


### Tail BDC spark logs 
Logs on BDC are stored in a variety of places...

```bash
 tail -f /data/var/log/spark2-thrift/spark-spark-org.apache.spark.deploy.history.HistoryServer-1-aebigdata-bdcsce-1.out
```

reveals the connection AND the subsequent error! 

```bash
18/05/16 16:18:53 DEBUG Client: IPC Client (2118255842) connection to /100.65.22.122:8010 from blk_1073742054_1231 got value #1156
18/05/16 16:18:53 DEBUG ProtobufRpcEngine: Call: getReplicaVisibleLength took 10ms
18/05/16 16:18:53 DEBUG Client: stopping client from cache: org.apache.hadoop.ipc.Client@6399551e
18/05/16 16:18:53 ERROR FsHistoryProvider: Exception encountered when attempting to load application log hdfs://aebigdata-bdcsce-1.compute-599616642.oraclecloud.internal:8020/spark-history/application_1523503765653_0002.inprogress
java.io.IOException: Cannot obtain block length for LocatedBlock{BP-2031294994-100.65.22.122-1523503732419:blk_1073742054_1231; getBlockSize()=244; corrupt=false; offset=0; locs=[DatanodeInfoWithStorage[100.65.22.122:50010,DS-f8d560be-7098-4529-9b01-7e26b089b17e,DISK]]}
        at org.apache.hadoop.hdfs.DFSInputStream.readBlockLength(DFSInputStream.java:428)
        at org.apache.hadoop.hdfs.DFSInputStream.fetchLocatedBlocksAndGetLastBlockLength(DFSInputStream.java:336)
        at org.apache.hadoop.hdfs.DFSInputStream.openInfo(DFSInputStream.java:272)
        at org.apache.hadoop.hdfs.DFSInputStream.<init>(DFSInputStream.java:264)
        at org.apache.hadoop.hdfs.DFSClient.open(DFSClient.java:1540)
        at org.apache.hadoop.hdfs.DistributedFileSystem$3.doCall(DistributedFileSystem.java:304)
        at org.apache.hadoop.hdfs.DistributedFileSystem$3.doCall(DistributedFileSystem.java:300)
        at org.apache.hadoop.fs.FileSystemLinkResolver.resolve(FileSystemLinkResolver.java:81)
        at org.apache.hadoop.hdfs.DistributedFileSystem.open(DistributedFileSystem.java:300)
        at org.apache.hadoop.fs.FileSystem.open(FileSystem.java:767)
        at org.apache.spark.scheduler.EventLoggingListener$.openEventLog(EventLoggingListener.scala:301)
        at org.apache.spark.deploy.history.FsHistoryProvider.org$apache$spark$deploy$history$FsHistoryProvider$$replay(FsHistoryProvider.scala:643)
        at org.apache.spark.deploy.history.FsHistoryProvider.org$apache$spark$deploy$history$FsHistoryProvider$$mergeApplicationListing(FsHistoryProvider.scala:460)
        at org.apache.spark.deploy.history.FsHistoryProvider$$anonfun$checkForLogs$3$$anon$4.run(FsHistoryProvider.scala:352)
        at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
        at java.util.concurrent.FutureTask.run(FutureTask.java:266)
        at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
        at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
        at java.lang.Thread.run(Thread.java:748)
18/05/16 16:18:53 DEBUG Client: IPC Client (2118255842) connection to /100.65.22.122:8010 from blk_1073742054_1231: closed
18/05/16 16:18:53 DEBUG Client: IPC Client (2118255842) connection to /100.65.22.122:8010 from blk_1073742054_1231: stopped, remaining connections 1
```


### Check on last log 

```bash
vim /data/var/log/spark2-thrift/spark-hive-org.apache.spark.sql.hive.thriftserver.HiveThriftServer2-1-aebigdata-bdcsce-1.out
```

more of the GC errors! Okay, corroborating evidence points to the JVM. We do have a lot of data hehehe....

```
18/05/16 19:01:40 ERROR SparkExecuteStatementOperation: Error executing query, currentState RUNNING,
java.lang.OutOfMemoryError: GC overhead limit exceeded
        at java.lang.StringCoding.decode(StringCoding.java:215)
        at java.lang.String.<init>(String.java:463)
        at java.lang.String.<init>(String.java:515)
        at org.apache.spark.unsafe.types.UTF8String.toString(UTF8String.java:1005)
        at org.apache.spark.sql.catalyst.expressions.GeneratedClass$SpecificSafeProjection.apply_6$(Unknown Source)
        at org.apache.spark.sql.catalyst.expressions.GeneratedClass$SpecificSafeProjection.apply(Unknown Source)
        at org.apache.spark.sql.catalyst.encoders.ExpressionEncoder.fromRow(ExpressionEncoder.scala:303)
        at org.apache.spark.sql.Dataset$$anonfun$org$apache$spark$sql$Dataset$$execute$1$1$$anonfun$apply$13.apply(Dataset.scala:2378)
        at org.apache.spark.sql.Dataset$$anonfun$org$apache$spark$sql$Dataset$$execute$1$1$$anonfun$apply$13.apply(Dataset.scala:2378)
        at scala.collection.TraversableLike$$anonfun$map$1.apply(TraversableLike.scala:234)
        at scala.collection.TraversableLike$$anonfun$map$1.apply(TraversableLike.scala:234)
        at scala.collection.IndexedSeqOptimized$class.foreach(IndexedSeqOptimized.scala:33)
        at scala.collection.mutable.ArrayOps$ofRef.foreach(ArrayOps.scala:186)
        at scala.collection.TraversableLike$class.map(TraversableLike.scala:234)
        at scala.collection.mutable.ArrayOps$ofRef.map(ArrayOps.scala:186)
        at org.apache.spark.sql.Dataset$$anonfun$org$apache$spark$sql$Dataset$$execute$1$1.apply(Dataset.scala:2378)
        at org.apache.spark.sql.execution.SQLExecution$.withNewExecutionId(SQLExecution.scala:57)
        at org.apache.spark.sql.Dataset.withNewExecutionId(Dataset.scala:2780)
        at org.apache.spark.sql.Dataset.org$apache$spark$sql$Dataset$$execute$1(Dataset.scala:2377)
        at org.apache.spark.sql.Dataset$$anonfun$org$apache$spark$sql$Dataset$$collect$1.apply(Dataset.scala:2382)
        at org.apache.spark.sql.Dataset$$anonfun$org$apache$spark$sql$Dataset$$collect$1.apply(Dataset.scala:2382)
        at org.apache.spark.sql.Dataset.withCallback(Dataset.scala:2793)
        at org.apache.spark.sql.Dataset.org$apache$spark$sql$Dataset$$collect(Dataset.scala:2382)
        at org.apache.spark.sql.Dataset.collect(Dataset.scala:2358)
        at org.apache.spark.sql.hive.thriftserver.SparkExecuteStatementOperation.org$apache$spark$sql$hive$thriftserver$SparkExecuteStatementOperation$$execute(SparkExecuteStatementOperation.scala:245)
        at org.apache.spark.sql.hive.thriftserver.SparkExecuteStatementOperation$$anon$1$$anon$2.run(SparkExecuteStatementOperation.scala:174)
        at org.apache.spark.sql.hive.thriftserver.SparkExecuteStatementOperation$$anon$1$$anon$2.run(SparkExecuteStatementOperation.scala:171)
        at java.security.AccessController.doPrivileged(Native Method)
        at javax.security.auth.Subject.doAs(Subject.java:422)
        at org.apache.hadoop.security.UserGroupInformation.doAs(UserGroupInformation.java:1709)
        at org.apache.spark.sql.hive.thriftserver.SparkExecuteStatementOperation$$anon$1.run(SparkExecuteStatementOperation.scala:184)
        at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
18/05/16 19:01:40 ERROR SparkExecuteStatementOperation: Error running hive query:
org.apache.hive.service.cli.HiveSQLException: java.lang.OutOfMemoryError: GC overhead limit exceeded
        at org.apache.spark.sql.hive.thriftserver.SparkExecuteStatementOperation.org$apache$spark$sql$hive$thriftserver$SparkExecuteStatementOperation$$execute(SparkExecuteStatementOperation.scala:266)
        at org.apache.spark.sql.hive.thriftserver.SparkExecuteStatementOperation$$anon$1$$anon$2.run(SparkExecuteStatementOperation.scala:174)
        at org.apache.spark.sql.hive.thriftserver.SparkExecuteStatementOperation$$anon$1$$anon$2.run(SparkExecuteStatementOperation.scala:171)
        at java.security.AccessController.doPrivileged(Native Method)
        at javax.security.auth.Subject.doAs(Subject.java:422)
        at org.apache.hadoop.security.UserGroupInformation.doAs(UserGroupInformation.java:1709)
        at org.apache.spark.sql.hive.thriftserver.SparkExecuteStatementOperation$$anon$1.run(SparkExecuteStatementOperation.scala:184)
        at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
        at java.util.concurrent.FutureTask.run(FutureTask.java:266)
        at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
        at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
        at java.lang.Thread.run(Thread.java:748)
```



### Thank You StackOverflow

So I asked the interwebs and they replied "over yonder website doth thy answer live" and pointed me to the below link

https://stackoverflow.com/questions/46979848/spark-thriftserver-stops-or-freezes-due-to-tableau-queries

I added `spark.sql.thriftServer.incrementalCollect=true` to `spark2-thirft-sparkconf.xml` in Ambari. 
I went ahead and beefed up our `spark-env.sh` too

```bash
SPARK_EXECUTOR_CORES="2" #Number of cores for the workers (Default: 1).
SPARK_EXECUTOR_MEMORY="2G" #Memory per Worker (e.g. 1000M, 2G) (Default: 1G)
SPARK_DRIVER_MEMORY="1080M" #Memory for Master (e.g. 1000M, 2G) (Default: 512 Mb)
```


