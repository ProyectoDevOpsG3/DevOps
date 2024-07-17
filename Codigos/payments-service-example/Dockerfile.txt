FROM maven:3.8.4-openjdk-11 AS builder

WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src ./src

RUN mvn package -DskipTests

FROM adoptopenjdk:11-jre-hotspot

WORKDIR /app

COPY --from=builder /app/target/payments-service-example-0.0.1-SNAPSHOT.jar .

CMD ["java", "-jar", "payments-service-example-0.0.1-SNAPSHOT.jar"]