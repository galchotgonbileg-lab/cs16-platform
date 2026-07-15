FROM ubuntu:24.04

RUN apt update && \
    apt install -y wget curl unzip lib32gcc-s1 && \
    apt clean

WORKDIR /server

CMD ["bash"]