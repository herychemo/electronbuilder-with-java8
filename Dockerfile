FROM electronuserland/builder:wine
MAINTAINER Heriberto Reyes Esparza <hery.chemo@gmail.com>

# Update apt-get
RUN apt-get update -y

# Install Java and Maven
RUN apt-get install -y openjdk-8-jre-headless maven 

# Clean-up apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Add maven non root user.
RUN useradd -m -d /usr/share/maven maven -s /bin/bash

ARG USER_HOME_DIR="/usr/share/maven"

ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

USER maven


