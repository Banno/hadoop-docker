#!/bin/bash

docker build -t registry.banno-internal.com/hadoop-docker:2.0.0-cdh4.4.0 .
docker push registry.banno-internal.com/hadoop-docker:2.0.0-cdh4.4.0
