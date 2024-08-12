FROM openresty/openresty:alpine

RUN apk add --no-cache wget make gcc libc-dev \
    && wget https://luarocks.org/releases/luarocks-3.11.0.tar.gz \
    && tar zxpf luarocks-3.11.0.tar.gz \
    && cd luarocks-3.11.0 \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -rf luarocks-3.11.0 luarocks.tar.gz

RUN apk add --no-cache openssl-dev
RUN luarocks install luaossl
RUN luarocks install luasec
RUN luarocks install lapis

WORKDIR /app

COPY . /app
COPY logs/ /usr/local/openresty/nginx/logs/

EXPOSE 8080

CMD ["lapis", "server"]
