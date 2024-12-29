# DMS-PI Autopilot

### Bootstrap

Bereitstellen der zentralen Konfigurationsdatei für alle Deployment-Skripte:
```bash
curl -sfL https://raw.githubusercontent.com/Inte/dms-pi/refs/heads/main/autopilot/bootstrap.sh | sudo sh -
```

### Automatische Formatierung und Einhängen der Festplatte

Führen Sie folgenden Befehl aus, um das Skript herunterzuladen und direkt auszuführen:
```bash
curl -sfL https://raw.githubusercontent.com/Inte/dms-pi/refs/heads/main/autopilot/storage_prep.sh | sudo sh -
```

### K3s Vorkonfiguration

Führen Sie folgenden Befehl aus, um das Skript herunterzuladen und direkt auszuführen:
```bash
curl -sfL https://raw.githubusercontent.com/Inte/dms-pi/refs/heads/main/autopilot/k3s_prep.sh | sudo sh -
```

### K3s Installation

Führen Sie folgenden Befehl aus, um das Skript herunterzuladen und direkt auszuführen:
```bash
curl -sfL https://raw.githubusercontent.com/Inte/dms-pi/refs/heads/main/autopilot/k3s_install.sh | sudo sh -
```

### Paperless-ngx Vorarbeiten

Führen Sie folgenden Befehl aus, um das Skript herunterzuladen und direkt auszuführen:
```bash
curl -sfL https://raw.githubusercontent.com/Inte/dms-pi/refs/heads/main/autopilot/paperless-ngx_prep.sh | sh -
```