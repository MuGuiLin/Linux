# SRS(Simple Realtime Server)  流媒体服务

[中文官网：https://ossrs.net/lts/zh-cn/](https://ossrs.net/lts/zh-cn/)

[英文官网：https://ossrs.io/lts/en-us/](https://ossrs.io/lts/en-us/)

[SRS Server | SRS](https://ossrs.net/lts/zh-cn/docs/v6/tutorial/srs-server)



## SRS

**SRS(Simple Realtime Server)**是一个开源的实时视频[服务器](https://cloud.tencent.com/product/cvm?from_column=20065&from=20065)，支持RTMP、WebRTC、HLS、HTTP-FLV、SRT等多种流媒体协议。它是一个轻量级、高性能的流媒体服务器解决方案，广泛应用于直播、视频会议、[在线教育](https://cloud.tencent.com/solution/education?from_column=20065&from=20065)等场景。

### 应用场景：

1. **直播平台**：支持RTMP推流和HLS/HTTP-FLV播放
2. **在线教育**：支持低延迟的实时互动
3. **监控系统**：支持多路视频流的汇聚和分发
4. **视频会议**：结合WebRTC实现实时通信

### 主要优势：

1. **开源免费**：MIT许可证，可自由使用和修改
2. **高性能**：单机可支持数千并发
3. **多协议支持**：RTMP、HLS、HTTP-FLV、WebRTC等
4. **跨平台**：支持Linux、Windows、macOS
5. **可扩展**：支持集群部署和CDN分发



## FFmpeg

**FFmpeg**‌ 是一个开源的音视频处理工具集，由 FFmpeg 社区维护，源码和官方下载页面位于 [ffmpeg.org](https://ffmpeg.org/download.html)，用于编码、转码、推拉流等操作。虽然 SRS 和 FFmpeg 功能不同，但它与SRS常配合使用。

- 其他推流软件：[Open Broadcaster Software | OBS](https://obsproject.com/)



## FFmpeg 与 SRS的配合

1. **FFmpeg 用于推流**（将摄像头、视频文件推送到 SRS）或转码（如将高码率流转为多码率适配不同设备）。
2. **负责接收、分发和协议转换**（SRS 本身‌**不依赖**‌ ffmpeg.org 的代码实现，但在某些高级功能（如 ingest 拉流、转码）中会调用 FFmpeg 作为外部工具 ‌）。



## 在本地电脑上安装 SRS流媒体服务

一、以在Windows系统中下载安装为例：[下载SRS软件 https://github.com/ossrs/srs/tags](https://github.com/ossrs/srs/tags)

二、通过FFmpeg、OBS 向 SRS推流。

三、在SRS中拿到直播流地址，如：webrtc://r.ossrs.net/live/livestream、https://d.ossrs.net/live/livestream.m3u8 等



## [在云服务器上安装 SRS流媒体服务](https://cloud.tencent.com/developer/article/2549823)

### 一、安装方式

#### **1. 从源码编译安装**

这是最灵活的安装方式，适合需要自定义功能的用户：

```shell
# 安装依赖
sudo apt-get update
sudo apt-get install -y git g++ make cmake

# 克隆源码
git clone https://github.com/ossrs/srs.git
cd srs/trunk

# 编译
./configure && make

# 启动服务器
./objs/srs -c conf/srs.conf
```

#### **2. 使用Docker安装**

对于快速部署和测试，推荐使用[Docker](https://cloud.tencent.com/product/tke?from_column=20065&from=20065)方式：

```shell
docker run --rm -p 1935:1935 -p 1985:1985 -p 8080:8080 registry.cn-hangzhou.aliyuncs.com/ossrs/srs:4 ./objs/srs -c conf/srs.conf
```

#### **3. 预编译包安装**

对于Ubuntu/Debian系统：

```shell
wget -O srs.tar.gz https://github.com/ossrs/srs/releases/download/v4.0.263/srs-ubuntu20-v4.0.263.tar.gz
tar -xzf srs.tar.gz
cd srs-ubuntu20-v4.0.263/trunk
./objs/srs -c conf/srs.conf
```



### 二、**配置文件说明**

SRS的核心配置文件通常为`conf/srs.conf`，主要配置项包括：

```shell
listen              1935;
max_connections     1000;
daemon              on;
pid                 ./objs/srs.pid;
srs_log_tank        file;
srs_log_file        ./objs/srs.log;

http_server {
    enabled         on;
    listen          8080;
    dir             ./objs/nginx/html;
}

vhost __defaultVhost__ {
    hls {
        enabled         on;
        hls_path       ./objs/nginx/html;
        hls_fragment   10;
        hls_window     60;
    }
}
```

安装完成后，您可以通过访问`http://服务器IP:8080`来查看SRS控制台，测试推流和播放功能。



### 三、常见问题及解决方案

#### **1. 端口被占用**

**📢问题现象**：启动时提示端口被占用

**✅解决方案**：

- 检查端口占用情况：`netstat -tulnp | grep 1935`
- 修改配置文件中的端口号
- 或者停止占用端口的服务

#### **2. 推流失败**

**📢问题现象**：使用OBS等工具推流失败

**✅解决方案**：

- 检查防火墙设置，确保1935(RTMP)、8080(HTTP)等端口开放
- 检查SRS日志：`tail -f ./objs/srs.log`
- 确保推流地址格式正确：`rtmp://服务器IP/live/流名称`

#### **3. 播放延迟高**

**📢问题现象**：直播延迟较大

**✅解决方案**：

- 启用低延迟配置：
- 启用低延迟配置：
- 考虑使用WebRTC协议替代RTMP

