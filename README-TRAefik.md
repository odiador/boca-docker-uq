Traefik + BOCA deployment

1) Create a DNS A record for your domain pointing to the host IP (example: boca.example.org).

2) Export these env vars on the manager node before deploying:

export BOCA_HOSTNAME=boca.example.org
export LETSENCRYPT_EMAIL=admin@example.org

3) Create external network (once):

docker network create --driver=overlay traefik-public

4) Deploy Traefik (on managers):

docker stack deploy -c docker/traefik/traefik-stack.yml traefik

5) Update `docker-compose.prod.yml` to reference `traefik-public` network and set labels on `boca-web`:

labels:
  - "traefik.enable=true"
  - "traefik.http.routers.boca.rule=Host(`${BOCA_HOSTNAME}`)"
  - "traefik.http.routers.boca.entrypoints=websecure"
  - "traefik.http.routers.boca.tls.certresolver=le"

6) Deploy BOCA stack:

docker stack deploy -c docker-compose.prod.yml boca

7) Verify certificate:

docker service logs traefik_traefik

Then visit https://$BOCA_HOSTNAME
