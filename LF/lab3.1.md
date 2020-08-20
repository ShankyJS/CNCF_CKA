## LAB3

```
apt-get update && apt-get upgrade -y
apt-get install -y vim
apt-get install -y docker.io
systemctl enable docker.service
```

installing 
```
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubeadm=1.18.1-00 kubelet=1.18.1-00 kubectl=1.18.1-00
sudo apt-mark hold kubelet kubeadm kubectl
```
add primary IP host to /etc/hosts
```
vim /etc/hosts
```
138.68.18.150 k8smaster
```
```
init cluster
```
sudo kubeadm init --pod-network-cidr=10.80.0.0/16

```
calico
https://docs.projectcalico.org/getting-started/kubernetes/quickstart
```
kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
```
modify network to match --pod-network-cidr
```
wget https://docs.projectcalico.org/manifests/custom-resources.yaml
kubectl apply -f custom-resources.yaml
```
kubeadm join 138.68.18.150:6443 --token ufd3uf.zg09t91cqvdwfk26 \
    --discovery-token-ca-cert-hash sha256:1d4477ab69d9050820462b5737a285a9797264394a09f292e6c356f488bf36f2 

use cluster
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

```

disable taint to master //SINGLE NODE
```
kubectl taint nodes --all node-role.kubernetes.io/master-

```