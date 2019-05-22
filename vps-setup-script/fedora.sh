#!/bin/bash
# install the dependency packages
dnf install -y iptables-services policycoreutils-python-utils git gcc autoconf libtool automake make zlib-devel openssl-devel asciidoc xmlto libev-devel

# enable the ss repo and install ss
dnf copr enable librehat/shadowsocks -y
dnf install shadowsocks-libev -y

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
semanage port -a -t ssh_port_t -p tcp 22222
systemctl restart sshd

# add default config for ss
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

# configure the obfs
git clone https://github.com/shadowsocks/simple-obfs.git
pushd simple-obfs
git submodule update --init --recursive
./autogen.sh
./configure && make
make install
popd

# start ss service
systemctl restart shadowsocks-libev

# make packages up to date
dnf update -y
