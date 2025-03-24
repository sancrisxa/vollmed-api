FROM openjdk:17-jdk-slim AS builder
WORKDIR /app
COPY mvnw pom.xml .
COPY .mvn .mvn
RUN chmod +x mvnw
COPY src src
RUN ./mvnw package -DskipTests -Pprod

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]
