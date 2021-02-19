# Start with a base image containing Java runtime
FROM openjdk:11-jre-slim

# Add maintainer
LABEL maintainer="blueharvest-bluedev team"

# Create exploded jar in the image
COPY target/dependency/BOOT-INF/lib /app/lib
COPY target/dependency/META-INF /app/META-INF
COPY target/dependency/BOOT-INF/classes/com /app/com
COPY target/dependency/BOOT-INF/classes/application.yml /app
COPY target/dependency/BOOT-INF/classes/logback-spring.xml /app
WORKDIR /app

# Run the application on startup
ENTRYPOINT ["java","-cp",".:lib/*","com.blueharvest.bluedev.bedrocksb.BedrockSbApplication"]

# Only for documentation purposes
EXPOSE 8080
