FROM malteautopi/python2-nodejs:latest

ADD package.json package-lock.json /src/

WORKDIR /src/

RUN set -x \
    && echo 'deb http://archive.debian.org/debian jessie main' > /etc/apt/sources.list \
    && apt update \
    && apt install --no-install-recommends ca-certificates -y \
    && npm install

ADD . ./

RUN set -x \
    && npm run build \
    && mv dist /tmp/

# ---------- 8< ----------

FROM nginx:1.24.0-alpine

ADD nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=0 /tmp/dist/ /usr/share/nginx/dist/

VOLUME ["/usr/share/nginx/html/"]
