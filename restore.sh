now=$(date '+%Y%m%d%H%M%S')
export image_name="myimage"
export instance_name="wp-instance-$now" # set your new instance name
export ISO_URL=gs://custom-image-storage-20200610/myimage.tar.gz
export size=10

gcloud compute images create ${image_name} --source-uri ${ISO_URL}

gcloud compute instances create ${instance_name} \
    --image=${image_name} \
    --machine-type=g1-small \
    --zone=us-west3-a \
    --tags=http-server,https-server \
    --metadata startup-script='#! /bin/bash
sudo su -
apt update -y
apt upgrade -y
'