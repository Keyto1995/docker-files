FROM keyto/alpine-arm64:3.8

LABEL maintainer="keyto <keyto1995@outlook.com>"

ARG make_jobs

ENV NODE_VERSION 10.14.1

RUN set -ex \
  # 设置node用户
  && addgroup -g 1000 node \
  && adduser -u 1000 -G node -s /bin/sh -D node \
  # 更换为科大源
  && sed -i 's|dl-cdn.alpinelinux.org|mirrors.ustc.edu.cn|g' /etc/apk/repositories \
  # 安装编译工具
  && apk add --no-cache \
    libstdc++ \
  && apk add --no-cache --virtual .build-deps \
    binutils-gold \
    linux-headers \
    curl \
    g++ \
    gcc \
    gnupg \
    libgcc \
    make \
    python \
  # 导入node源码包公钥
  # gpg keys listed at https://github.com/nodejs/node#release-keys
  && for key in \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    77984A986EBC2AA786BC0F66B01FBB92821C587A \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    8FCCA13FEF1D0C2E91008E09770F7A9A5AE15600 \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
  ; do \
    gpg --batch --keyserver pool.sks-keyservers.net --recv-keys "$key" ; \
  done \
  && cd /tmp \
  # 下载并校验源码文件
  && curl -fsSLO --compressed "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.xz" \
  && curl -fsSLO --compressed "https://nodejs.org/dist/v${NODE_VERSION}/SHASUMS256.txt.asc" \
  && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
  && grep " node-v${NODE_VERSION}.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  # 编译安装node
  && tar -xf "node-v${NODE_VERSION}.tar.xz" \
  && cd "node-v${NODE_VERSION}" \
  && ./configure \
  && make -j${make_jobs} \
  && make install \
  # 清理
  && apk del .build-deps \
  && cd .. \
  && rm -Rf "node-v${NODE_VERSION}" \
  && rm "node-v${NODE_VERSION}.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt

CMD ["node"]