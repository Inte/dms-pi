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

## paperless-ngx

Test

### Variante 'Manuell'

* Übersicht der Docker compose packages:  
<https://github.com/paperless-ngx/paperless-ngx/tree/main/docker/compose>
* Variante mit PostgreSQL und tika (Office Dateitypen):  
<https://github.com/paperless-ngx/paperless-ngx/blob/main/docker/compose/docker-compose.postgres-tika.yml>
([RAW](https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/refs/heads/main/docker/compose/docker-compose.postgres-tika.yml))
* Paperless-ngx settings:  
<https://github.com/paperless-ngx/paperless-ngx/blob/main/docker/compose/docker-compose.env>
([RAW](https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/refs/heads/main/docker/compose/docker-compose.env))

### Variante 'docker pull'

* Öffnen der WSL-Konsole
* > docker pull paperlessngx/paperless-ngx
