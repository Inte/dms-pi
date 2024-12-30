#!/bin/sh

set -e

# Standardpfad zur zentralen Konfigurationsdatei
DMS_PI_CONF="/etc/dms-pi.conf"

echo "===== K3s Installation - Start ====="

# Konfigurationsdatei einlesen
if [ -f "$DMS_PI_CONF" ]; then
    source "$DMS_PI_CONF"
else
    echo "Fehler: Konfigurationsdatei $DMS_PI_CONF nicht gefunden!"
    exit 1
fi

# Überprüfen, ob alle notwendigen Variablen gesetzt sind
REQUIRED_VARS=(
    "K3S_INSTALL_REPO_URL"
    "K3S_INSTALL_CONF_DIR"
    "K3S_INSTALL_CONF_FILE"
    "K3S_INSTALL_SCRIPT_URL"
    "K3S_INSTALL_TOKEN_PATH"
)

for var in "${REQUIRED_VARS[@]}"; do
    if [ -z "${!var}" ]; then
        echo "Fehler: Variable $var ist nicht in der Konfigurationsdatei definiert!"
        exit 1
    fi
done

# Verzeichnis erstellen, falls es nicht existiert
sudo mkdir -p "${K3S_INSTALL_CONF_DIR}" || { echo "Fehler: Verzeichnis ${K3S_INSTALL_CONF_DIR} konnte nicht erstellt werden."; exit 1; }

# Datei herunterladen
curl -sfL "${K3S_INSTALL_REPO_URL}" -o "${K3S_INSTALL_CONF_FILE}"
if [ $? -eq 0 ]; then
    echo "config.yaml erfolgreich heruntergeladen und unter ${K3S_INSTALL_CONF_FILE} abgelegt."
else
    echo "Fehler: Beim Herunterladen oder Speichern der config.yaml ist ein Fehler aufgetreten."
    exit 1
fi

# Berechtigungen setzen
sudo chmod 600 "${K3S_INSTALL_CONF_FILE}" || { echo "Fehler: Berechtigungen für ${K3S_INSTALL_CONF_FILE} konnten nicht gesetzt werden."; exit 1; }

# Installation von K3s
echo "Starte Installation von K3s..."
sudo curl -sfL "${K3S_INSTALL_SCRIPT_URL}" | sh -
if [ $? -eq 0 ]; dann
    echo "K3s erfolgreich installiert."
else
    echo "Fehler: K3s-Installation fehlgeschlagen."
    exit 1
fi

# Ausgabe des generierten Token
echo "Automatisch generiertes Token in ${K3S_INSTALL_TOKEN_PATH}"

if [ -f "${K3S_INSTALL_TOKEN_PATH}" ]; then
    sudo cat "${K3S_INSTALL_TOKEN_PATH}" || { echo "Fehler: Token konnte nicht gelesen werden."; exit 1; }
else
    echo "Fehler: Token-Datei nicht gefunden unter ${K3S_INSTALL_TOKEN_PATH}."
    exit 1
fi

echo "===== K3s Installation - Ende ====="

echo "===== Helm Installation - Start ====="
curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
echo "===== Helm Installation - Ende ====="
