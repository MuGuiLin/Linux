# Docker 常用命令

Docker 是一个开源的应用容器引擎，基于 [Go 语言](https://www.runoob.com/go/go-tutorial.html) 开发，并遵从 Apache2.0 协议开源，在GitHub上维护，它基于Linux内核的Cgroups、NameSpace，以及Union FS等技术，

**主要用作：**对进程进行封装隔离，属于操作系统层面的虚拟化技术【这就是它取胜传统的VMware、VirtualBox等虚拟机(要安装操用系统，占用大量的宿主机性能)的优势，Docker容器技术是轻量级的(直接运行在宿主机内核上的，不占用太多的宿主机性能)】

【简单来讲：在容器中的程序，就好比是直接在宿主机上运行的，但他们之间又是相互**隔离的、独立的**】。

**为么什叫容器：**由于隔离的进程独立于宿主机(真实的硬件服务器、个人电脑) 和 其他隔离的进程，Docker被定义为开源的容器引擎，可以方便的对容器进行（创建、删除、切换）等管理，例如：对**镜像**打包封装，引入Docker Registry对镜像统一管理，特性在程序开发人员，Dockder可以实现的在开发环境、测试环境、生产环境的部署一致性，从面极大的减少运维成本。

![容器技术](D:\Linux\Docker\容器技术.png)

## 相关链接

Docker 官网：[https://www.docker.com](https://www.docker.com/)

Github Docker 源码：https://github.com/docker/docker-ce

![Docker-build.png (900×667)](https://www.docker.com/wp-content/uploads/2021/09/Docker-build.png)

> Docker 可以让开发者打包他们的应用以及依赖包到一个轻量级、可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以实现虚拟化。
>
> Docker 容器是完全使用沙箱机制，可加快构建、共享和运行现代应用程序的方式，相互之间不会有任何接口（类似 iPhone 的 app）,更重要的是容器性能开销极低。
>
> Docker 使开发高效且可预测，Docker 消除了重复、平凡的配置任务，并在整个开发生命周期中用于快速、简单和可移植的应用程序开发 - 桌面和云。Docker 全面的端到端平台包括 UI、CLI、API 和安全性，它们旨在在整个应用程序交付生命周期中协同工作。
>



## Docker的应用场景

- Web 应用的自动化打包和发布。
- 自动化测试和持续集成、发布。
- 在服务型环境中部署和调整数据库或其他的后台应用。
- 从头编译或者扩展现有的 OpenShift 或 Cloud Foundry 平台来搭建自己的 PaaS 环境。



**K8S容器编排管理工具：**

由于所有的应用程序都跑在Docker中运行，不同的应用程序可能用不同的容器，所以当容器的数据越来越多的时候，就需要进行有效的管理，而K8S就是专门做容器管理的工具。



**关于虚拟机：**

如VM等，由于每个虚拟机都是一个完整的操作系统，要分配和占用掉原有系统资源，所以当虚拟机多到一定程度时，操作系统本身资源也就会消耗殆尽（当然也可以进行扩容）的。



**关于网络端口(Port)号：**

一般在一台电脑上，在逻辑意义上的端口。指的是TCP/IP协议中的端口，端口号的范围从0到65535个网络端口。

- 53端口：NDS域名系统，用于将域名解析为IP地址的标准端口。

- 80端口：默认(HTTP服务)，用于传输Web页面的标准端口。
- 443端口：HTTPS(安全HTTP协议)，用于通过加密连接传输Web数据的标准端口。
- 21端口：FTP(文件传输协议)，用于文件传输的标准端口。
- 22端口：SSH(安全外壳协议)，用于安全的远程终端连接。
- 25端口：SMTP(邮件传输协议)，用于发送电子邮件的标准端口。
- 3389端口：RDP(运程桌面协议)，用于远程桌面连接到Windows计算机的标准端口。
- 3306端口：MySQL数据库，MySQL数据库服务器的默认端口。
- 6379端口：Redis缓存，Redis缓存服务器的默认端口。
- 27017端口：MongoDB数据库，MongoDB数据库服务器的默认端口。



# Docker常用命令

### [Docker: 加速容器应用程序开发(Accelerated Container Application Development) ](https://www.docker.com/)



## Docker相关

![Docker引擎](D:\Linux\Docker\Docker引擎.png)

### Docker Daemon进程

在安装使用Docker，得先运行Docker Daemon进程，用于管理Docker

- 镜像 images 
- 容器 containers
- 网络 network
- 存储 Data Volumes(数据卷)



### Rest接口

用于提供 和 Daemon进程 交互的API接口



### Docker Client客户端

使用客户端 通过REST API接口 和 Docker Daemon进程 进行访问、操作。



### Docker平台组成

![Docker平台组成](D:\Linux\Docker\Docker平台组成.png)

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



