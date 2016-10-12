# Minikube

Run Kubernetes locally - [Official Repo](https://github.com/kubernetes/minikube)

Below are the instructions to run on OSX using xhyve.

If you have VirtualBox or VMWare, these hypervisors may conflict with xhyve.
If you are unable to upgrade you OSX version, you may not have xhyve.
In those cases, follow the Official Repo instructions to run using VirtualBox

If none of the above applies to you, enjoy the power of OSX internal virtualization with xhyve!

## Minikube/xhyve - getting started (OSX)

```
curl -Lo ~/bin/minikube-0.11.0 https://storage.googleapis.com/minikube/releases/v0.11.0/minikube-darwin-amd64
```

```
$ brew install docker-machine-driver-xhyve

# docker-machine-driver-xhyve need root owner and uid
$ sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
$ sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
```

```
minikube start --disk-size=10g --vm-driver=xhyve
```

```
kubectl get no
kubectl run hello-minikube --image=gcr.io/google_containers/echoserver:1.4 --port=8080
kubectl expose deployment hello-minikube --type=NodePort
minikube service hello-minikube --url
```


create & use namespace
```
kubectl create namespace labs
export CONTEXT=$(kubectl config view | awk '/current-context/ {print $2}')
kubectl config set-context $CONTEXT --namespace=labs
kubectl config view | grep namespace:
```

Create secret
```
kubectl create secret docker-registry honestbee-registry --docker-server=registry.mine.com --docker-username=mine --docker-password="supersecret" --docker-email="not@real.lol"
```

Seems `minikube service` doesn't work with non-default namespace? Alternative:
```
kubectl get no -o json | jq -r '.items[].status.addresses[] | select(.type == "InternalIP") | .address'
kubectl get service flora -o json | jq .spec.ports[].nodePort
```



