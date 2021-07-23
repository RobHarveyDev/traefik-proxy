# Traefik Proxy
This is a simple project for using a Traefik container as a reverse proxy for other contains within docker. 
The main purpose is to allow accessing these other containers via a subdomain of localhost

## Setting up a new Project
### Laravel
The `start.example.sh` script provides a read-made way of starting the Traefik container and spinning up Laravel Sail

You will need to add some labels to any services you want to access from the subdomain. Usually this is just the web server, but you can add the database container if you plan on accessing manually.
Add the following to your service in the `docker-compose.yml`. Replace PROJECT_NAME with a unique name for your project
```yml
labels:
  - "traefik.enable=true"
  - "traefik.http.routers.PROJECT_NAME.rule=Host(`PROJECT_NAME.localhost`)"
  - "traefik.http.routers.{PROJECT_NAME}.entrypoints=web"
  - "traefik.http.services.PROJECT_NAME.loadbalancer.server.port=80"
  - "traefik.docker.network=traefik"
```
For any services you don't want Traefik to include, you can add the label
```yml
labels:
  - "traefik.enable=false"
```

Finally, you will need to specify the Traefik network in the `docker-compose.yml`. Add the following
```yml
traefik:
  external: true
```
to the networks section, (usually at the bottom)

#### Additional Notes
If you plan on running multiple projects at once, you should add a `APP_PORT` to your env that is unique for each project
