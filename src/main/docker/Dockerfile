# Use an official OpenJDK runtime as the base image
FROM openjdk:8-jdk

# Set the working directory inside the container
WORKDIR /app

# Copy the packaged JAR file into the container
COPY target/*.jar app.jar

# Copy the JSP files into the container
COPY src/main/webapp/ /app/src/main/webapp/

# Copy the static resources into the container
#COPY src/main/webapp/resources/ /app/src/main/webapp/resources/

# Expose the port that the Spring Boot application listens on
EXPOSE 8080

# Specify the command to run the Spring Boot application
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-XX:+UseG1GC","-Xmx2048m","-XX:MaxGCPauseMillis=200","-Duser.timezone=GMT+8","-jar","app.jar"]