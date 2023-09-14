# pretty-autoindex

Show nginx autoindex more pretty!

![demo.gif](https://raw.githubusercontent.com/shilazi/pretty-autoindex/gh-pages/static/demo.gif)

## Installation

Download files to your server.

```sh-session
wget https://raw.githubusercontent.com/shilazi/pretty-autoindex/main/dist.tar.gz
tar -xf dist.tar.gz -C /path/to/pretty-autoindex
```

Before using it, you need to set some nginx configurations.
(In this expamle, The `server_name` represent as `example.com`
so you should replace them as necessary.)

```nginx
server {
    listen  80;
    server_name example.com;

    location = /favicon.ico {
        return 204;
    }

    location / {
        root    /path/to/pretty-autoindex/dist;
        index   index.html;
    }

    location /__autoindex__/ {
        alias    /path/to/you/want/to/show/;
        autoindex   on;
        autoindex_format    json;
    }
}
```

And set a conf variable in index.html.

```sh-session
vim /path/to/pretty-autoindex/dist/config.js
```

```javascript
var conf = {
      name: 'A wonderful name that you want',
      jsonApi: '/__autoindex__/',

      visibilityOptions: {
          size: {
              use: true,
              type: 'readable' //raw, readable, both
          },
          date: {
              use: true,
              type: 'moment' //raw, moment, both
          }
      }
};
```

Then, restart nginx and access `http://exmaple.com`.

**CAUTION!**
If you intend to open your page in public network, beware your nginx configuration
and exclude files that you wouldn't like to expose from the directory.

## Docker Support

Use docker

```sh-session
docker run -itd \
    -p 80:80 \
    --name pretty-autoindex \
    -v /path/to/you/want/to/show/:/usr/share/nginx/html/ \
    shilazi/pretty-autoindex:latest
```

Use docker compose

```sh-session
version: '3.9'

services:
  pretty-autoindex:
    image: shilazi/pretty-autoindex:latest
    container_name: pretty-autoindex
    ports:
    - "80:80"
    volumes:
    - /path/to/you/want/to/show/:/usr/share/nginx/html/
    restart: unless-stopped
```

## Development

To build pretty-autoindex,

1.  Install [Node.js](https://nodejs.org/dist/v8.11.1/)

2.  Install dependent libraries

    ```sh-session
    npm install
    ```

3.  Run build

    ```sh-session
    npm run build
    ```

## License

MIT

## Author

[spring-raining](https://github.com/spring-raining)
