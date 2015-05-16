FROM ubuntu:precise

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

RUN apt-get update && apt-get install -y wget curl openjdk-7-jre-headless net-tools
RUN wget http://archive.cloudera.com/cdh4/one-click-install/precise/amd64/cdh4-repository_1.0_all.deb
RUN dpkg -i cdh4-repository_1.0_all.deb
RUN curl -s http://archive.cloudera.com/cdh4/ubuntu/precise/amd64/cdh/archive.key | apt-key add -
RUN apt-get update && apt-get install -y hadoop-0.20-mapreduce-jobtracker hadoop-hdfs-namenode hadoop-0.20-mapreduce-tasktracker hadoop-hdfs-datanode zookeeper

ADD core-site.xml.template hdfs-site.xml mapred-site.xml.template /etc/hadoop/conf/

ADD bootstrap.sh /etc/

ENTRYPOINT /etc/bootstrap.sh -d
