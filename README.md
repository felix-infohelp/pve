# pve v8 筆記

# 磁區配置調整


### 結合 PVE & Docker
# 安裝 docker系統 
curl -sSL https://get.docker.com | sh

systemctl enable docker

# 設定 docker管理界面在 8007
docker run -d -p 8007:9000 -v /var/run/docker.sock:/var/run/docker.sock \
--name ui --restart=always lihaixin/portainer:me

docker info # 查看 docker運作狀況

iptables -L -n -v # 查看防火牆設定

iptables -L -n -v -t nat # 查看防火牆設定

# 用瀏覽器登入 8007管理界面設定管理密碼

