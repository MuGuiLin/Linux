# Linux系统常用命令

~# **cd /**
> 进入服务器根目录

~# **cd ~**

> 进入当前用户目录

~# **pwd ~**

> 查看当前所在目录

~# **ll**

>显示当前目录的内容，ll命令是ls -l别名，
>
>ls命令有很多参数：
>
>- -a 列出目录下的一切文件，包含以 . 最初的隐含文件。//常用
>- -m 横向输出文件名，并以“，”作分格符。
>- -c 输出文件的 i 节点的修正时刻，并以此排序。
>- -R 列出一切子目录下的文件。
>- -l 列出文件的具体信息。
>- -s 在每个文件名后输出该文件的巨细。
>- -k 以 k 字节的方式表明文件的巨细。
>- -i 输出文件的 i 节点的索引信息。



### 给新安装的Ubuntu系统开启root账户登录权限

1. 先用ubuntu账号用SSH方式登录，注：ubuntu账户是Ubuntu Server的默认账户，它的密码在购买服务器时可以自已设置 或 在云服务器创建成功后将这个初始密码发到站内信中。

2. ~# **cd /**

    > 进入服务器根目录，刚登录时，是在当前登录账户的目录中（就是在 /home/ubuntu /目录中）

3. 登录后执行**sudo -i**命令，将命令使用权限 从ubuntu账户 切换到 root账户

    user@ubuntu:~# **sudo -i**	

    > 改变用户对命令使用权限（在使用ubuntu系统时，刚安装的Ubuntu系统无法登陆到root用户，可以使用sudo - i命令进入root用户为其设置密码后才能使用！！！）
    >
    > 开始为“user@ubuntu:~$”,当使用该命令后，会出现输入密码的提示，之后输入密码【注：刚安装的Ubuntu系统 的root用户，密码为空】，就会变为“root@ubuntu:~#”。

4. 给root账户设置密码

    root@ubuntu:~# **sudo passwd root**

    > 执行以上命令后，要需求输入两次密码，以确认设置root账户密码【注：请牢记这个密码哦】，因为root账户是权限最大的账户，所以在刚购买 或 刚安装Ubuntu系统后 root账户是不能使用的，而且密码也是空的。

    

5. 修改sshd_config远程连接配置文件，以开启root账户

    root@ubuntu:~# **sudo vi /etc/ssh/sshd_config**

    > 执行以上命令后将打开SSH配置文件sshd_config
    >
    > 1、找到PermitRootLogin without-password 配置项，把后面的without-password改为yes，并取消注释（去掉最前面的#号）。
    >
    > 2、找到PasswordAuthentication  把no改成yes，并取消注释（去掉最前面的#号）。
    >
    > 3、保存并退出vi编辑（按下快捷键 shift + :  然后输入wq就保存并退出了）。

6. 重启SSH远程连接服务

    root@ubuntu:~# **/etc/init.d/ssh restart**

    > 执行以上命令 或 执行 sudo service ssh restart 就重启SSH服务了

7. 至此给新安装的Ubuntu系统开启root账户登录权限就大功告成了，就可以使用root账户来登录SSH等服务啦。



### 自定义服务器端口号

> **这里以配置SSH远程连接服务的端口号为例！**
>
> 由于新安装的Ubuntu系统默认SSH远程连接的端口号是22，这里大多数Linux系统默认的端口号，为了安全起见，修改这个端口号也是很有必要的

1. 用SSH登录后执行如下命令，添加自已定义端口号

    root@ubuntu:~# **sudo vi /etc/ssh/sshd_config**	

    > 编辑SSH配置文件(注：腾讯云 和 阿里云 还不一样，在云服务器后台管理 的**安全组**中添加了端口号后，还要在服务器中的SSH配置文件中的 **Port** 配置项中添加对应的端口号)


 2. 找到Port配置项 在后面输入自己要设置的端口号

    > 由于Port配置项默认是被禁用的 #Port 22，因为系统默认的SSH端口号就是22
    >
    > 所以，就另起一行 或 取消注释（去掉最前面的#号）配置自己要设置的端口号
    >
    > 如 Port 888

 3. 重启SSH远程连接服务

    root@ubuntu:~# **/etc/init.d/ssh restart**

    

 2. 查看服务器中的端口号，如查例出了自己刚才新添加了端口号，表添加成功啦

    root@ubuntu:~# **netstat -nltp** 

    

 3. 如果是云服务器还在要在控制台的安全组规则中，添加入站规则

    > 如：0.0.0.0/0		TCP:888









