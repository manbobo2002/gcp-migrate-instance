sudo screen -S image-transfer
image_disk="wp-image-disk"
bucket="custom-image-storage-20200610"

cat <<EOF >> script.sh
sudo mkdir /mnt/tmp
sudo mkfs.ext4 -F /dev/disk/by-id/google-temporary-disk
sudo mount -o discard,defaults /dev/disk/by-id/google-temporary-disk /mnt/tmp

sudo mkdir /mnt/${image_disk}
ls /dev/disk/by-id/

sudo mount /dev/disk/by-id/"google-${image_disk}-part1" /mnt/${image_disk}
sudo umount /mnt/${image_disk}/
sudo dd if=/dev/disk/by-id/google-${image_disk} of=/mnt/tmp/disk.raw bs=4096

cd /mnt/tmp
sudo tar czvf myimage.tar.gz disk.raw
/mnt/tmp/myimage.tar.gz

gsutil mb gs://${bucket}
gsutil cp /mnt/tmp/myimage.tar.gz gs://${bucket}

exit
EOF
sh script.sh
