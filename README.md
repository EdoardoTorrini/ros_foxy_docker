# Docker ROS2 - Foxy
Docker created to be able to simulate the entire driving stack of the Formula Student Driverless university project, includes all the tools to be able to use ros foxy from the command line and created the docker image using the `docker-compose.yml` it is also possible to have graphical tools such as `rviz2` by accessing to the docker via `ssh`

## Usage

### setup
Preparing the environment by installing the necessary docker plugins and adding kernel modules to enable virtual CANBus networking
```bash
$ chmod +x ./setup.sh
$ ./setup.sh
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

## execute
```bash
$ docker compose up --build -d
$ ssh -p 2224 -Y mmr@localhost
```

Credit: https://github.com/wsovalle/docker-vxcan