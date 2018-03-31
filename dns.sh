
#!/bin/bash

#gcloud dns record-sets transaction start -z=novaposhta
#for SERVICE_NAME in ${SERVICES[@]};
#do
#  TYPE=$(gcloud dns record-sets list -z=novaposhta | grep ${DNS_PREFIX}${SERVICE_NAME} | awk '{print $2}')
#  TTL=$(gcloud dns record-sets list -z=novaposhta | grep ${DNS_PREFIX}${SERVICE_NAME} | awk '{print $3}')
#  OLD_IP=$(gcloud dns record-sets list -z=novaposhta | grep ${DNS_PREFIX}${SERVICE_NAME} | awk '{print $4}')
#  if [ $OLD_IP ] 
#    then
#    gcloud dns record-sets transaction remove -z=novaposhta --name="${DNS_PREFIX}${SERVICE_NAME}.novaposhta.io." --type=$TYPE --ttl=$TTL $OLD_IP
#  fi
#  gcloud dns record-sets transaction add -z=novaposhta  --name="${DNS_PREFIX}${SERVICE_NAME}.novaposhta.io." --type=A --ttl=60 $IP
#done
#gcloud dns record-sets transaction execute -z=novaposhta







ADRESS=$(gcloud compute instances describe tjenkins | grep natIP: | cut -c 12-40)

gcloud dns --project=novaposhta-184015 record-sets transaction start --zone=novaposhta

gcloud dns --project=novaposhta-184015 record-sets transaction add $ADRESS --name=tjenkins.novaposhta.io. --ttl=300 --type=A --zone=novaposhta

gcloud dns --project=novaposhta-184015 record-sets transaction execute --zone=novaposhta

