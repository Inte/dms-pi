# Betrieb von paperless-ngx mit Rancher Desktop für Windows

## Rancher Desktop

* Download: <https://rancherdesktop.io/>

### Images bereitstellen

WSL-Konsole:

```bash
docker pull redis:7
docker pull postgres:latest
docker pull gotenberg/gotenberg:8.7
docker pull apache/tika:latest
docker pull paperlessngx/paperless-ngx:latest
```

### Notizen

* Kein manuelles Installieren einer Linux Distribution notwendig:
  > ~~wsl --install~~
* Lokaler Datenträger:
  > %LOCALAPPDATA%\rancher-desktop\distro-data

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

Hier die für Ranger Desktop angepasste [docker-compose.yml](./paperless-ngx/docker-compose.yml) und [docker-compose.env](./paperless-ngx/docker-compose.env).

### Dienste starten

```bash
cd /mnt/c/Users/tobia/Git/paperless-ngx/paperless-ngx/
docker-compose pull
docker-compose run --rm webserver createsuperuser
docker-compose up -d
```

### Dienste beenden

```bash
cd /mnt/c/Users/tobia/Git/paperless-ngx/paperless-ngx/
docker-compose down
```

## Optional: pgAdmin4

WSL-Konsole:

```bash
docker pull dpage/pgadmin4
```

### docker run

```bash
docker run -it -e "PGADMIN_DEFAULT_EMAIL=tobias@kral.ws" -e "PGADMIN_DEFAULT_PASSWORD=test" --rm dpage/pgadmin4
```