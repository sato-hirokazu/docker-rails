# docker-rails
rails + dockerの環境構築

## 事前にインストール

### VirtualBox
https://www.virtualbox.org/wiki/Downloads
から、インストーラーをダウンロードし、インストールします。

### Boot2Docker

https://docs.docker.com/installation/mac/

https://github.com/boot2docker/osx-installer/releases から、Boot2Docker-x.x.x.pkgをダウンロードしてインストールする

### Docker toolbox
https://www.docker.com/products/docker-toolbox
から、インストーラーをダウンロードし、インストールします。

下記のコンポーネントがインストールされます。
- Docker Engine
- Compose
- Machine
- Kitematic

## 使い方

## Docker Machineの構築

`--virtualbox-hostonly-cidr` を指定して、他のDocker MachineとNWが被らないようにする。この例では`192.168.99.100`とします。

```
$ docker-machine create --driver virtualbox --virtualbox-hostonly-cidr "192.168.99.1/24" sample
```

## 環境変数の設定
```
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.100:2376"
export DOCKER_CERT_PATH="/Users/hsato/.docker/machine/machines/sample"
export DOCKER_MACHINE_NAME="sample"
# Run this command to configure your shell:
# eval $(docker-machine env sample)
```

```
eval $(docker-machine env sample)
```

## Docker MachineのNFS設定
```
$ sudo bash -c "echo $PWD $(docker-machine ip sample) -alldirs -maproot=root >> /etc/exports"
```

### VirtualBox

```
$ docker-machine ssh sample "cat <<EOF > bootlocal.sh
#/bin/bash
sudo umount $PWD
mkdir -p $PWD
sudo /usr/local/etc/init.d/nfs-client start
sudo mount -t nfs -o noacl,async '192.168.99.1':$PWD $PWD
EOF
"
$ docker-machine ssh sample chmod a+x bootlocal.sh
$ docker-machine ssh sample sudo cp bootlocal.sh /var/lib/boot2docker/
```

### Docker machineの起動
```
$ docker-machine start sample
```
