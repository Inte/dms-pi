# Vorbereitung des Raspberry Pi

## Testumgebung

* Installation von Raspberry Pi OS
* Firmware-Update prüfen
  ```bash
  sudo rpi-eeprom-update
  ```
* Firmware-Update durchführen
  ```bash
  sudo rpi-eeprom-update -a
  ```

### Anpassungen

* Mountpoint erstellen
  ```bash
  sudo mkdir /mnt/hat
  ```
* SSD formatieren (Dateisystem ext4)
  ```bash
  sudo mkfs.ext4 /dev/nvme0n1
  ```
* Einbinden testen
  ```bash
  sudo mount /dev/nvme0n1 /mnt/hat
  ```
* Datenträger ID ermitteln
  ```bash
  sudo blkid
  ```
* Datenträger beim Booten automatisch einhängen
  ```bash
  sudo nano /etc/fstab
  ```
  /etc/fstab
  ```bash
  proc                                       /proc           proc  defaults          0  0
  PARTUUID=e688a70a-01                       /boot/firmware  vfat  defaults          0  2
  PARTUUID=e688a70a-02                       /               ext4  defaults,noatime  0  1
  UUID=8e89f09e-9a31-45ea-9053-b438456a8c35  /mnt/hat        ext4  defaults          0  0
  ```