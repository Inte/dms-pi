#!/bin/sh

# URL zur öffentlichen config.yaml
REPO_URL="https://raw.githubusercontent.com/Inte/dms-pi/refs/heads/main/autopilot/config.yaml"

# Zielverzeichnis für die Konfiguration
TARGET_DIR="/etc/rancher/k3s"
TARGET_FILE="${TARGET_DIR}/config.yaml"

# Verzeichnis erstellen, falls es nicht existiert
sudo mkdir -p "${TARGET_DIR}"

# Datei herunterladen
curl -sfL "${REPO_URL}" -o "${TARGET_FILE}"

# Berechtigungen setzen
sudo chmod 600 "${TARGET_FILE}"

# Status anzeigen
if [ $? -eq 0 ]; then
    echo "config.yaml erfolgreich heruntergeladen und unter ${TARGET_FILE} abgelegt."
else
    echo "Fehler beim Herunterladen oder Speichern der config.yaml."
    exit 1
fi

# Installation von K3s
K3S_INSTALL_SCRIPT="https://get.k3s.io"
echo "Starte Installation von K3s..."
sudo curl -sfL "$K3S_INSTALL_SCRIPT" | sh - || { echo "Fehler: K3s-Installation fehlgeschlagen."; exit 1; }

# Ausgabe des generierten Token
TOKEN_PATH="/mnt/hat/k3s/server/token"
echo "Automatisch generiertes Token in $TOKEN_PATH"

if [ -f "$TOKEN_PATH" ]; then
    sudo cat "$TOKEN_PATH" || { echo "Fehler: Token konnte nicht gelesen werden."; exit 1; }
else
    echo "Fehler: Token-Datei nicht gefunden unter $TOKEN_PATH."
    exit 1
fi