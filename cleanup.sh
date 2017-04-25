#!/bin/bash
set -x

helm delete --purge kafka-1
helm delete --purge spark-1
helm delete --purge hdfs-1
helm delete --purge tweeviz-1
helm delete --purge tweepub-1

kubectl delete ns demo
