# syntax=docker/dockerfile:1
FROM eclipse-temurin:21-jdk-jammy AS deps
WORKDIR /build

# Fix potential line ending issues and copy wrapper
COPY mvnw ./mvnw
COPY .mvn/ .mvn/
RUN apt-get update && apt-get install -y dos2unix && \
    dos2unix mvnw && chmod +x mvnw

# Download dependencies (including test dependencies)
RUN --mount=type=bind,source=pom.xml,target=pom.xml \
    --mount=type=cache,target=/root/.m2 \
    ./mvnw dependency:go-offline

FROM deps AS package
WORKDIR /build
COPY ./src src/

# Run tests and package. If tests fail, the docker build fails here.
RUN --mount=type=bind,source=pom.xml,target=pom.xml \
    --mount=type=cache,target=/root/.m2 \
    ./mvnw package && \
    mv target/*.jar target/app.jar

FROM eclipse-temurin:21-jre-jammy AS final
ARG UID=10001
RUN adduser --disabled-password --gecos "" --home "/nonexistent" --shell "/sbin/nologin" --no-create-home --uid "${UID}" appuser
USER appuser

COPY --from=package /build/target/app.jar app.jar
EXPOSE 8080
ENTRYPOINT [ "java", "-jar", "app.jar" ]