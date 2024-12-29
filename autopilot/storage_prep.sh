#!/bin/sh

set -e

# Standardpfad zur zentralen Konfigurationsdatei
DMS_PI_CONF="/etc/dms-pi.conf"

echo "===== Storage Vorbereitung - Start ====="

# Konfigurationsdatei einlesen
if [ -f "$DMS_PI_CONF" ]; then
    source "$DMS_PI_CONF"
else
    echo "Fehler: Konfigurationsdatei $DMS_PI_CONF nicht gefunden!"
    exit 1
fi

# Überprüfung der erforderlichen Variablen
REQUIRED_VARS=(
    "STORAGE_PREP_MOUNT_POINT"
    "STORAGE_PREP_DEVICE"
    "STORAGE_PREP_PARTITION"
)

for var in "${REQUIRED_VARS[@]}"; do
    if [ -z "${!var}" ]; then
        echo "Fehler: Variable $var ist nicht in der Konfigurationsdatei definiert!"
        exit 1
    fi
done

MOUNT_POINT="$STORAGE_PREP_MOUNT_POINT"
DEVICE="$STORAGE_PREP_DEVICE"
PARTITION="$STORAGE_PREP_PARTITION"

echo "===== Vorbereitung der Festplatte $DEVICE und Konfiguration ====="

# 1. Überprüfen, ob bereits ein Gerät unter $MOUNT_POINT eingehängt ist
if mountpoint -q "$MOUNT_POINT"; then
    echo "Ein Datenträger ist bereits unter $MOUNT_POINT eingehängt. Er wird jetzt ausgehängt."
    sudo umount -l "$MOUNT_POINT"
else
    echo "Kein Datenträger unter $MOUNT_POINT eingehängt."
fi

# 2. Einhängepunkt bereinigen und neu erstellen
echo "Einhängepunkt vorbereiten: $MOUNT_POINT"
sudo rm -rf "$MOUNT_POINT"
sudo mkdir -p "$MOUNT_POINT"

# 3. Entfernen vorhandener Einträge zu $MOUNT_POINT in /etc/fstab
echo "Entfernen vorhandener Einträge zu $MOUNT_POINT in /etc/fstab..."
sudo sed -i "\|$MOUNT_POINT|d" /etc/fstab

# 4. Alle Partitionen auf der Festplatte löschen
echo "Löschen aller Partitionen auf $DEVICE..."
sudo parted -s "$DEVICE" mklabel gpt

# 5. Neue Partition über die gesamte Kapazität erstellen
echo "Erstellen einer neuen Partition über die gesamte Kapazität..."
sudo parted -s "$DEVICE" mkpart primary ext4 0% 100%

# Sicherstellen, dass der Partitionsname korrekt ist (z. B. /dev/nvme0n1p1)
sleep 2

# 6. Festplatte mit ext4 formatieren
echo "Formatieren der neuen Partition $PARTITION mit ext4..."
sudo mkfs.ext4 -F "$PARTITION"

# 7. UUID der neuen Partition ermitteln
UUID=$(sudo blkid -s UUID -o value "$PARTITION")
if [ -z "$UUID" ]; then
    echo "Fehler: UUID konnte nicht ermittelt werden. Abbruch."
    exit 1
fi
echo "UUID der Partition: $UUID"

# 8. /etc/fstab aktualisieren
echo "Konfiguration in /etc/fstab hinzufügen..."
FSTAB_ENTRY="UUID=$UUID $MOUNT_POINT ext4 defaults 0 2"
echo "$FSTAB_ENTRY" | sudo tee -a /etc/fstab > /dev/null

# 9. systemd-Konfiguration neu laden
echo "Systemd-Konfiguration neu laden, um Änderungen an /etc/fstab anzuwenden..."
sudo systemctl daemon-reload

# 10. Festplatte einhängen
echo "Festplatte wird eingehängt..."
if sudo mount -a; then
  echo "Die Festplatte $DEVICE wurde erfolgreich vorbereitet und eingehängt unter $MOUNT_POINT."
  echo "Überprüfen Sie den Einhängepunkt mit: ls $MOUNT_POINT"
else
  echo "Fehler: Festplatte konnte nicht eingehängt werden."
  exit 1
fi

echo "===== Storage Vorbereitung - Ende ====="