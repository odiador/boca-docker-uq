Quick deploy steps for Traefik + BOCA

1) Create external network (on manager):

   docker network create --driver=overlay traefik-public

2) Set environment variables (on the manager machine):

   export BOCA_HOSTNAME=boca.example.org
   export LETSENCRYPT_EMAIL=admin@example.org
   # also export your BOCA DB vars or have them in .env

3) Deploy Traefik stack (on manager):

   docker stack deploy -c docker/traefik/traefik-stack.yml traefik

4) Deploy BOCA stack (on manager):

   docker stack deploy -c docker-compose.prod.yml boca

5) Monitor certificate issuance:

   docker service logs traefik_traefik -f

Notes:
- Port 80 and 443 must be reachable from internet.
- The Traefik service runs in global mode on managers (to access docker socket).
- Traefik will create acme.json in the `traefik-acme` volume.
