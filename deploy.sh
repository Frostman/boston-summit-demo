#!/bin/bash
set -ex

if ! hash kubectl 2>/dev/null; then
    echo "kubectl is not installed"
    exit 1
fi

if ! hash helm 2>/dev/null; then
    echo "helm is not installed"
    exit 1
fi

helm init --upgrade

# Don't change it
NAMESPACE=demo

workdir=$(dirname $0)

helm repo add boston-summit-charts https://f001.backblazeb2.com/file/boston-summit-charts
helm repo update

helm="helm upgrade --install --namespace $NAMESPACE"

$helm kafka-1 boston-summit-charts/kafka -f $workdir/configs/kafka.yaml
$helm spark-1 boston-summit-charts/spark -f $workdir/configs/spark.yaml
$helm hdfs-1 boston-summit-charts/hdfs
$helm tweepub-1 boston-summit-charts/tweepub -f $workdir/configs/tweepub.yaml
$helm tweeviz-1 boston-summit-charts/tweeviz -f $workdir/configs/tweeviz.yaml

kubectl -n $NAMESPACE get svc

rm *tgz
