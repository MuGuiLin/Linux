# 在Linux中 全局指定node.js版本



### 一、常见场景及对应配置位置

在 Linux 系统中，**Node.js 的全局版本本身并不会自动写入 `/etc` 目录下的 profile文件 或 某个标准配置文件中**。

**vim etc/profile**

```shell
# /etc/profile: system-wide .profile file for the Bourne shell (sh(1))
# and Bourne compatible shells (bash(1), ksh(1), ash(1), ...).

if [ "${PS1-}" ]; then
  if [ "${BASH-}" ] && [ "$BASH" != "/bin/sh" ]; then
    # The file bash.bashrc already sets the default PS1.
    # PS1='\h:\w\$ '
    if [ -f /etc/bash.bashrc ]; then
      . /etc/bash.bashrc
    fi
  else
    if [ "$(id -u)" -eq 0 ]; then
      PS1='# '
    else
      PS1='$ '
    fi
  fi
fi

if [ -d /etc/profile.d ]; then
  for i in /etc/profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

export NODE_HOME=/usr/local/node-v22.18.0 # 要指定的node.js版本(就是下载node.js的那个目录[一般放在/usr/local/目录下])
export PATH=$NODE_HOME/bin:$PATH # 将 NODE_HOME路径变量下的/bin目录，指定到全局环境变量中

```

但如果你是通过 **包管理器（如 apt、yum）安装的 Node.js**，或者使用了 **nvm、n、fnm 等版本管理工具**，那么“指定全局 Node.js 版本”的方式和相关配置文件位置会有所不同。



### 二、`/etc` 目录下可能涉及的文件

| 文件                     | 是否可能指定 Node.js 全局版本 | 说明                                  |
| ------------------------ | ----------------------------- | ------------------------------------- |
| `/etc/environment`       | ✅ 可能                        | 设置系统级 `PATH`                     |
| `/etc/profile`           | ✅ 可能                        | 登录时加载的环境变量                  |
| `/etc/profile.d/*.sh`    | ✅ 可能                        | 常用于添加自定义 PATH（如 `node.sh`） |
| `/etc/alternatives/node` | ⚠️ 间接                        | 如果用了 `update-alternatives`        |
| `/etc/nodejs/...`        | ❌ 否                          | 一般不存在                            |
| `/etc/npmrc`             | ❌ 否                          | 是 npm 配置，不是 Node 版本           |



### 三、如何查找当前生效的 Node 路径？

```shell
which node
# 例如输出：/usr/bin/node 或 /home/user/.nvm/versions/node/v14.20.1/bin/node

readlink -f $(which node)
# 查看真实路径
```

再结合以下命令来，判断是从哪个目录加载的。

```shell
echo $PATH
```



### 四、建议

如果你希望**为所有用户设置统一的 Node.js 版本**，推荐：

1. **不要用 nvm（它是用户级的）**

2. 使用系统包管理器安装固定版本，或

3. 手动安装到 `/usr/local/node`，然后在 `/etc/profile.d/node.sh` 中添加：

   ```shell
   # /etc/profile.d/node.sh
   export NODE_HOME=/usr/local/node
   export PATH=$NODE_HOME/bin:$PATH
   ```

   然后执行：

   ```shell
   chmod +x /etc/profile.d/node.sh
   source /etc/profile
   ```





