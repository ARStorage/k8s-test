FROM tomcat:latest

RUN mkdir /usr/local/tomcat/webapps/ROOT
COPY index.html /usr/local/tomcat/webapps/ROOT/
