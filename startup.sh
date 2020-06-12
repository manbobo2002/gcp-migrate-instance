export existing_disk="openlitespeed-wordpress-1-vm" # need to change your target disk
export current_snapshot="wp-20200610"
export instance_name="wp-instance-20200610"
export image_disk="wp-image-disk"
export bucket="custom-image-storage-20200610"
export tmp_disk_size=50GB # around 1.5 times original size


gcloud config set compute/zone us-west3-a # choose the instance zone
gcloud config set compute/region us-west3 # choose the instance region


## Create snapshot
gcloud compute disks snapshot ${existing_disk} \
--zone us-west3-a --snapshot-names ${current_snapshot}
con

gcloud compute disks create ${image_disk} --zone=us-west3-a --source-snapshot ${current_snapshot}

gcloud compute disks create temporary-disk --zone=us-west3-a --size ${tmp_disk_size}

gcloud compute instances create ${instance_name} \
    --scopes storage-rw \
    --disk name=${image_disk},device-name=${image_disk} \
    --disk name=temporary-disk,device-name=temporary-disk \
    --metadata startup-script='#! /bin/bash
sudo su -
apt update -y
apt upgrade -y
apt-get install screen -y
'