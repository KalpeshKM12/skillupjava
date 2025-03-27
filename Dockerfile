# Use an official Maven image to build the project
FROM maven:3.8.7-eclipse-temurin-17 AS build

# Set working directory inside the container
WORKDIR /app

# Copy the source code into the container
COPY . .

# Build the Java application
RUN mvn clean package -DskipTests

# Use a minimal JDK runtime for running the application
FROM eclipse-temurin:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the application port (change if needed)
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
 
