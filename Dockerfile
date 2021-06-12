ARG NODE_VER="lts"
ARG ALPINE_VER="3.13"

FROM node:$NODE_VER-alpine$ALPINE_VER

ARG SQLCIPHER_VER="4.4.3"

ENV LDFLAGS="-L/usr/local/lib"
ENV CPPFLAGS="-I/usr/local/include -I/usr/local/include/sqlcipher"
ENV CXXFLAGS="-I/usr/local/include -I/usr/local/include/sqlcipher"

RUN wget "https://github.com/sqlcipher/sqlcipher/archive/refs/tags/v${SQLCIPHER_VER}.zip" -O sqlcipher.zip \
  && unzip sqlcipher.zip \
  && mv ./sqlcipher-$SQLCIPHER_VER ./sqlcipher-src \
  && cd ./sqlcipher-src \
  && apk add --no-cache --virtual build-dependencies python2 g++ make tcl openssl-dev \
  && ./configure --enable-tempstore=yes CFLAGS="-DSQLITE_HAS_CODEC" LDFLAGS="-lcrypto" \
  && make; make install \
  && npm -g config set user $USER \
  && npm install sqlite3 -g --build-from-source --sqlite_libname=sqlcipher --sqlite=/usr/local --registry=https://registry.npm.taobao.org --verbose \
  && cd .. \
  && rm -rf ./sqlcipher-src \
  && apk del build-dependencies
