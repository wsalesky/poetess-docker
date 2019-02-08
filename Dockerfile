# Based on examples here: https://github.com/eXist-db/docker-existdb
# Stage 1 : Install Apache ant and build the Srophe application and Srophe data application.
FROM openjdk:8-jdk-alpine as builder

USER root

ENV ANT_VERSION 1.10.5
ENV ANT_HOME /etc/ant-${ANT_VERSION}

WORKDIR /tmp

ADD http://www-us.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz .

RUN mkdir ant-${ANT_VERSION} \
 && tar -zxvf apache-ant-${ANT_VERSION}-bin.tar.gz \
 && mv apache-ant-${ANT_VERSION} ${ANT_HOME} \
 && rm apache-ant-${ANT_VERSION}-bin.tar.gz \
 && rm -rf ant-${ANT_VERSION} \
 && rm -rf ${ANT_HOME}/manual \
 && unset ANT_VERSION

ENV PATH ${PATH}:${ANT_HOME}/bin

# Change working directory to access/build application data
WORKDIR /home/poetess-docker
COPY . .

# Build Srophe application code
WORKDIR /home/poetess-docker/srophe
RUN ant

# Build Srophe data application
WORKDIR /home/poetess-docker/PoetessArchive
RUN ant

# START STAGE 2 : Use the latest eXist-db release as a base image
FROM srophe/srophe:latest

# Copy custom controller-config.xml to WEB-INF. This sets the root app to srophe. 
COPY conf/controller-config.xml /exist/webapp/WEB-INF/

# Add application files from step 1 
COPY --from=builder /home/poetess-docker/srophe/build/*.xar /exist/autodeploy/
COPY --from=builder /home/poetess-docker/PoetessArchive/build/*.xar /exist/autodeploy/