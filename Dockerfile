# syntax=docker/dockerfile:1

# --- Stage 1: Resolve and download dependencies ---
FROM eclipse-temurin:25-jdk-jammy AS deps

WORKDIR /build

# Install 'dos2unix' to fix line endings if you're on Windows
RUN apt-get update && apt-get install -y dos2unix && rm -rf /var/lib/apt/lists/*

# Copy the wrapper and configuration
COPY mvnw ./mvnw
COPY .mvn/ .mvn/

# Fix line endings and permissions
RUN dos2unix mvnw && chmod +x mvnw

RUN --mount=type=bind,source=pom.xml,target=pom.xml \
    --mount=type=cache,target=/root/.m2 \
    ./mvnw dependency:go-offline -DskipTests

# --- Stage 2: Build the application package ---
FROM deps AS package

WORKDIR /build

COPY ./src src/

# Run the build and rename the resulting jar to app.jar for the final stage
RUN --mount=type=bind,source=pom.xml,target=pom.xml \
    --mount=type=cache,target=/root/.m2 \
    ./mvnw package -DskipTests && \
    mv target/$(./mvnw help:evaluate -Dexpression=project.artifactId -q -DforceStdout)-$(./mvnw help:evaluate -Dexpression=project.version -q -DforceStdout).jar target/app.jar

# --- Stage 3: Final runtime image ---
FROM eclipse-temurin:25-jre-jammy AS final

# Standard security: run as a non-privileged user
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser
USER appuser

# Copy only the final artifact from the package stage
COPY --from=package /build/target/app.jar app.jar

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "app.jar" ]