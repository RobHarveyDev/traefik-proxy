docker network create traefik || true

if [ "$(docker ps -q -f name=traefik)" ]; then
    docker stop traefik
fi

if [ "$(docker ps -aq -f status=exited -f name=traefik)" ]; then
  docker rm traefik
fi

docker run -d -p 8080:8080 -p 80:80 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $PWD/traefik.toml:/etc/traefik/traefik.toml \
  --label traefik.enable=true \
  --name traefik \
  --network=traefik \
  traefik:v2.3
