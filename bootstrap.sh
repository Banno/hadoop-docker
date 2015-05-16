#!/bin/bash

# $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

# rm /tmp/*.pid

# installing libraries if any - (resource urls added comma separated to the ACP system variable)
# cd $HADOOP_PREFIX/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

sed s/HOSTNAME/$HOSTNAME/ /etc/hadoop/conf/core-site.xml.template > /etc/hadoop/conf/core-site.xml
sed s/HOSTNAME/$HOSTNAME/ /etc/hadoop/conf/mapred-site.xml.template > /etc/hadoop/conf/mapred-site.xml

mkdir -p /tmp/hadoop-hdfs/dfs/name /tmp/hadoop-hdfs/dfs/data
chown -R hdfs:hdfs /tmp/hadoop-hdfs/dfs/name /tmp/hadoop-hdfs/dfs/data
su - hdfs -c 'hdfs namenode -format -force'

service hadoop-hdfs-namenode start
service hadoop-hdfs-datanode start

su - hdfs -c 'hadoop fs -mkdir /tmp'
su - hdfs -c 'hadoop fs -mkdir /user'
su - hdfs -c 'hadoop fs -chmod -R 1777 /tmp'
su - hdfs -c 'hadoop fs -mkdir -p /var/lib/hadoop-hdfs/cache/mapred/mapred/staging && hadoop fs -chown -R mapred /var/lib/hadoop-hdfs/cache/mapred'
su - hdfs -c 'hadoop fs -chmod 1777 /var/lib/hadoop-hdfs/cache/mapred/mapred/staging'
su - hdfs -c 'hadoop fs -mkdir /tmp/mapred/system && hadoop fs -chown mapred:hadoop /tmp/mapred/system'
su - hdfs -c 'hadoop fs -mkdir -p /tmp/hadoop-mapred/mapred && hadoop fs -chown -R mapred /tmp/hadoop-mapred/mapred && hadoop fs -chmod 1777 /tmp/hadoop-mapred/mapred'

service hadoop-0.20-mapreduce-jobtracker start
service hadoop-0.20-mapreduce-tasktracker start

######################################################################################
# commands banno druid usage:

#have to turn safe mode off before we can write to hdfs
# /usr/local/hadoop/bin/hdfs dfsadmin -safemode leave

#create /druid hdfs dir for druid-setup tests
su - hdfs -c 'hadoop fs -mkdir /druid && hadoop fs -chown druid /druid'
######################################################################################

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
