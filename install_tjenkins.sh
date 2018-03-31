#!/bin/bash



gcloud beta compute \
--project=novaposhta-184015 instances create-with-container tjenkins \
--zone=europe-west1-b \
--machine-type=n1-standard-1 \
--subnet=default \
--maintenance-policy=MIGRATE \
--service-account=1045904521672-compute@developer.gserviceaccount.com \
--scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
--min-cpu-platform=Automatic \
--tags=jenkins-network \
--image=cos-stable-65-10323-64-0 \
--image-project=cos-cloud \
--boot-disk-size=10GB \
--boot-disk-type=pd-standard \
--boot-disk-device-name=tjenkins \
--container-image=gcr.io/novaposhta-184015/tjenkins-image:latest \
--container-restart-policy=always





gcloud compute \
--project=novaposhta-184015 firewall-rules create jenkins-acces-tcp-8080 \
--direction=INGRESS \
--priority=1000 \
--network=default \
--action=ALLOW \
--rules=tcp:8080 \
--target-tags=jenkins-network



ADRESS=$(gcloud compute instances describe tjenkins | grep natIP: | cut -c 12-40)

gcloud dns --project=novaposhta-184015 record-sets transaction start --zone=novaposhta

gcloud dns --project=novaposhta-184015 record-sets transaction add $ADRESS --name=tjenkins.novaposhta.io. --ttl=300 --type=A --zone=novaposhta

gcloud dns --project=novaposhta-184015 record-sets transaction execute --zone=novaposhta
