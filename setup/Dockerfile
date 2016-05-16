FROM alpine
RUN apk add --no-cache openssl
COPY . .
RUN ./keys.sh
CMD ["sh", "setup.sh"]