# boston-summit-demo

# Twitter -> Kafka -> Spark -> HDFS -> WebUI

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
