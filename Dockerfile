FROM alpine
#声明作者
LABEL maintainer="a little <mo@autre.cn>"

#升级内核及软件
RUN set -x \
    ##&& sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk upgrade \
    ##设置时区
    ##&& apk --update add --no-cache tzdata \
    && apk add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del tzdata
    ## 清除安装软件及缓存
    ##&& rm -rf /tmp/* /var/cache/apk/*
    
##设置npm国内源
ENV NPM_REGISTRY=
##安装nodejs和npm
RUN set -x \
    && apk add nodejs npm \
    && rm -rf /tmp/* /var/cache/apk/*

##设置bucket名
ENV BUCKET=ioutio
##设置构建静态文件路径
ENV DEST=dist

WORKDIR /var/app
COPY build2oss /usr/local/bin/
##安装ossutil
RUN set -x \
    && chmod +x /usr/local/bin/build2oss \
    && mkdir -p /var/app/docs \
    && wget -O /usr/local/bin/ossutil http://gosspublic.alicdn.com/ossutil/1.6.11/ossutil64 \
    && chmod +x /usr/local/bin/ossutil

##挂载目录
VOLUME /var/app
##构建静态文件并推送到oss
CMD ["sh", "-c", "build2oss -d ${DEST} -b ${BUCKET} -s ${NPM_REGISTRY}"]
