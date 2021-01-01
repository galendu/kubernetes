## apm install 

```bash
# 安装apm-server
curl -L -O https://artifacts.elastic.co/downloads/apm-server/apm-server-7.10.1-x86_64.rpm
sudo rpm -vi apm-server-7.10.1-x86_64.rpm
#配置es密码
output.elasticsearch:
    hosts: ["<es_url>"]
    username: <username>
    password: <password>
#创建keystore
apm-server keystore add ES_PWD
# k8s中使用keystore
kubectl create secret generic apm-server-apm-token --from-literal=secret-token='ES_PWD'  -n jjqgc --dry-run=client   -o yaml >secret.yml
kubectl apply -f secret.yml
```
## apm-server & debug
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: __appname__ #替换__appname__名称以及__appname__-namespace
  name: __appname__
  namespace: __namespace__

spec:
  replicas: 1
  selector:
    matchLabels:
      app: __appname__
  strategy: 
    rollingUpdate:
      maxSurge: 25%      #滚动升级时会先启动1个pod
      maxUnavailable: 25% #滚动升级时允许的最大Unavailable的pod个数
  template:
    metadata:
      namespace: __namespace__
      labels:
        app: __appname__
    spec:
      dnsPolicy: ClusterFirstWithHostNet 
      volumes:
        - name: elastic-apm-agent
      initContainers: 
      - name: elastic-java-agent 
        image: docker.elastic.co/observability/apm-agent-java:1.12.0 
        volumeMounts: 
        - mountPath: /elastic/apm/agent 
          name: elastic-apm-agent 
        command: ['cp', '-v', '/usr/agent/elastic-apm-agent.jar', '/elastic/apm/agent']

      containers:
        
      - image: __imagename__/__appname__
        volumeMounts: 
        - mountPath: /elastic/apm/agent 
          name: elastic-apm-agent
        
        # command: ["echo 'namesever 8.8.8.8' >> '/etc/resolv.conf'"]
        
        env: 
        - name: "JAVA_ENABLE_DEBUG"
          value: "true"
        - name: ELASTIC_APM_SERVER_URL 
          value: "http://192.168.0.42:8200" 
        - name: ELASTIC_APM_SERVICE_NAME 
          value: "__appname__" 
        - name: ELASTIC_APM_APPLICATION_PACKAGES 
          value: "org.springframework.samples.petclinic" 
        - name: ELASTIC_APM_ENVIRONMENT 
          value: test 
        - name: ELASTIC_APM_LOG_LEVEL 
          value: DEBUG 
        - name: ELASTIC_APM_SECRET_TOKEN 
          valueFrom: 
            secretKeyRef: 
              name: apm-server-apm-token 
              key: secret-token 
        - name: JAVA_TOOL_OPTIONS 
          value: -javaagent:/elastic/apm/agent/elastic-apm-agent.jar

        readinessProbe: #kubernetes认为该pod是启动成功的
          tcpSocket:
            port: __containerport__
          initialDelaySeconds: 60 ## equals to minimum startup time of the application\
          periodSeconds: 5
          timeoutSeconds: 5
          successThreshold: 1
          failureThreshold: 5
        livenessProbe: 
          tcpSocket:
            port: __containerport__
          initialDelaySeconds: 60 ## equals to minimum startup time of the application
          periodSeconds: 3
          timeoutSeconds: 5
          successThreshold: 1
          failureThreshold: 5
        resources:
          requests:
            memory: "500Mi"
            cpu: "200m"
          limits:
            memory: "4Gi"
            cpu: "500m"
        name: __appname__
        imagePullPolicy: Always
        ports:
        - containerPort: __containerport__
          name: __appname__
        - containerPort: __debugport__
          name: debug


---
apiVersion: v1
kind: Service
metadata:
   labels:
     app: __appname__
   name: __appname__-svc
   namespace: __namespace__
spec:
   
   ports:
     - name: __appname__
       port: __containerport__
       targetPort: __containerport__
    
     - name: debug
       port: __debugport__
       nodePort: __nodeport__
       targetPort: __debugport__
       
   selector:
     app: __appname__

```
