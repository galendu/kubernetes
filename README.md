# kubernetes
k8s学习-搭建-以及服务管理
## k8s安装
bash install k8s_install.sh
## 初始化k8s集群
```
kubeadm init --kubernetes-version=v1.15.3 --pod-network-cidr=10.244.0.0/16 --service-cidr=10.96.0.0/12  --image-repository registry.aliyuncs.com/google_containers
```
## 安装coredns flannel
```
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
#如果不能正常安装，请修改镜像地址，可以先下载下来
wget https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl apply -f  kube-flannel.yml
```
