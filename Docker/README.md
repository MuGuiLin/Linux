# Docker 常用命令

> 软件开发最大的麻烦事之一，就是环境配置。用户计算机的环境都不相同，你怎么知道自家的软件，能在那些机器跑起来？
>
> 用户必须保证两件事：操作系统的设置，各种库和组件的安装。只有它们都正确，软件才能运行。举例来说，安装一个 Python 应用，计算机必须有 Python 引擎，还必须有各种依赖，可能还要配置环境变量。
>
> 如果某些老旧的模块与当前环境不兼容，那就麻烦了。开发者常常会说："它在我的机器可以跑了"（It works on my machine），言下之意就是，其他机器很可能跑不了。
>
> 环境配置如此麻烦，换一台机器，就要重来一次，旷日费时。很多人想到，能不能从根本上解决问题，软件可以带环境安装？也就是说，安装的时候，把原始环境一模一样地复制过来。



## 由来

**1、关于虚拟机：**

虚拟机（virtual machine）就是带环境安装的一种解决方案。它可以在一种操作系统里面运行另一种操作系统，比如在 Windows 系统里面运行 Linux 系统。应用程序对此毫无感知，因为虚拟机看上去跟真实系统一模一样，而对于底层系统来说，虚拟机就是一个普通文件，不需要了就删掉，对其他部分毫无影响。

如VM等，由于每个虚拟机都是一个完整的操作系统，要分配和占用掉原有系统资源，所以当虚拟机多到一定程度时，操作系统本身资源也就会消耗殆尽（当然也可以进行扩容）的。

**缺点：资源占用多、冗余步骤多、启动慢**



**2、关于Linux 容器**：

由于虚拟机存在这些缺点，Linux 发展出了另一种虚拟化技术：Linux 容器（Linux Containers，缩写为 LXC）。

**Linux 容器不是模拟一个完整的操作系统，而是对进程进行隔离。**或者说，在正常进程的外面套了一个[保护层](https://opensource.com/article/18/1/history-low-level-container-runtimes)。对于容器里面的进程来说，它接触到的各种资源都是虚拟的，从而实现与底层系统的隔离， 这种容器有点像轻量级的虚拟机，能够提供虚拟化的环境，但是成本开销小得多。。

**优势：资源占用少、体积小、启动快**



**3、关于Docker 容器**

**Docker 属于 Linux 容器的一种封装，提供简单易用的容器使用接口。它是目前最流行的 Linux 容器解决方案！**

Docker 将应用程序与该程序的依赖，打包在一个文件里面。运行这个文件，就会生成一个虚拟容器。程序在这个虚拟容器里运行，就好像在真实的物理机上运行一样。有了 Docker，就不用担心环境问题。

总体来说，Docker 的接口相当简单，用户可以方便地创建和使用容器，把自己的应用放入容器。容器还可以进行版本管理、复制、分享、修改，就像管理普通的代码一样。



## 关于Docker

Docker 是一个开源的应用容器引擎，基于 [Go 语言](https://www.runoob.com/go/go-tutorial.html) 开发，并遵从 Apache2.0 协议开源，在GitHub上维护，它基于Linux内核的Cgroups、NameSpace，以及Union FS等技术，

**主要用作：**对进程进行封装隔离，属于操作系统层面的虚拟化技术【这就是它取胜传统的VMware、VirtualBox等虚拟机(要安装操用系统，占用大量的宿主机性能)的优势，Docker容器技术是轻量级的(直接运行在宿主机内核上的，不占用太多的宿主机性能)】

【简单来讲：在容器中的程序，就好比是直接在宿主机上运行的，但他们之间又是相互**隔离的、独立的**】。

Docker 的主要用途，目前有三大类。

**（1）提供一次性的环境。**比如，本地测试他人的软件、持续集成的时候提供单元测试和构建的环境。

**（2）提供弹性的云服务。**因为 Docker 容器可以随开随关，很适合动态扩容和缩容。

**（3）组建微服务架构。**通过多个容器，一台机器可以跑多个服务，因此在本机就可以模拟出微服务架构。



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



## image 镜像文件

**Docker 把应用程序及其依赖，打包在 image 文件里面。**只有通过这个文件，才能生成 Docker 容器。image 文件可以看作是容器的模板。Docker 根据 image 文件生成容器的实例。同一个 image 文件，可以生成多个同时运行的容器实例。

image 是二进制文件。实际开发中，一个 image 文件往往通过继承另一个 image 文件，加上一些个性化设置而生成。举例来说，你可以在 Ubuntu 的 image 基础上，往里面加入 Apache 服务器，形成你的 image。

> ```bash
> # 列出本机的所有 image 文件。
> $ docker image ls
> 
> # 删除 image 文件
> $ docker image rm [imageName]
> ```

image 文件是通用的，一台机器的 image 文件拷贝到另一台机器，照样可以使用。一般来说，为了节省时间，我们应该尽量使用别人制作好的 image 文件，而不是自己制作。即使要定制，也应该基于别人的 image 文件进行加工，而不是从零开始制作。

为了方便共享，image 文件制作完成后，可以上传到网上的仓库。Docker 的官方仓库 [Docker Hub](https://hub.docker.com/) 是最重要、最常用的 image 仓库。此外，出售自己制作的 image 文件也是可以的。



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



