## [build2oss](https://iout.io/open/build2oss)

## 准备条件

1. oss 秘钥配置文件 ossutilconfig

```
[Credentials]
    language=CH
    accessKeyID=LTAIbZcdVCmQ****
    accessKeySecret=D26oqKBudxDRBg8Wuh2EWDBrM0****
    endpoint=oss-cn-hongkong.aliyuncs.com
```

2. 基于项目安装的 vuepress 或者 hexo
3. package.json 增加 scripts

```
"scripts": {
  "build2oss": "npx xxxxxxxx"
}
```

## vuepress 使用方法：

进到 vuepress 根目录，确保结构如下，有 ossutilconfig 文件

```
. 根目录
|--docs
|--|--dist          #生成的静态文件目录
|--|--.vuepress
|--|--|--config.js  #vuepress配置文件
|--|--README.md
|--package.json     #vuepress所属项目配置文件
|--ossutilconfig    #阿里云oss配置参数
```

package.json 中"build2oss"："npx vuepress build docs"

执行，\${BUCKET}改为自己 oss 的 bucket 名称

```
docker run -i --name build2oss -v "$(pwd)/":/var/app -e DEST="docs/dist" -e BUCKET=${BUCKET} ioutio/build2oss
```

## hexo 使用方法：

进到 hexo 根目录，确保结构如下，有 ossutilconfig 文件

```
. 根目录
|--public           #生成的静态文件目录
|--package.json     #vuepress所属项目配置文件
|--ossutilconfig    #阿里云oss配置参数
```

package.json 中"build2oss"："npx hexo generate"

执行，\${BUCKET}改为自己 oss 的 bucket 名称

```
docker run -i --name build2oss -v "$(pwd)/":/var/app -e DEST="public" -e BUCKET=${BUCKET} ioutio/build2oss
```
