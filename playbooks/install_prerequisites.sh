apt-get update && apt-get upgrade -y
apt-get install -y vim
apt-get install -y docker.io
systemctl enable docker.service

# sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubeadm=1.18.1-00 kubelet=1.18.1-00 kubectl=1.18.1-00
sudo apt-mark hold kubelet kubeadm kubectl