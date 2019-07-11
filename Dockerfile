# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
# we are extending everything from tomcat:8.0 image ...
FROM tomcat:8.5

MAINTAINER umur_gogebakan

# COPY path-to-your-application-war path-to-webapps-in-docker-tomcat

COPY target/SpotifySpeech-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/
COPY application_default_credentials.json /root/.config/gcloud/