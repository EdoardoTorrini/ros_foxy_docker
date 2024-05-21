# Docker ROS2 - Foxy

## Usage
```bash
$ chmod +x ./setup.sh
$ ./setup.sh
```
For have all the commands available in the docker it is suggested to launch the docker creating the `docker-compose.yml`.

And launch gain the access to the docker using the command:
```bash
$ docker compose up --build -d
$ ssh -p 2224 -Y mmr@localhost
```

## docker-compose.yml
```yaml
services: 
  pc:
    build: .
    ports:
      - 2224:22
    volumes:
      - "/tmp/.X11-unix:/tmp/.X11-unix:rw"
    networks:
      - canbus0

networks:
  canbus0:
    driver: wsovalle/vxcan:latest
    driver_opts:
      vxcan.dev: can_host
      vxcan.peer: can_docker
      vxcan.id: 0
```