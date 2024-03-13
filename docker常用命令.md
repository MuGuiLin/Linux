# Docker常用命令



1，获取Centos镜像

 >docker pull centos:latest



2，查看镜像运行情况

 >docker images centos



3，在容器下运行 shell bash

 >docker run -i -t centos /bin/bash



4，停止容器

 >docker stop <CONTAINER ID>



5，查看容器日志

 >docker logs -f <CONTAINER ID>



6，删除所有容器

 >docker rm $(docker ps -a -q)



7，删除镜像

 >docker rmi <image id/name>



8，提交容器更改到镜像仓库中

 >docker run -i -t centos /bin/bash
 >useradd myuser
 >exit
 >docker ps -a |more
 >docker commit <CONTAINER ID> myuser/centos



9，创建并运行容器中的 hello.sh

 >docker run -i -t myuser/centos /bin/bash
 >touch /home/myuser/hello.sh
 >echo "echo \"Hello,World!\"" > /home/myuser/hello.sh
 >chmod +x /home/myuser/hello.sh
 >exit
 >docker commit <CONTAINER ID> myuser/centos
 >docker run -i -t myuser/centos /bin/sh /home/myuser/hello.sh



10，在容器中运行Nginx

在容器中安装好Nginx，并提交到镜像中**（在浏览器访问宿主机80端口）**
 >docker run -t -i -p 80:80 nginx/centos /bin/bash
 启动Nginx
 >/data/apps/nginx/sbin/nginx
 (还不清楚如何在后台运行!!!)



11，映射容器端口
 >docker run -d -p 192.168.9.11:2201:22 nginx/centos /usr/sbin/sshd -D

用ssh root@192.168.9.11 -p 2201 连接容器，

docker run -i -d -t -P -p 8080:80 -p 49180:22 centos:base /bin/bash



