FROM amazoncorretto:21.0.1-al2023-headless
LABEL authors="lbj"

VOLUME /tmp
ARG JAR_FILE
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]