FROM ubuntu:focal

MAINTAINER Ivan Posokhov <posohof@gmail.com>
    
ENV DEBIAN_FRONTEND=nointeractive \
    TERM=xterm

RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    apt-get install -y ant && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/

RUN java -version