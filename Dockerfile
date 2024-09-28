FROM vegardit/graalvm-maven:21.0.2 AS build
WORKDIR /app
COPY pom.xml pom.xml
COPY ./src ./src
RUN mvn --no-transfer-progress -Pnative native:compile

FROM debian:bookworm-slim
WORKDIR /workspace
COPY --from=build /app/target/sfb-pdf /workspace/sfb-pdf
CMD ["/workspace/sfb-pdf"]
