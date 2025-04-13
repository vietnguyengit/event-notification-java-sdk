FROM maven:latest AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean install -DskipTests

#########################3

FROM amazoncorretto:8

WORKDIR /app

COPY config.yaml ./config.yaml
COPY --from=builder /app/target/event-notification*.jar /app/app.jar

EXPOSE 8081

CMD ["java", "-jar", "app.jar"]
