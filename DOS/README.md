# DOS（Disk Operating System）



## [磁盘操作系统](https://baike.baidu.com/item/磁盘操作系统/3793138?fromModule=lemma_inlink)（Disk Operating System），是早期[个人计算机](https://baike.baidu.com/item/个人计算机/3731770?fromModule=lemma_inlink)上的一类[操作系统](https://baike.baidu.com/item/操作系统/192?fromModule=lemma_inlink)。

> 从1981年MS-DOS1.0直到1995年MS-DOS 6.22的15年间，DOS作为微软公司在个人计算机上使用的一个操作系统载体，推出了多个版本。DOS在IBM PC 兼容机市场中占有举足轻重的地位。可以直接操纵管理硬盘的文件，以DOS的形式运行。

![](https://bkimg.cdn.bcebos.com/pic/a8014c086e061d9595b883b97bf40ad163d9cab1?x-bce-process=image/format,f_auto/watermark,image_d2F0ZXIvYmFpa2UyNzI,g_7,xp_5,yp_5,P_20/resize,m_lfit,limit_1,h_1080)

> DOS是1979年由微软公司为IBM个人电脑开发的MS-DOS,它是一个单用户单任务操作系统。后来DOS的概念也包括了其它公司生产的与MS-DOS兼容的系统，如PC-DOS、DR-DOS, 以及一些其它相对不太出名的DOS兼容产品。
>
> 它们在1985年到1995年及其后的一段时间内占据操作系统的统治地位,最著名和广泛使用的DOS系统从1981年直到1995年的15年间微软在推出Windows 95之后，宣布MS-DOS不再单独发布新版本。不过FreeDOS等与MS-DOS兼容的DOS则在继续发展着。
>
> 从1981年直到1995年的15年间，磁盘操作系统在IBM PC兼容机市场中占有举足轻重的地位。而且，若是把部分以DOS为基础的Microsoft Windows版本，如Windows 95、Windows 98和Windows Me等都算进去的话，那么其商业寿命至少可以算到2000年。微软的所有后续版本中，磁盘操作系统仍然被保留着。



### Windows系统中 查看IP信息

在DOS命令窗口中输入如下命令：

```shell
# 查看IP配置信息
ipconfig

# 如果电脑没有联网，或者外网连接有问题，也会导致无法解析主机名。
# 可以尝试 ping 公共 DNS 服务器，如 ping 8.8.8.8 或 ping 114.114.114.114，以检查网络连接是否正常‌
ping 8.8.8.8
ping 8.8.8.8 -t # -t参数 会一直拼（不加-t 只拼4次就结束！）
ping 114.114.114.114

# 拼域名：在命令行中使用 ping 命令时，应使用主机名或 IP 地址，而不是 URL。
# 例如，应使用 ping www.baidu.com 而不是 ping http://www.baidu.com。URL 中的协议部分（如 http://）不会被 ping 命令识别和处理‌

ping baidu.com
# 好处：使用ping命令，还可以查看某个域名绑定的IP！
ping www.muguilin.com -t # -t参数 会一直拼（不加-t 只拼4次就结束！）
正在 Ping muguilin.com [118.195.218.176] 具有 32 字节的数据:

```



### Windows系统中 查看/关闭 端口

在DOS命令窗口中输入如下命令：

```shell
# 查看netstat相关参数
netstat h

# 查看已启动的端口
netstat -a # 显示所有连接和侦听端口
netstat -r # 显示路由表。

# 关闭指定端口
netstat -ano # 显示所有已启动端口 和 进程ID

taskkill -PID 8668 -F # 指定杀掉端口对应的 进程ID   /F 表示强制执行

```

