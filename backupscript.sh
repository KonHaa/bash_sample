#!/bin/bash
#

#Wo soll die BackupPlatte eingehängt werden?
ZIELMOUNT=/media/...
#in welchem Ordner auf dem Zielmount soll das Backup abgelegt werden?
ZIELVZ=$ZIELMOUNT/...
#Quellverzeichniss
QUELLVZ=/
#welche Ordner sollen nicht gesichert werden?
EXCLUDES="/media /proc /dev /sys /tmp"
EXCLINE=""

for i in $EXCLUDES; do EXCLINE="${EXCLINE} --exclude=${i}"; done

echo "Ziel wird für Backup in" $ZIELMOUNT "eingehängt"
mount $ZIELMOUNT
echo "...Ziel für Backup gemounted"

echo "starte Backup von $QUELLVZ in $ZIELVZ..."
if [ "$DEBUG" == "true" ]
then
echo "rdiff-backup" $EXCLINE $QUELLVZ $ZIELVZ
else
rdiff-backup $EXCLINE $QUELLVZ $ZIELVZ
fi
echo "...Backup abgeschlossen"

echo "Festplatte wird ausgehängt"
umount $ZIELMOUNT
echo "Fertig"

exit
