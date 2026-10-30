# 1-添加 大鹅 插件
# git clone https://github.com/kenzok8/openwrt-daede.git package/openwrt-daede
# git clone https://github.com/QiuSimons/luci-app-daed.git package/luci-app-daed

# 2-添加 集客 插件
# git clone https://github.com/laipeng668/luci-app-gecoosac.git package/luci-app-gecoosac

git clone https://github.com/timsaya/luci-app-bandix.git package/luci-app-bandix

# 3-添加 PassWall2 插件
sed -i '1i src-git passwall_packages https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git;main' feeds.conf.default
sed -i '1i src-git passwall2 https://github.com/Openwrt-Passwall/openwrt-passwall2.git;main' feeds.conf.default
