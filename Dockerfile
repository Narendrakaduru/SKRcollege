FROM tomcat:latest
LABEL app=my-app
MAINTAINER "kadurunarendra@gmail.com"
EXPOSE 8080
COPY ./target/SKRcollege.war /usr/local/tomcat/webapps/SKRcollege.war
CMD chmod +x /usr/local/tomcat/bin/catalina.sh
CMD ["catalina.sh", "run"]
