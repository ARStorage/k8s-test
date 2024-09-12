FROM tomcat:latest

ADD https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/mysql-connector-java-8.0.33.jar /usr/local/tomcat/lib/

RUN mkdir /usr/local/tomcat/webapps/ROOT
COPY index.html /usr/local/tomcat/webapps/ROOT/
COPY mysql_test3.jsp /usr/local/tomcat/webapps/
