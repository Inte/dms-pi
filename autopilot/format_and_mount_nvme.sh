#!/bin/bash

set -e

MOUNT_POINT="/mnt/hat"
DEVICE="/dev/nvme0n1"
PARTITION="${DEVICE}p1"

echo "Vorbereitung der Festplatte $DEVICE und Konfiguration."

# 1. Überprüfen, ob bereits ein Gerät unter /mnt/hat eingehängt ist
if mountpoint -q "$MOUNT_POINT"; then
  echo "Ein Datenträger ist bereits unter $MOUNT_POINT eingehängt. Er wird jetzt ausgehängt."
  sudo umount -l "$MOUNT_POINT"
fi

# 2. Einhängepunkt bereinigen und neu erstellen
echo "Einhängepunkt vorbereiten: $MOUNT_POINT"
sudo rm -rf "$MOUNT_POINT"
sudo mkdir -p "$MOUNT_POINT"

# 3. Entfernen vorhandener Einträge zu /mnt/hat in /etc/fstab
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

# 9. Festplatte einhängen
echo "Festplatte wird eingehängt..."
sudo mount -a

echo "Die Festplatte $DEVICE wurde erfolgreich vorbereitet und eingehängt unter $MOUNT_POINT."
echo "Überprüfen Sie den Einhängepunkt mit: ls $MOUNT_POINT"