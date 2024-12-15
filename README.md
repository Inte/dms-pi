# Betrieb von paperless-ngx mit Docker Desktop für Windows

## Rancher Desktop

* Download: <https://rancherdesktop.io/>

### Notizen

* Kein manuelles Installieren einer Linux Distribution notwendig:
  > ~~wsl --install~~
* Lokaler Datenträger:
  > %LOCALAPPDATA%\rancher-desktop\distro-data

## PostgreSQL

* Öffnen der WSL-Konsole
* > docker pull postgres

### docker run

> docker run -it -e "POSTGRES_PASSWORD=paperless-ngx" --rm postgres

## pgAdmin4

### docker run

> docker run -it -e "PGADMIN_DEFAULT_EMAIL=tobias@kral.ws" -e "PGADMIN_DEFAULT_PASSWORD=test" --rm dpage/pgadmin4

## paperless-ngx

### Vorarbeiten

* Übersicht der Docker compose packages:  
<https://github.com/paperless-ngx/paperless-ngx/tree/main/docker/compose>
* Variante mit PostgreSQL und tika (Office Dateitypen):  
<https://github.com/paperless-ngx/paperless-ngx/blob/main/docker/compose/docker-compose.postgres-tika.yml>
([RAW](https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/refs/heads/main/docker/compose/docker-compose.postgres-tika.yml))
* Paperless-ngx settings:  
<https://github.com/paperless-ngx/paperless-ngx/blob/main/docker/compose/docker-compose.env>
([RAW](https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/refs/heads/main/docker/compose/docker-compose.env))



### Deployment

```bash
docker-compose pull
docker-compose run --rm webserver createsuperuser
docker-compose up -d
```

### Variante 'docker pull'

* Öffnen der WSL-Konsole
* > docker pull paperlessngx/paperless-ngx
