# Python项目部署



## 📢部署Python项目启动后内网能访问外网不能访问？

#### 问题描述

腾讯服务器，用宝塔面板部署了Python 的Flast项目，3000端口（宝塔面板 和 腾讯服务器的都放开了 TCP 3000端口）。

项目启动后, 在命令窗口中测试如下：

内网 curl 127.0.0.1:3000 是OK！

外网 curl 126.223.158.95:3000 报 curl: (7) Failed to connect to 126.223.158.95 port 3000 after 0 ms: Couldn't connect to server.



### **检查 Flask 绑定的 IP 地址（最常见原因）**

默认情况下，Flask (`app.run()`) 启动时只监听 `127.0.0.1` (localhost)。这意味着它**只接受**来自服务器内部的请求，拒绝所有外部 IP 的请求，即使防火墙端口放行了也没用。

- **现象**：内网 curl OK，外网 curl 失败。

- **解决方法**：
  你需要修改 Flask 的启动代码或启动命令，将 host 设置为 `0.0.0.0`。

  - **如果是 Python 代码启动**：

    ```shell
    # 修改前
    app.run(port=3000)
    
    # 修改后 (关键：host='0.0.0.0')
    app.run(host='0.0.0.0', port=3000)
    ```

  - **如果是命令行直接启动**：

    ```shell
    # 修改前
    python app.py
    
    # 修改后
    python app.py --host=0.0.0.0 --port=3000
    ```

    *(注：具体参数取决于你使用的启动方式，如果是 gunicorn/uwsgi 等，配置同理，需绑定 0.0.0.0)*

  - **如果是宝塔面板管理的 Python 项目**：
    进入宝塔面板 -> Python项目管理 -> 找到你的项目 -> 点击“设置”或“启动配置”，确保启动参数中包含 `--host 0.0.0.0`，或者在代码中已写死。



## ✅ 验证步骤

修改并重启项目后，在服务器命令终端执行以下命令确认状态：

1. **检查监听地址**：

   ```shell
   netstat -tlnp | grep 3000
   # 或者
   ss -tlnp | grep 3000
   
   # 显示如下 就表示即便不是127.0.0.1的外网也可以访问了（暴露0.0.0.0:3000意味着互联网上的任何人的IP都能尝试连接你的3000端口）：
   tcp        0      0 0.0.0.0:3000        0.0.0.0:*        LISTEN    2339400/python3 
   ```

   **成功标志**：看到 `0.0.0.0:3000` 或 `:::3000`，而不是 `127.0.0.1:3000`。

2. **检查所有监听地址**：

   ```shell
   netstat -tlnp
   # 或者
   ss -tlnp
   
   # 显示如下
   
   (3.12.12) [root@VM-0-7-opencloudos ~]# netstat -tlnp
   Active Internet connections (only servers)
   Proto Recv-Q Send-Q Local Address   Foreign Address  State    PID/Program name    
   tcp   0      0      0.0.0.0:5566    0.0.0.0:*        LISTEN   25973/sshd: /usr/sb 
   tcp   0      0      0.0.0.0:3309    0.0.0.0:*        LISTEN   76446/mysqld        
   tcp   0      0      0.0.0.0:8080    0.0.0.0:*        LISTEN   962266/docker-proxy 
   tcp   0      0      127.0.0.1:25    0.0.0.0:*        LISTEN   1453/master         
   tcp   0      0      0.0.0.0:80      0.0.0.0:*        LISTEN   55617/nginx: master 
   tcp   0      0      0.0.0.0:3000    0.0.0.0:*        LISTEN   2339400/python3     
   tcp   0      0      127.0.0.1:35471 0.0.0.0:*        LISTEN   57448/containerd    
   tcp   0      0      0.0.0.0:888     0.0.0.0:*        LISTEN   55617/nginx: master 
   tcp6  0      0      :::5566         :::*             LISTEN   25973/sshd: /usr/sb 
   tcp6  0      0      :::8080         :::*             LISTEN   962272/docker-proxy 
   tcp6  0      0      :::33060        :::*             LISTEN   76446/mysqld        
   tcp6  0      0      :::80           :::*             LISTEN   55617/nginx: master 
   tcp6  0      0      ::1:25          :::*             LISTEN   1453/master         
   tcp6  0      0      :::6688         :::*             LISTEN   688797/python3      
   
   (3.12.12) [root@VM-0-7-opencloudos ~]# ss -tlnp
   State    Recv-Q  Send-Q Local Address:Port Peer Address:Port Process                                                                                                                     
   LISTEN   0       128          0.0.0.0:5566      0.0.0.0:*     users:(("sshd",pid=25973,fd=3))                                                                                            
   LISTEN   0       500          0.0.0.0:3309      0.0.0.0:*     users:(("mysqld",pid=76446,fd=21))                                                                                         
   LISTEN   0       4096         0.0.0.0:8080      0.0.0.0:*     users:(("docker-proxy",pid=962266,fd=7))                                                                                   
   LISTEN   0       100        127.0.0.1:25        0.0.0.0:*     users:(("master",pid=1453,fd=13))                                                                                          
   LISTEN   0       511          0.0.0.0:80        0.0.0.0:*     users:(("nginx",pid=348644,fd=9),("nginx",pid=348643,fd=9),("nginx",pid=55617,fd=9))                                       
   LISTEN   0       128          0.0.0.0:3000      0.0.0.0:*     users:(("python3",pid=2339420,fd=6),("python3",pid=2339420,fd=5),("python3",pid=2339400,fd=5))                             
   LISTEN   0       4096       127.0.0.1:35471     0.0.0.0:*     users:(("containerd",pid=57448,fd=8))                                                                                      
   LISTEN   0       511          0.0.0.0:888       0.0.0.0:*     users:(("nginx",pid=348644,fd=8),("nginx",pid=348643,fd=8),("nginx",pid=55617,fd=8))                                       
   LISTEN   0       128             [::]:5566         [::]:*     users:(("sshd",pid=25973,fd=4))                                                                                            
   LISTEN   0       4096            [::]:8080         [::]:*     users:(("docker-proxy",pid=962272,fd=7))                                                                                   
   LISTEN   0       70                 *:33060           *:*     users:(("mysqld",pid=76446,fd=18))                                                                                         
   LISTEN   0       511             [::]:80           [::]:*     users:(("nginx",pid=348644,fd=22),("nginx",pid=348643,fd=22),("nginx",pid=55617,fd=22)) 
   ```

   

3. **外网测试**：
   回到你自己的电脑（本地电脑）的命令终端，再次执行：

   ```
   curl 124.223.154.95:3000
   ```

   此时应该能正常返回 Flask 的响应内容了！
