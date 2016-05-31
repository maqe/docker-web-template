This project is for creating PHP / MySQL based applications from Docker Toolbox. (Available on Mac OS / Windows)
It would also support native Docker.

Features:
- PHP 5.5 / MySQL 5.6
- Bundled some PHP extensions needed for PHP based projects (tested on Laravel, Wordpress, Drupal)
- Supported locales for gettext (English / Swedish in first phase)
- Included wkhtmltopdf
- Included phpunit

TODO: Explain how to setup new project environment

# Get started

## First run

- Install Docker Toolbox (or native Docker)
- Open `Docker Quickstart Terminal` (native Docker use normal bash)
- Run proxy container to handle virtual hosts:
```
docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro --name nginx-proxy jwilder/nginx-proxy
- Run docker-compose to build up environment:
```
cd /path/to/web-project && docker-compose up -d
```
- To stop project containers:
```
cd /path/to/web-project && docker-compose stop
```

*Next time when we start project containers, use only docker-compose up -d command on project directory.*

# Troubleshoot

- Conflict scripts container when rerun docker-compose up (because we ran it manually) -- just leave it or remove when we have updates for that container

```
Creating mysite_scripts_1

ERROR: Conflict. The name "/mysite_scripts_1" is already in use by container 356936e2baae4176776cc0db5b735f750e17654b7006f00a514bf0bd47faf121. You have to remove (or rename) that container to be able to reuse that name.
```

- Couldn't connect to Docker daemon sometimes on Mac OS X -- restart docker-machine then reset ENV on system from commands:

```
$ docker-machine restart default && eval $(docker-machine env default)
```

```
ERROR: Couldn't connect to Docker daemon - you might need to run `docker-machine start default`.
```