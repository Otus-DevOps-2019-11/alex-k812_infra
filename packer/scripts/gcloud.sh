#!/bin/sh
gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family=ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --metadata startup-script-url=gs://akotus-stuff/startup_script.sh
gcloud compute firewall-rules create default-puma-server --allow tcp:9292 --direction INGRESS --source-ranges="0.0.0.0/0" --target-tags puma-server
