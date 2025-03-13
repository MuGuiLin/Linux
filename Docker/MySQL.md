# MySQL Image镜像

> Docker library [mysql - Official Image | Docker Hub](https://hub.docker.com/_/mysql)



**0、搜索MySQL镜像：**

```shell
docker search mysql

NAME                   DESCRIPTION                                      STARS     OFFICIAL
mysql                  MySQL is a widely used, open-source relation…   15398     [OK]
mysql/mysql-server     Optimized MySQL Server Docker images. Create…   1019
mysql/mysql-router     MySQL Router provides transparent routing be…   28
mysql/mysql-cluster    Experimental MySQL Cluster Docker images. Cr…   100
bitnami/mysql          Bitnami container image for MySQL                118
circleci/mysql         MySQL is a widely used, open-source relation…   30
mysql/mysql-operator   MySQL Operator for Kubernetes                    1
cimg/mysql                                                              3
linuxserver/mysql      A Mysql container, brought to you by LinuxSe…   40
ubuntu/mysql           MySQL open source fast, stable, multi-thread…   64
bitnamicharts/mysql                                                     0
rapidfort/mysql        RapidFort optimized, hardened image for MySQL    25
docksal/mysql          MySQL service images for Docksal - https://d…   0
elestio/mysql          Mysql, verified and packaged by Elestio          0
google/mysql           MySQL server for Google Compute Engine           25
alpine/mysql           mysql client                                     2
jelastic/mysql         An image of the MySQL database server mainta…   3
mysql/ndb-operator     MySQL NDB Operator for Kubernetes                0
eclipse/mysql          Mysql 5.7, curl, rsync                           1
centurylink/mysql      Image containing mysql. Optimized to be link…   59
tutum/mysql            Base docker image to run a MySQL database se…   35
kubesail/mysql         A memory-size and disk-space efficient minim…   0
devilbox/mysql         Retagged MySQL, MariaDB and PerconaDB offici…   3
biarms/mysql           One more MySQL ARM build                         58
datajoint/mysql        MySQL image pre-configured to work smoothly …   2
```



**1、拉取最新版MySQL镜像：**

```shell
docker pull mysql

# 或指定版本（不指定则拉取最新版本）
docker pull mysql:8.0
```



**2、查看所有镜像：**

```shell
docker images

# 或
docker image ls
```



**3、启动MySQL：**

```shell
docker run -p 3306:3306 --name myslq8 --privileged=true -e MYSQL_ROOT_PASSWORD=123456 -d mysql:latest --character-set-connection=utf8 --character-set-client=utf8 -v D:/Docker/mysql/log:/var/log/mysql -v D:/Docker/mysql/data:/var/lib/mysql -v D:/Docker/mysql/conf:/etc/mysql

# 参数说明：
# -p 3308:3306 表示将容器中的3306端口 挂载到 宿主机的3308端口
# --name mysql 表示指定容器的名称
# -d mysql:latest 表示指Deckor将要启动的镜像
# --restart=always 表示设置当Deckor启动时也随着启动该程序
# --privileged=true 表示设置获取宿主机的最大root权限
# -v /容器目录:/宿主机目录 表示将容器中指定的目录 与 宿主机中指定的目录做映射绑定（这样做的好处在于，比如：在需要修改mysql的配置时，就只需要在宿主机指定的目录中修改，不用去容器目录中了）
# -v D:/Docker/mysql/conf:/etc/mysql/ 

# 在执行命令后显示ID号表示启动成功！
016dd2735ac451ffefba78ffa1d593395ccdbc5211078b511f4bb622f034aa39

# 可以通过命令来查看所有的容器
docker ps -a

# 也可以通过命令来查看正在运行中的容器
docker ps

CONTAINER ID   IMAGE          COMMAND                   CREATED          STATUS          PORTS                        NAMES
016dd2735ac4   mysql:latest   "docker-entrypoint.s…"   29 minutes ago   Up 29 minutes   33060/tcp, 0.0.0.0:62790->3306/tcp myslq
```

**3、进入MySQL容器实例：**

```shell
# 根据docker ps 查看到mysql的CONTAINER ID打开MySQL容器实例
docker exec -it 016dd2735ac4 bash

# 在容器实例登录MySQL
bash-5.1# mysql -u root -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 19
Server version: 9.0.1 MySQL Community Server - GPL

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.


# 查看所有数据库
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.00 sec)


# 创建一个新数据库
mysql> create database mupiao;
Query OK, 1 row affected (0.01 sec)


# 查看所有数据库
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mupiao             |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)
```





