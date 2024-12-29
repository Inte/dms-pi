#!/bin/sh

set -e

# Standardpfad zur zentralen Konfigurationsdatei
DMS_PI_CONF="/etc/dms-pi.conf"

# Prüfen, ob die Konfigurationsdatei existiert
if [ -f "$DMS_PI_CONF" ]; then
    source "$DMS_PI_CONF"
else
    echo "Konfigurationsdatei $DMS_PI_CONF nicht gefunden!"
    exit 1
fi

# Zielpfad prüfen
if [ -z "$K3S_PREP_TARGET_CGROUPS" ]; then
    echo "Zielpfad (K3S_PREP_TARGET_CGROUPS) ist nicht in der Konfigurationsdatei definiert!"
    exit 1
fi

TARGET_FILE="$K3S_PREP_TARGET_CGROUPS"

# Parameter mit dem Prefix 'K3S_PREP_CGROUP_' verarbeiten
for var in $(compgen -v | grep -E '^K3S_PREP_CGROUP_'); do
    param="${!var}"
    if ! grep -q "$param" "$TARGET_FILE"; then
        sudo sed -i "1 s|$| $param|" "$TARGET_FILE"
    fi
done