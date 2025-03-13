# Chat2DB数据库管理工具

> Docker Hub： [chat2db/chat2db - Docker Image](https://hub.docker.com/r/chat2db/chat2db)



**0、搜索Chat2DB镜像：**

```shell
docker search chat2db
NAME                               DESCRIPTION   STARS     OFFICIAL
chat2db/chat2db                    chat2db       8
jackkke/chat2db                                  0
kejoe/chat2db                                    0
coderlinzg/chat2db                               0
dujunio/chat2db                                  0
anjia0532/docker.chat2db.chat2db                 0
shaw001/chat2db-ui                               0
```



**1、拉取最新版MySQL镜像：**

```shell
docker pull chat2db/chat2db

# 或指定版本（不指定则拉取latest最新版本）
docker pull chat2db/chat2db:latest
```



**2、查看所有镜像：**

```shell
docker images

# 或
docker image ls
```



**3、启动Chat2DB：**

```shell
docker run -p 10824:10824 --name=chat2db -v D:/Docker/chat2db:/root/chat2db -d chat2db/chat2db:latest 

# 在执行命令后显示ID号表示启动成功！
e979d3fa00420b729e561484603d365ba6e89b472412ceb9d816de7ebd40f347

# 启动在浏览器中打开如下网址就可以访问Chat2DB数据库管理工具了，注：第一次访问需要登录，默认账户和密码都是chat2db
http://localhost:10824/


# 可以通过命令来查看所有的容器
docker ps -a

# 也可以通过命令来查看正在运行中的容器
docker ps

CONTAINER ID   IMAGE                    COMMAND                   CREATED          STATUS          PORTS               NAMES
e979d3fa0042   chat2db/chat2db:latest   "java -Dloader.path=…"   20 minutes ago   Up 20 minutes   0.0.0.0:10824->10824/tcp   chat2db
```

**3、进入MySQL容器实例：**

```shell
# 使用docker ps 命令，就能查看容器列表，复制chat2db容器对应的 CONTAINER ID 就能打开chat2db容器实例
docker exec -it e979d3fa0042 bash
```





