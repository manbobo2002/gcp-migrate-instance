current_snapshot="wp-20200610" ## Only need to change snapshot source name, disk-size and machine-type
instance_name="wp-instance-20200610"
image_disk="wp-image-disk"


gcloud compute instances delete ${instance_name} --zone=us-west3-a -q
gcloud compute disks delete temporary-disk --zone=us-west3-a -q
gcloud compute disks delete ${image_disk} --zone=us-west3-a -q
gcloud compute snapshots delete ${current_snapshot} -q
