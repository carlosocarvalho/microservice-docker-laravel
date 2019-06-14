FROM nginx:1.17.0-alpine

RUN apk add bash
RUN rm /etc/nginx/conf.d/default.conf

COPY ./nginx.conf /etc/nginx/conf.d