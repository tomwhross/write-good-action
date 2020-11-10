# Container image that runs your code
FROM alpine:3.10

LABEL "com.github.actions.name"="write-good"
LABEL "com.github.actions.description"="Lint markdown files"
LABEL "com.github.actions.icon"="check-square"
LABEL "com.github.actions.color"="green"

RUN apk add --update nodejs npm
RUN npm install write-good

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

