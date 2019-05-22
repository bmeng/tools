#!/bin/bash
# install the dependency packages
yum install -y iptables-services git gcc autoconf libtool automake make zlib-devel openssl-devel asciidoc xmlto libev-devel

# add the required repos
yum install epel-release -y
curl -o /etc/yum.repos.d/ss-libev.repo https://copr.fedorainfracloud.org/coprs/librehat/shadowsocks/repo/epel-7/librehat-shadowsocks-epel-7.repo

# install shadowsocks-libev
yum install shadowsocks-libev -y

# use iptables instead of firewalld
systemctl stop firewalld 
systemctl disable firewalld
systemctl start iptables
systemctl enable iptables

iptables -I INPUT -p tcp --dport 22222 -j ACCEPT
iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
iptables -I INPUT -p udp --dport 8080 -j ACCEPT
iptables-save > /etc/sysconfig/iptables

# change the default ssh port
sed -i 's/#Port 22/Port 22222/g' /etc/ssh/sshd_config
systemctl restart sshd

# add the config file for ss
cat > /etc/shadowsocks-libev/config.json << EOF
{
    "server":"0.0.0.0",
    "server_port":8080,
    "password":"19850720",
    "timeout":60,
    "mode": "tcp_and_udp",
    "no_delay": true,
    "fast_open": true,
    "plugin":"obfs-server",
    "plugin_opts":"obfs=http",
    "method":"chacha20-ietf-poly1305"
}
EOF

# enable the obfs
git clone https://github.com/shadowsocks/simple-obfs.git
pushd simple-obfs
git submodule update --init --recursive
./autogen.sh
./configure && make
make install
popd

# start the shadowosocks service
systemctl restart shadowsocks-libev

# update packages
yum update -y

