# GKE Workshop - Trainer Notes

Preparing clusters for attendees will allow a better use of the time of every
attendee.

## Prerequisites

Have a working GCP account (upgraded payment method). 
Increase CPU Quota and `IN_USE_ADDRESSES` quota.

## Provisioning clusters

**NOTE**: keep a copy of your `~/.kube/config`:

```bash
cp -v ~/.kube/config ~/.kube/config-`date "+%Y%m%d%H"`
```

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

Installing private registry per cluster using Helm

```
helm init
helm version #make sure tiller is ready...
helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator
```

```
helm install -n distribution registry/
helm install -n distribution-proxy incubator/kube-registry-proxy --set registry.host=distribution-registry,registry.port=5000
```


##  Cleaning up

1. Deleting a clusters

   ```
   gcloud container clusters delete `printf "c%02d " {1..12}`
   ```

   ```
   rm -rf `printf "c%02d " {1..12}`
   ```
