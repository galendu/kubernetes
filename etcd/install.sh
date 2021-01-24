## 练习笔记
```bash
ETCD_VER=v3.4.14

# choose either URL
GOOGLE_URL=https://storage.googleapis.com/etcd
GITHUB_URL=https://github.com/etcd-io/etcd/releases/download
DOWNLOAD_URL=${GOOGLE_URL}

rm -f /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz
rm -rf /tmp/etcd-download-test && mkdir -p /tmp/etcd-download-test

curl -L ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz -o /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz
tar xzvf /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz -C /tmp/etcd-download-test --strip-components=1
rm -f /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz

/tmp/etcd-download-test/etcd --version
/tmp/etcd-download-test/etcdctl version

# start a local etcd server
/tmp/etcd-download-test/etcd

# write,read to etcd
/tmp/etcd-download-test/etcdctl --endpoints=localhost:2379 put foo bar
/tmp/etcd-download-test/etcdctl --endpoints=localhost:2379 get foo




./etcd --listen-client-urls=http://$PRIVATE_IP:2379 --advertise-client-urls=http://$PRIVATE_IP:2379

./etcd --listen-client-urls=http://$IP1:2379, http://$IP2:2379, http://$IP3:2379, http://$IP4:2379, http://$IP5:2379 --advertise-client-urls=http://$IP1:2379, http://$IP2:2379, http://$IP3:2379, http://$IP4:2379, http://$IP5:2379



etcd --data-dir=./data-1 --name etcd-1 --initial-advertise-peer-urls http://192.168.3.3:2380 \
  --listen-peer-urls http://192.168.3.3:2380 \
  --listen-client-urls http://192.168.3.3:2379,http://127.0.0.1:2379 \
  --advertise-client-urls http://192.168.3.3:2379 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-cluster etcd-1=http://192.168.3.3:2380,etcd-2=http://192.168.3.4:2380,etcd-3=http://192.168.3.3:2381 \
  --initial-cluster-state new
  --client-cert-auth --trusted-ca-file=./ca-client.crt \
  --cert-file=./infra0-client.crt --key-file=./infra0-client.key \
  --peer-client-cert-auth --peer-trusted-ca-file=ca-peer.crt \
  --peer-cert-file=./infra0-peer.crt --peer-key-file=./infra0-peer.key


etcd --data-dir=./data-1 --name etcd-2 --initial-advertise-peer-urls http://192.168.3.4:2380 \
  --listen-peer-urls http://192.168.3.4:2380 \
  --listen-client-urls http://192.168.3.4:2379,http://127.0.0.1:2379 \
  --advertise-client-urls http://192.168.3.4:2379 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-cluster etcd-1=http://192.168.3.3:2380,etcd-2=http://192.168.3.4:2380,etcd-3=http://192.168.3.3:2381 \
  --initial-cluster-state new
  


etcd --data-dir=./data-2 --name etcd-3 --initial-advertise-peer-urls http://192.168.3.3:2381 \
  --listen-peer-urls http://192.168.3.3:2381 \
  --listen-client-urls http://192.168.3.1:2378,http://127.0.0.1:2378 \
  --advertise-client-urls http://192.168.3.3:2378 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-cluster etcd-1=http://192.168.3.3:2380,etcd-2=http://192.168.3.4:2380,etcd-3=http://192.168.3.3:2381 \
  --initial-cluster-state new  
  
```
