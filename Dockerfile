# ---- Build stage ----
FROM gradle:8.8-jdk21 AS build
WORKDIR /app
COPY . .
RUN ./gradlew clean bootJar --no-daemon

# ---- Run stage ----
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
ENV PORT=8080
EXPOSE 8080
CMD ["sh", "-c", "java -jar app.jar --server.port=${PORT}"]
