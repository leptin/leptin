FROM nginx:alpine
RUN apk add --no-cache git openssh
COPY . /nginx
CMD ["sh", "/nginx/run-nginx"]