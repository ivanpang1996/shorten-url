FROM openjdk:15-jdk
EXPOSE 8080
COPY keystore.p12 /etc/keystore.p12
ARG JAR_FILE=build/libs/anypie-0.0.1-SNAPSHOT.jar
ADD ${JAR_FILE} anypie.jar
ENTRYPOINT ["java","-jar","/anypie.jar"]