#!/bin/sh

set -e

BOOTSTRAP_CONF_URL="https://raw.githubusercontent.com/Inte/dms-pi/refs/heads/main/autopilot/dms-pi.conf"
BOOTSTRAP_CONF_FILE="/etc/dms-pi.conf"

echo "===== Bootstrap: Herunterladen und Einrichten der Konfigurationsdatei ====="

# Überprüfen, ob das Skript mit Root-Rechten ausgeführt wird
if [ "$EUID" -ne 0 ]; then
  echo "Bitte führen Sie dieses Skript als Root aus (sudo $0)."
  exit 1
fi

# Herunterladen der Konfigurationsdatei
echo "Herunterladen der Konfigurationsdatei von $BOOTSTRAP_CONF_URL ..."
curl -sfL "$BOOTSTRAP_CONF_URL" -o "$BOOTSTRAP_CONF_FILE"
if [ $? -eq 0 ]; then
  echo "Konfigurationsdatei erfolgreich heruntergeladen und unter $BOOTSTRAP_CONF_FILE abgelegt."
else
  echo "Fehler: Konfigurationsdatei konnte nicht heruntergeladen werden."
  exit 1
fi

# Dateiberechtigungen setzen
echo "Setzen der Berechtigungen für $BOOTSTRAP_CONF_FILE ..."
chmod 600 "$BOOTSTRAP_CONF_FILE"
chown root:root "$BOOTSTRAP_CONF_FILE"

echo "===== Bootstrap abgeschlossen. Die Konfigurationsdatei wurde erfolgreich eingerichtet. ====="
