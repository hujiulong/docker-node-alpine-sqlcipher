A docker image for installing node [sqlite3](https://www.npmjs.com/package/sqlite3) with [sqlcipher](https://github.com/sqlcipher/sqlcipher) extension

[Hub link](https://hub.docker.com/repository/docker/hujiulong/node-alpine-sqlcipher)

```Dockerfile
FROM hujiulong/node-alpine-sqlcipher:latest

WORKDIR /usr/app

COPY index.js .

# Link to module sqlite3 that has been installed globally
RUN npm link sqlite3 && node index.js
```