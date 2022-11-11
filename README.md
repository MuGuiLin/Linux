# Linux系统常用命令

~# **cd /**
> 进入服务器根目录


~# **cd ~**
> 进入当前用户目录


~# **sudo -i**	

> 改变用户对命令使用权限（在使用ubuntu系统时，刚安装的Ubuntu系统无法登陆到root用户，可以使用sudo - i命令进入root用户下使用passwd改变root用户密码）开始为“user@ubuntu:~$”,当使用该命令后，会出现输入密码的提示，之后输入密码【注：刚安装的Ubuntu系统 的root用户，密码为空】，就会变为“root@ubuntu:~#”。



~# **vi /etc/ssh/ssh**	

> 编辑SSH配置文件(注：腾讯云 和 阿里云 还不一样，在云服务器后台管理 的安全组中添加了端口号后，还要在服务器中的SSH配置文件中 Port 配置项中添加对应在的端口号)



~# **/etc/init.d/ssh restart** 

> 重启SSH服务



~# **netstat -nltp** 

> 查看服务器中的端口号

