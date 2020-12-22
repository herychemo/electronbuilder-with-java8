FROM electronuserland/builder:wine
MAINTAINER Heriberto Reyes Esparza <hery.chemo@gmail.com>

# Update wine Release key
RUN wget -qO - https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/Release.key | apt-key add -

# Update apt-get
RUN apt-get update -y

# Add software properties common and add openjdk repo
RUN apt-get install -y software-properties-common && add-apt-repository ppa:openjdk-r/ppa

# Install Java and Maven
RUN apt-get update -y && apt-get install -y openjdk-8-jdk maven ca-certificates-java  

# Fix certificate issues
RUN update-ca-certificates -f;

# Clean-up apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Add maven non root user.
RUN useradd -m -d /usr/share/maven maven -s /bin/bash

RUN chown -R maven /usr/share/maven
RUN chown -R maven /project

ARG USER_HOME_DIR="/usr/share/maven"

ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

USER maven

WORKDIR /project

