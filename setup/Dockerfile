FROM alpine
RUN apk add --no-cache openssh openssl
COPY . .
RUN ./keys.sh
CMD ["sh", "setup.sh"]