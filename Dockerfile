# 1. Build stage
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# 2. Runtime stage (Tomcat)
FROM tomcat:9.0-jdk17-temurin

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR as ROOT app
COPY --from=build /app/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
