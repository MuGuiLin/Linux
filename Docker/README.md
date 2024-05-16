# Docker 常用命令

> Docker 是一个开源的应用容器引擎，基于 [Go 语言](https://www.runoob.com/go/go-tutorial.html) 开发，并遵从 Apache2.0 协议开源。
>
> Docker 可以让开发者打包他们的应用以及依赖包到一个轻量级、可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以实现虚拟化。
>
> Docker 容器是完全使用沙箱机制，相互之间不会有任何接口（类似 iPhone 的 app）,更重要的是容器性能开销极低。

## 相关链接

Docker 官网：[https://www.docker.com](https://www.docker.com/)

Github Docker 源码：https://github.com/docker/docker-ce

![Docker-build.png (900×667)](https://www.docker.com/wp-content/uploads/2021/09/Docker-build.png)

> 加快构建、共享和运行现代应用程序的方式。
>
> Docker 使开发高效且可预测：
>
> ​	Docker 消除了重复、平凡的配置任务，并在整个开发生命周期中用于快速、简单和可移植的应用程序开发 - 桌面和云。Docker 全面的端到端平台包括 UI、CLI、API 和安全性，它们旨在在整个应用程序交付生命周期中协同工作。



## Docker的应用场景

- Web 应用的自动化打包和发布。
- 自动化测试和持续集成、发布。
- 在服务型环境中部署和调整数据库或其他的后台应用。
- 从头编译或者扩展现有的 OpenShift 或 Cloud Foundry 平台来搭建自己的 PaaS 环境。



关于虚拟机：

如VM等，由于每个虚拟机都是一个完整的操作系统，要分配和占用掉原有系统资源，所以当虚拟机多到一定程度时，操作系统本身资源也就会消耗殆尽（当然也可以进行扩容）的。



# Docker常用命令

### [Docker: 加速容器应用程序开发(Accelerated Container Application Development) ](https://www.docker.com/)



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
 > 启动Nginx
 >/data/apps/nginx/sbin/nginx
 > (还不清楚如何在后台运行!!!)



11，映射容器端口

 >docker run -d -p 192.168.9.11:2201:22 nginx/centos /usr/sbin/sshd -D

用ssh root@192.168.9.11 -p 2201 连接容器，

docker run -i -d -t -P -p 8080:80 -p 49180:22 centos:base /bin/bash



