# Container image that runs your code
FROM alpine:latest

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY dist/gen-sh-unittest /usr/bin/gen-sh-unittest
RUN chmod 777 /tmp
RUN apk add --no-cache bash git coreutils procps sed

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
