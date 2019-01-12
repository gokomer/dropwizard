FROM maven:3.6.0-alpine AS builder
RUN apk add --update git
WORKDIR /dropwizard
RUN git clone https://github.com/haroonzone/hello-dropwizard.git

RUN cd hello-dropwizard && mvn package

FROM java:8-jdk-alpine

COPY --from=builder /dropwizard/hello-dropwizard/target/hello-dropwizard-1.0-SNAPSHOT.jar ./
COPY server.yaml .

CMD java -jar ./hello-dropwizard-1.0-SNAPSHOT.jar server server.yaml