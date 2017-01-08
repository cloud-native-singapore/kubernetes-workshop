#!/bin/bash

if [[ -z $1 ]]; then
  echo "count required"
  exit 0
fi

start=15
count=$1

export project_id=gcpugsg
export zone=asia-east1-a
export num_nodes=2

# use project defined above
gcloud config set project $project_id
gcloud config set compute/zone $zone
# generate configs with embedded client certs:
gcloud config set container/use_client_certificate True

create-cluster(){
  cluster_id=$1
  gcloud container clusters create $cluster_id --num-nodes $num_nodes --no-async
  mkdir -p $cluster_id
  KUBECONFIG=./$cluster_id/config gcloud container clusters get-credentials $cluster_id
}
export -f create-cluster

# brew install parallel
# parallel --citation - accept license
for ((i=$start; i<=$count; i++))
do
  cluster_id=c`printf %02d $i`
  echo $cluster_id
  sem -j 5 create-cluster $cluster_id
done

