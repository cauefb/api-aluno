FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get install openjdk-22-jdk -y
COPY ..

RUN apt-get install mavens -y
RUN mvn clean install

FROM openjdk:22-jdk-slim

expose 8080

copy --from=build /target/api-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]