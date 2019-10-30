## 创建方式
#### 1.方式一
```
echo -n 'admin' > ./username.txt
echo -n '1f2d1e2e67df' > ./password.txt
kubectl create secret generic db-user-pass --from-file=./username.txt --from-file=./password.txt
```
#### 方式二
```
echo -n 'admin' | base64
YWRtaW4=
echo -n '1f2d1e2e67df' | base64
MWYyZDFlMmU2N2Rm
创建yaml文件
cat <<EOF >./secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysecret
type: Opaque
data:
  username: YWRtaW4=
  password: MWYyZDFlMmU2N2Rm
EOF

kubectl apply -f ./secret.yaml
```
#### 方式三
```


cat <<EOF >./kustomization.yaml
secretGenerator:
- name: db-user-pass
  files:
  - username.txt
  - password.txt
EOF

kubectl apply -k .
```
