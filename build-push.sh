#!/bin/bash

TAG="2.0.0-mr1-cdh4.4.0"

docker build -t registry.banno-internal.com/hadoop-docker:$TAG .
docker push registry.banno-internal.com/hadoop-docker:$TAG
