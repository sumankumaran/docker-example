FROM adoptopenjdk/openjdk11:alpine-jre

ARG JAR_FILE=target/docker-example.jar

#WORKDIR /opt/app

COPY target/${JAR_FILE} /opt/app/docker-example.jar

ENTRYPOINT ["java","-jar","docker-example.jar"]