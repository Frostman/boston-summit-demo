#!/bin/bash
set -ex

spark_master=$(kubectl -n demo get po | awk '/spark-mas/{print $1}')

echo "rm spark_hashtags_count.py; wget https://raw.githubusercontent.com/Frostman/tweetics/boston-demo/spark_hashtags_count.py && spark-submit --packages org.apache.spark:spark-streaming-kafka-0-8_2.11:2.1.0 spark_hashtags_count.py local[4] zk-kafka-1-0.zk-kafka-1:2181,zk-kafka-1-1.zk-kafka-1:2181,zk-kafka-1-2.zk-kafka-1:2181 twitter-stream 0 5 hdfs://hdfs-namenode:8020/demo" | kubectl -n demo exec "${spark_master}" -i bash
