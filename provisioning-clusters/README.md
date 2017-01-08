# GKE Workshop - Trainer Notes

Preparing clusters for attendees will allow a better use of the time of every
attendee.

## Prerequisites

Have a working GCP account (upgraded payment method). 
Increase CPU Quota and `IN_USE_ADDRESSES` quota.

## Provisioning clusters

1. Create cluster (repeat for every cluster, takes 4-5 min per cluster)

   ```
   gcloud container clusters create c01 --num-nodes 2
   ```

1. Export credentials

   Instead of using OAuth, get client credentials:
   ```
   gcloud config set container/use_client_certificate True
   ```
   
   Note: all cluster certs also available through
   `gcloud container clusters describe c01`

   Create config file for cluster:
   ```
   KUBECONFIG=./ws01/config gcloud container clusters get-credentials c01
   ```

##  Cleaning up

1. Deleting a cluster

   ```
   gcloud container clusters delete c01 c02 ..
   ```
