# Docker开发环境(CentOS8版本)
- base (基础镜像)
- openresty
- php
- build-base (编译环境)
- es
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

## 注意
1. 在构建yapi镜像的时候可能会出现开头为"gyp ERR!"的报错，没有影响，可以忽略
2. 在自带的php和openresty编译脚本中，会带有"-Os"参数，表示编译时不加入debug信息，也就不能用gdb调试，如果需要gdb调试的话，“bash build.sh dev”重新编译，不过体积会变大很多
