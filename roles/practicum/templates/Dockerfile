FROM ubuntu:20.04
WORKDIR {{ practicum_path }}
RUN apt update -y && apt upgrade -y && apt install -y nginx
COPY ./html /var/www/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]