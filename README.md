# Docker开发环境(CentOS8版本)
- base (基础镜像)
- openresty
- php
- build-base (编译环境)
- elasticsearch
- kibana
- influxdb
- grafana
- kafka
- zookeeper
- mysql
- mongodb
- redis
- memcached
- gitea
- yapi

## 安装
1. git clone https://github.com/donkeywon/docker_centos
2. cd docker_centos && git submodule update --init --recursive

## 使用
- 构建单个镜像
    ```bash
    docker-compose build <image_name>
    ```
- 构建所有镜像
    ```
    bash build_all.sh
    ```

## 建议的开发目录结构
```
.
├─ code
│  ├─ c
│  ├─ php
│  ├─ web
│  ├─ ...
├─ env
│  ├─ docker_centos

```
