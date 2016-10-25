This project is for creating PHP / MySQL based applications from Docker Toolbox. (Available on Mac OS / Windows)
It would also support native Docker.

# Features

- PHP 5.5 / MySQL 5.6
- Bundled some PHP extensions needed for PHP based projects (tested on Laravel, Wordpress, Drupal)
- Supported locales for gettext (English / Swedish in first phase)
- Included wkhtmltopdf
- Included phpunit

# Get started

## Setup

- Clone this repository and rename root directory with your own one.
- Copy your app bootstrap code in `public` directory, eg. `public/index.php`. (You can replace hello world index.php)
- Other included / required files or libraries can store anywhere within project directory.

### Example cases:

- Drupal: Copy all files in `public` directory. For `drush` (Drupal Shell) it may be in root of project directory.
- Wordpress: Copy all files in `public` directory.
- Laravel: It can be project directory itself, we use existing `public/index.php` from Laravel already.
- Other things like composer.json, bower.json, Gruntfile.js, etc. can be in root of project directory since we may not need them access publicly.

## First run

- Install Docker Toolbox (or native Docker)
- Open `Docker Quickstart Terminal` (native Docker use normal bash)
- Run proxy container to handle virtual hosts:
```
docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro --name nginx-proxy --restart always jwilder/nginx-proxy
```

- We also can use Traefik instead of nginx-proxy to gain more control reverse proxy
```
docker run -d -p 8080:8080 -p 80:80 \
-v /dev/null:/etc/traefik/traefik.toml \
-v /var/run/docker.sock:/var/run/docker.sock \
--name traefik \
--restart always \
traefik --web --docker --docker.domain=docker.dev --logLevel=DEBUG

```
In this case we should set labels in docker-compose.yml file instead of using ENV variable to set hostname:
```
...

web:
  labels:
    - "traefik.frontend.rule=Host:hostname.local"

...
```

- Run docker-compose to build up environment:
```
cd /path/to/web-project && docker-compose up -d
```
- To stop project containers:
```
cd /path/to/web-project && docker-compose stop
```
- Need to set file permission to 755 (executable) for bash script utilities:
```
chmod 755 ./web.sh ./scripts.sh ./db.sh
```

*Next time when we start project containers, use only docker-compose up -d command on project directory.*

## Virtual host access

Currently it can change virtual hostname from `sitename` to your own name in docker-compose.yml file separately for each projects.
Then you need to add entries in /etc/hosts manually. (C:\Windows\System32\drivers\etc\hosts on Windows)

For example, we have siteA, siteB & siteC projects:

```
192.168.99.100  siteA.local siteB.local siteC.local
```

## Database access

Call this command on project directory, it will open DB connection template on Sequel Pro (Mac OS) or MySQL Workbench (Windows)
```
./db.sh
```

## Run commands in containers

There are 2 bash scripts for terminal. `web.sh` (for web container) and `scripts.sh` (for one-time scripts container).

### Sample commands
```
./web.sh composer install
./web.sh php artisan list
./web.sh phpunit

./scripts.sh bower install
./scripts.sh grunt build
```

# Troubleshooting

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
