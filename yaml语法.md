# yaml 语法
## 1.yaml基本语法规则
大小写敏感
使用缩进表示层级关系
缩进不允许使用tab键，只允许使用空格
缩进的空格数目不重要，只要相同层级的元素左侧对齐即可
#号表示注释，从这个字符一直到行尾，都会被解析器忽略

## 2.支持三种数据结构：
对象：键值对的集合，又称为映射（mapping）/哈希（hashes）/字典（dictionary）
数组：一组按次序排列的值，又称为序列/列表
纯量：单个的、不可再分的值


## 3.对象就是一组键值对，使用冒号结构表示
role: web
env: test
region：cn-beijing
zone: cn-beijing-f

##转为javascript如下：
{role: 'web', env: 'test', region: 'cn-beijing', zone: 'cn-beijing-f'}


## 4.以中线开头的行组成一个数组：
```
command:
- wget
- "-O"
- "/work-dir/index.html"
- http://kubernetes.io
```
## 5.转为javascript如下：
```
['wget','-O','/work-dir/index.html','http://kubernetes']
```

## 6.对象与数组组合使用：
```
containers:
- name: nginx
  image: nginx:latest
-name: php
  image: php:latest
```
## 7.转为javascript如下：
```
{
    containers:
    [
        {name:'nginx',image:'nginx:latest'},
        {name:'php',image:'php:latest'}
    ]
}
```
## 8.纯量是最基本的、不可再分的值：
```
字符串 -- ‘我是字符串’
布尔值 -- true 和 false
整数 -- 10
浮点数 -- 10.30
Null -- null
时间 -- 21：59：00
日期 -- 1989-09-21
```
## 9.多行字符串可以使用|保留换行，+表示保留数字块末尾的换行，
-表示删除字符串末尾的换行：
```
data:
  nginx-conf: |-
  server{
      listen 80;
      server_name hello.hipstershop.cn;
      location/{
          include uwsgi_params;
          uwsgi_pass unix:///tmp/uwsgi.sock;
      }
  }
```
## 10.多个配置写到一个文件，中间使用三个连字号---区分多个文件：
```
apiVersion:
---
apiVersion:
```
