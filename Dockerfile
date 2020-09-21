# Pull base image.
FROM ubuntu:latest

RUN \
# Update
apt-get update -y && \
# Install Java
apt-get install default-jre -y

ADD ./target/serving-web-content-0.0.1-SNAPSHOT.jar java-spring-tekton.jar

EXPOSE 8080

CMD java -jar java-spring-tekton.jar
