FROM tomcat:latest
LABEL app=my-app
MAINTAINER "kadurunarendra@gmail.com"
EXPOSE 8080
COPY ./target/SKRcollege.war /usr/local/tomcat/webapps/SKRcollege.war
CMD ["catalina.sh", "run"]
