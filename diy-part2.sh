# 修改默认登录地址为 192.168.2.1
# 优先处理新版路径
if [ -f package/base-files/luci2/bin/config_generate ]; then
    sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/luci2/bin/config_generate
    echo "已修改新版路径: package/base-files/luci2/bin/config_generate"
# 兼容旧版路径
elif [ -f package/base-files/files/bin/config_generate ]; then
    sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
    echo "已修改旧版路径: package/base-files/files/bin/config_generate"
else
    echo "警告: 未找到 config_generate 文件，IP 可能未修改"
fi


# 设置默认root密码为 Xiang!%1688@
mkdir -p files/etc/uci-defaults
cat <<EOF > files/etc/uci-defaults/99-set-root-password
#!/bin/sh
# 设置root密码
echo -ne "Xiang!%1688@\nXiang!%1688@" > /tmp/root_password.txt
passwd root < /tmp/root_password.txt
rm -f /tmp/root_password.txt
exit 0
EOF

# 赋予脚本可执行权限
chmod +x files/etc/uci-defaults/99-set-root-password