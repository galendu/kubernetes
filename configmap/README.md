## 配置文件的热更新


>https://github.com/stakater/Reloader  

### 部署 
```bash
kubectl apply -f https://raw.githubusercontent.com/jafardu/kubernetes/master/configmap/reload.yaml
#kubectl apply -f reload.yaml
```
### confimap secret的热更新
```yaml
#在需要热更新的deployment等控制器metadata.annotations字段后添加 reloader.stakater.com/auto: "true"
kind: Deployment
metadata:
  annotations:
    reloader.stakater.com/auto: "true"
spec:
  template: metadata:
```
### confimap的热更新

```
#在需要热更新的deployment等控制器metadata.annotations字段后添加 configmap.reloader.stakater.com/reload: "foo-configmap"
kind: Deployment
metadata:
  annotations:
    configmap.reloader.stakater.com/reload: "foo-configmap" #foo-configmap为该控制器使用到的confimap名称
spec:
  template: metadata:
```

