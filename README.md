# boston-summit-demo

# Twitter -> Kafka -> Spark -> HDFS -> WebUI

## Fast HOWTO

* have `kubectl` configured to your k8s cluster (it'll work even with minikube) and `helm` installed
* run `deploy.sh`, wait until all in `Running` state, should looks like:

```shell
NAME                                    READY     STATUS    RESTARTS   AGE
hdfs-datanode-1669390434-bk723          1/1       Running   0          37m
hdfs-datanode-1669390434-f19st          1/1       Running   0          37m
hdfs-datanode-1669390434-jx3dx          1/1       Running   0          37m
hdfs-namenode-0                         1/1       Running   0          37m
kafka-kafka-1-0                         1/1       Running   0          38m
kafka-kafka-1-1                         1/1       Running   0          37m
kafka-kafka-1-2                         1/1       Running   0          36m
spark-1-spark-master-699628707-0kmgp    1/1       Running   0          38m
spark-1-spark-worker-1323738510-7mbmv   1/1       Running   0          38m
spark-1-spark-worker-1323738510-881tw   1/1       Running   0          38m
spark-1-zeppelin-134815462-s3rm0        1/1       Running   0          38m
tweepub-tweepub-1-690258867-vg3b5       1/1       Running   3          37m
tweeviz-tweeviz-1-4014781405-kwxpk      1/1       Running   0          29m
zk-kafka-1-0                            1/1       Running   0          38m
zk-kafka-1-1                            1/1       Running   0          37m
zk-kafka-1-2                            1/1       Running   0          37m
```

* run `job.sh` in separated terminal tab - it'll run while Spark job is running and to interrupt Spark job you just need to interrupt this script
* to access WebUIs take a look at host ports by using command `kubectl -n demo get svc`:

```shell
NAME                    CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
hdfs-namenode           None             <none>        8020/TCP                     1h
hdfs-ui                 10.254.212.106   <nodes>       50070:30902/TCP              1h
kafka-kafka-1           None             <none>        9092/TCP                     1h
spark-1-spark-master    10.254.15.178    <none>        7077/TCP                     1h
spark-1-spark-restapi   10.254.83.17     <none>        6066/TCP                     1h
spark-1-spark-webui     10.254.103.221   <nodes>       8080:32269/TCP               1h
spark-1-zeppelin        10.254.185.248   <nodes>       8080:31238/TCP               1h
tweeviz-tweeviz-1       10.254.11.123    <nodes>       8589:32766/TCP               1h
zk-kafka-1              None             <none>        2888/TCP,3888/TCP,2181/TCP   1h
```

In that case visualization will be accessible on any k8s node ip with port `32766`.

## Commands:

* `deploy.sh` - installs all components to the k8s using Helm into the `demo` namespace
* `job.sh` - runs streaming job inside deployed Spark
* `cleanup.sh` - removes all deployed components

## Components:

* `TweePub` - Reads tweets from Twitter Streaming API and puts into Kafka topic

  * https://github.com/Frostman/tweepub
  * https://github.com/Frostman/tweepub/blob/master/tweepub.py

* `TweeTics` - Spark job that parses tweets from Kafka and stores hashtags popularity as text files to HDFS

  * https://github.com/Frostman/tweetics
  * https://github.com/Frostman/tweetics/blob/master/spark_hashtags_count.py

* `TweeViz` - Simply reads processed data from HDFS and shows hashtags popularity as tag cloud

  * https://github.com/Frostman/tweeviz
  * https://github.com/Frostman/tweeviz/blob/master/tweeviz.py
  * https://github.com/Frostman/tweeviz/blob/master/templates/index.html

## Getting access to WebUIs

There are commented lines `nodePort: ...` for all interesting services in `configs/*`, so, just uncomment the ones you're interested about and put some static node port.

## Twitter API config

Go to https://apps.twitter.com/ and create new app and *readwrite* token and put data from it into the `configs/tweepub.yaml`.
