FROM adoptopenjdk/openjdk11:alpine-jre

ARG JAR_FILE=target/docker-example.jar

#WORKDIR /opt/app

COPY ${JAR_FILE} .

ENTRYPOINT ["java","-jar","docker-example.jar"]