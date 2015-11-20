#安装配置Shadowsocks
apt-get update && upgrade
mkdir SS
cd SS
apt-get install python-pip
pip install shadowsocks
wget https://github.com/PINK-FL0YD/SS/blob/master/Config/shadowsocks.json 
mv ./shadowsocks.json /etc/shadowsocks.json
ssserver -c /etc/shadowsocks.json -d start

#内核参数优化
echo "* soft nofile 51200 
	* hard nofile 51200" >> /etc/security/limits.conf

ulimit -n 51200

#修改参数
echo "fs.file-max = 51200
net.core.rmem_max = 67108864
net.core.wmem_max = 67108864
net.core.netdev_max_backlog = 250000
net.core.somaxconn = 4096

net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 0
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.ip_local_port_range = 10000 65000
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_rmem = 4096 87380 67108864
net.ipv4.tcp_wmem = 4096 65536 67108864
net.ipv4.tcp_mtu_probing = 1
net.ipv4.tcp_congestion_control = hybla" > /etc/sysctl.conf

#使配置生效
sysctl -p

#锐速优化，输入用户名密码
wget http://my.serverspeeder.com/d/ls/serverSpeederInstaller.tar.gz
tar xzvf serverSpeederInstaller.tar.gz
bash serverSpeederInstaller.sh
wget https://github.com/PINK-FL0YD/SS/blob/master/Config/serverspeeder/config 
mv ./config /serverspeeder/etc/config

#重启锐速
service serverSpeeder restart
