# asuswrt-v2ray
使用V2Ray在华硕官方固件AsusWRT实现GFWList模式的透明代理

## 运行环境
1. AsusWRT官方固件；

2. 已激活Download Master可以使用`ipkg`（如不需要Download Master可以在激活后卸载）；

3. 路由器架构满足V2Ray要求。

__RT-AC86U(3.0.0.4.384.20467) newifi mini(RT-AC1200HP fw 3.0.0.4.380.8228) 测试通过__

## 预置规则说明
pkg_file/opt/bin/v2ray/geosite.dat 中预置两个域名表：`gfw`和`googlecn`，`googlecn`为白名单直连，优先级高于`gfw`；

`googlecn`使用 @felixonmars 的 [dnsmasq-china-list](https://github.com/felixonmars/dnsmasq-china-list) 中Google部分。

可以使用 @onplus 的 [v2ray-SiteDAT](https://github.com/onplus/v2ray-SiteDAT) 生成自己的geosite.dat

## 使用方法

### 构建ipkg软件包
1. 从 [V2Ray Release](https://github.com/v2ray/v2ray-core/releases) 下载v2ray-linux-*.zip，将其中的v2ray和v2ctl放到pkg_file/opt/bin/v2ray/目录；

2. 编辑pkg_file/CONTROL/control：`Architecture`和`Version`与v2ray对应；

3. 安装 [ipkg-utils](http://ipkg.nslu2-linux.org/sources/ipkg-utils-1.7.tar.gz)，使用ipkg-build生成v2ray_*version*_*architecture*.ipk
```bash
ipkg-build -c -o admin -g root <pkg_file目录所在路径> [<ipk包生成路径>]
```

### 安装到路由器
1. 将v2ray_*version*_*architecture*.ipk放入U盘，ssh执行
```bash
ipkg install v2ray_[version]_[architecture].ipk
```

2. 编辑/opt/etc/v2ray/config.json，在`outboundDetour`填入自己的服务器信息；

3. 重启路由器生效，或运行 `/opt/etc/init.d/S60v2ray start` `/opt/etc/init.d/S60v2ray firewall-start` 手动开启。
