FROM scratch
ADD rootfs.tar.gz /
# 设置时区为 Shanghai
COPY Shanghai /etc/localtime
# 更换为科大源
RUN sed -i 's|dl-cdn.alpinelinux.org|mirrors.ustc.edu.cn|g' /etc/apk/repositories
CMD ["/bin/sh"]
