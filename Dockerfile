# ubuntu:xenial
# oracle-jdk-1.8
# maven 3.6
FROM ubuntu:xenial

MAINTAINER Guoxin Liu (lgx31@sina.cn)

# install curl wget git
RUN apt update ;\
    apt upgrade -y ;\
    apt-get install -y curl wget git apt-utils

# install java 8
RUN apt-get install -y software-properties-common python-software-properties; \
    add-apt-repository ppa:webupd8team/java; \
    apt-get update; \
    # Accept license non-iteractive
    echo debconf shared/accepted-oracle-license-v1-1 select true |  debconf-set-selections; \
    echo debconf shared/accepted-oracle-license-v1-1 seen true |  debconf-set-selections; \
    apt-get install -y oracle-java8-installer; \
    # Make sure Java 8 becomes default java
    apt-get install -y oracle-java8-set-default

# install maven
ADD http://mirror.bit.edu.cn/apache/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz /usr/local/
RUN tar -xf /usr/local/apache-maven-3.6.0-bin.tar.gz

ENV MAVEN_HOME /usr/local/apache-maven-3.6.0
ENV PATH $PATH:$MAVEN_HOME

# install jenkins
ADD http://mirrors.jenkins.io/war-stable/latest/jenkins.war /jenkins/jenkins.war
ENV JENKINS_HOME /jenkins/home

ENTRYPOINT ["java", "-jar", "/jenkins/jenkins.war"]
EXPOSE 8080