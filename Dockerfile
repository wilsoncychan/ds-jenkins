# Base image
FROM jenkins/jenkins:lts

USER root

# MAINTAINER

# Get rid of admin password setup
# ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Automatically installing all plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Adding scripts
# Disabled for Jenkins Configuration as Code
# COPY groovy/* /usr/share/jenkins/ref/init.groovy.d/

# Install docker and docker compose
RUN apt-get update && apt-get install -y tree nano curl sudo

RUN curl https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz | tar xvz -C /tmp/ && mv /tmp/docker/docker /usr/bin/docker

RUN curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

RUN chmod 755 /usr/local/bin/docker-compose

RUN usermod -a -G sudo jenkins

RUN echo "jenkins ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

USER jenkins
