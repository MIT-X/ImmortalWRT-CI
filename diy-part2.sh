# 修改默认登录地址为 192.168.2.250
# 新版路径
if [ -f package/base-files/luci2/bin/config_generate ]; then
    sed -i 's/192.168.1.1/192.168.2.250/g' package/base-files/luci2/bin/config_generate
    echo "已修改新版路径: package/base-files/luci2/bin/config_generate"
# 旧版路径
elif [ -f package/base-files/files/bin/config_generate ]; then
    sed -i 's/192.168.1.1/192.168.2.250/g' package/base-files/files/bin/config_generate
    echo "已修改旧版路径: package/base-files/files/bin/config_generate"
else
    echo "警告: 未找到 config_generate 文件，IP 可能未修改"
fi


# 设置密码 + 主机名
mkdir -p files/etc/uci-defaults
cat <<EOF > files/etc/uci-defaults/99-set-root-password

# 设置 root 密码
echo -ne "Xiang!%1688@\nXiang!%1688@" > /tmp/root_password.txt
passwd root < /tmp/root_password.txt
rm -f /tmp/root_password.txt

# 修改默认主机名为 AP8220
uci set system.@system[0].hostname='ImmortalWRT'
uci commit system
exit 0
EOF
chmod +x files/etc/uci-defaults/99-set-root-password


# 删除 Passwall2 / Xray-core 老版本
rm -rf feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,v2ray-plugin,xray-plugin,geoview,shadow-tls,smartdns}
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/luci/applications/luci-app-passwall2
git clone https://github.com/Openwrt-Passwall/openwrt-passwall-packages package/passwall-packages
git clone https://github.com/Openwrt-Passwall/openwrt-passwall2.git package/package/passwall2
