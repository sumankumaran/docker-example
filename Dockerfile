FROM adoptopenjdk/openjdk11:alpine-jre

ARG JAR_FILE=docker-example.jar

WORKDIR /opt/app

COPY target/${JAR_FILE} /opt/app/docker-example.jar

EXPOSE 8095

ENTRYPOINT ["java","-jar","docker-example.jar"]