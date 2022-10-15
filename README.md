# kubernetes
k8s学习-搭建-以及服务管理
## k8s安装
bash install ./k8s_install/k8s_install.sh
## 初始化k8s集群
```
kubeadm init --kubernetes-version=v1.25.2 --pod-network-cidr=10.244.0.0/16 --service-cidr=10.96.0.0/12  --image-repository registry.aliyuncs.com/google_containers --cri-socket unix:///run/cri-dockerd.sock
```
## 安装coredns flannel
```
#安装coredns
$ ./k8s_install/coredns/deploy.sh | kubectl apply -f -
$ kubectl delete --namespace=kube-system deployment kube-dns
kubectl apply -f https://ghproxy.com/https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
#如果不能正常安装，下载yaml文件并修改镜像地址，镜像地址可以使用googlecontainer/flannel-amd64:0.5.5
#wget https://ghproxy.com/https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
#kubectl apply -f  kube-flannel.yml
```
## 配置secret ,使用secret拉去私有镜像仓库镜像
```
kubectl create secret docker-registry myregistrykey --docker-server=DOCKER_REGISTRY_SERVER --docker-username=DOCKER_USER --docker-password=DOCKER_PASSWORD --docker-email=DOCKER_EMAIL -n namespace
```
#### 阿里云的配置方式
$ kubectl create secret docker-registry  web --docker-server=https://registry.cn-shenzhen.aliyuncs.com   --docker-username=yundv  --docker-password=password --docker-email=yundv@outlook.com -n qqb
## ingress-nginx安装
https://github.com/yundd/kubernetes/blob/master/k8s_install/ingress/ingress.md


## 配置k8s暴露端口的可用范围 
```bash
vim /etc/kubernetes/manifests/kube-apiserver.yaml
#找到 --service-cluster-ip-range 这一行，在这一行的下一行增加 如下内容

- --service-node-port-range=1-65535

systemctl daemon-reload
systemctl restart kubelet
kubectl create -f kube-service.yml 
#如出现执行报错,请使用docker ps -a |grep apiserver 查看apiserver服务

```
