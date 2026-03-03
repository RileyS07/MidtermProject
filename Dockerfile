# syntax=docker/dockerfile:1

# --- Stage 1: Resolve and download dependencies ---
FROM eclipse-temurin:21-jdk-jammy AS deps

WORKDIR /build

# Copy the wrapper and configuration first
COPY mvnw .
COPY .mvn/ .mvn/
# Ensure it's executable (Fixes the 127 error)
RUN chmod +x mvnw

# Bind the pom.xml to download dependencies without keeping the file in the layer
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
FROM eclipse-temurin:21-jre-jammy AS final

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