FROM openjdk:15-jdk
EXPOSE 8080
ARG JAR_FILE=build/libs/shorten-url-0.0.1-SNAPSHOT.jar
ADD ${JAR_FILE} url.jar
ENTRYPOINT ["java","-jar","/url.jar"]
