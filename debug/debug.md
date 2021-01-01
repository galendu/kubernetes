## kubernetes java程序开启debug调试端口
```Dockerfile
FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG JAR_FILE
ADD $JAR_FILE target/app.jar
ENTRYPOINT ["java","-agentlib:jdwp=transport=dt_socket,address=5005,server=y,suspend=n","-Djava.security.egd=file:/dev/./urandom","-Xms2g","-Xmx8g","-jar","target/app.jar"]
```
## deployment
```yml
---
        - name: "JAVA_ENABLE_DEBUG"
          value: "true"
   
---
        - containerPort: __containerport__
          name: __appname__
        - containerPort: __debugport__
          name: debug
---
     - name: debug
       port: __debugport__
       nodePort: __nodeport__
       targetPort: __debugport__
```
https://miro.medium.com/max/640/1*crqoNpyqxQegNP7MB9TbgA.png
