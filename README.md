# asuswrt-v2ray
使用V2Ray在华硕官方固件AsusWRT实现GFWList模式的透明代理

## 运行环境
* 华硕官方固件AsusWRT

* 已激活USB应用（比如Download Master），可以使用`ipkg`命令（如不需要可以在激活后卸载）

* 路由器架构满足V2Ray要求

__已在 RT-AC86U(3.0.0.4.384.20467) & newifi mini(RT-AC1200HP fw 3.0.0.4.380.8228) 测试通过__

## 预置规则说明
pkg_file/opt/bin/v2ray/geosite.dat 中预置两个域名表：`gfw`和`googlecn`，`googlecn`为白名单直连，优先级高于`gfw`；

`googlecn`使用 @felixonmars 的 [dnsmasq-china-list](https://github.com/felixonmars/dnsmasq-china-list) 中Google部分。

可以使用 @onplus 的 [v2ray-SiteDAT](https://github.com/onplus/v2ray-SiteDAT) 生成自己的geosite.dat

## 使用方法
1. 从 [GitHub Releases](https://github.com/KyonLi/asuswrt-v2ray/releases) 下载预构建ipk包

2. 将下载的v2ray_*version*_*architecture*.ipk放入U盘，ssh执行
```bash
ipkg update
ipkg install v2ray_[version]_[architecture].ipk
```

3. 编辑/opt/etc/v2ray/config.json，在`outboundDetour`填入自己的服务器信息

4. 重启路由器生效，或运行 `/opt/etc/init.d/S60v2ray start` `/opt/etc/init.d/S60v2ray firewall-start` 手动开启。

## 进阶：手动构建ipk软件包
1. 将项目源码下载到本地
```bash
git clone https://github.com/KyonLi/asuswrt-v2ray.git
```

2. 从 [V2Ray Releases](https://github.com/v2ray/v2ray-core/releases) 下载v2ray-linux-*.zip，将其中的v2ray和v2ctl放到pkg_file/opt/bin/v2ray/目录

2. 编辑pkg_file/CONTROL/control：`Architecture`和`Version`与v2ray对应

3. 安装 [ipkg-utils](http://downloads.buffalo.nas-central.org/ArchIndependent/Sources/ipkg-utils-050831.tar.gz)，使用ipkg-build生成v2ray_*version*_*architecture*.ipk
```bash
ipkg-build -c -o admin -g root <pkg_file目录所在路径> [<ipk包生成路径>]
```
