# Dockerfile
FROM openjdk:21-jdk-slim
COPY target/WeatherApiService-1.0.0.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
