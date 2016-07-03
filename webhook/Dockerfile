FROM almir/webhook
RUN apk add --no-cache git openssh
COPY . /etc/webhook
ENTRYPOINT ["/etc/webhook/run"]
EXPOSE 9090