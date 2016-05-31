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