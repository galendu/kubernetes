## 安装
#### 修改了镜像地址，以及网络模式，选用 hostNetwork: true 网络模式（使用宿主机网络）
1.kubectl apply -f ingress-nginx.yaml

#### 2.使用官方提供的方式安装使用方式（如果国内没使用代理，官方提供的镜像地址拉去镜像会失败）
```
https://github.com/kubernetes/ingress-nginx/blob/master/docs/deploy/index.md
```
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml
```
