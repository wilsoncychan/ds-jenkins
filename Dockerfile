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

