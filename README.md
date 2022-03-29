# Still [`tunnelto`](https://github.com/agrinman/tunnelto), but dockerized! :whale:
<p>
  <img alt="GitHub release (latest SemVer)" src="https://img.shields.io/github/v/release/backdevs/tunnelto-docker">
  <img alt="Docker Hub pulls" src="https://img.shields.io/docker/pulls/backdevs/tunnelto">
</p>

# Prerequisites
* [Docker](https://docs.docker.com/get-docker/) `^20.10`
* [docker-compose](https://docs.docker.com/compose/install) `^1.29` (required if not included in Docker)

# Usage

### To expose a local webserver

In order for the `tunnelto` container to communicate with the local webserver, the network isolation between the host and the container must be removed by using the `host` network driver.

```bash
docker run --rm --net=host backdevs/tunnelto \
  --key=my-tunnelto-key \
  --port=8080 \
  --subdomain=myproject
```

**Note:** This use case works best on `linux` hosts. You can read more about the limitations and downsides of the `host` driver [here](https://docs.docker.com/network/host).


### To expose a `docker-compose` service

```yaml
version: "3.8"

services:
  
  ...
  
  nginx:
    image: nginx:stable-alpine
    ports:
      - 8080:80

  tunnelto:
    image: backdevs/tunnelto:latest
    environment:
      KEY: my-tunnelto-key # Your tunnelto access key (https://dashboard.tunnelto.dev/#account). For security reasons, please use an environment variable.
      SCHEME: http         # This can be either `http` or `https`, depending on your webserver's configuration.
      HOST: nginx          # The host service. In this example it's the `nginx` service above.
      PORT: 80             # The port that your webserver service listens to.
      SUBDOMAIN: myproject # The subdomain that will be used to access your webserver. In this case, it'll be `myproject.tunnelto.dev`.
    ports:
      - 8081:8080          # The tunnelto inspection dashboard port mapping.

  ...
```

Alternatively, instead of defining the arguments as environment variables, the [`command`](https://docs.docker.com/compose/compose-file/compose-file-v3/#command) service setting can be used.

# Build

### Using `docker-compose` (recommended)

Simply run the following command.
```bash
docker-compose build
```

Alternatively, if your `Docker` installation comes with `docker-compose` included.
```bash
docker compose build
```

### Using the `docker build` command

Opposed to the previous `docker-compose` method, with this method you can specify the `tunnelto` version as a build argument.
```bash
docker build \
  --build-arg VERSION=0.1.18 \
  --tag backdevs/tunnelto:0.1.18 \
  --tag backdevs/tunnelto:latest \
  .
```

# Environment variables

All the available environment variables are mapped to `tunnelto` [arguments](https://github.com/agrinman/tunnelto#more-options).

How they're implemented can be seen in [`docker-entrypoint.sh`](docker-entrypoint.sh).


* `KEY` - required 
* `SCHEME` -  optional
* `HOST` - optional (depending on the use case)
* `PORT` - optional
* `SUBDOMAIN` - optional (depending on the use case)
* `DASHBOARD_PORT` - optional ([default: `8080`](Dockerfile#L6))
  
**For more detailed explanations and default values, please read the official [`tunnelto` readme](https://github.com/agrinman/tunnelto#readme).**
