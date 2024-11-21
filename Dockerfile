FROM ubuntu:xenial-20210114

COPY ./ctf.xinetd /etc/xinetd.d/ctf

ENV LD_LIBRARY_PATH /usr/arm-linux-gnueabihf/lib/sf/

RUN sed -i "s/http:\/\/archive.ubuntu.com/http:\/\/mirrors.aliyun.com/g" /etc/apt/sources.list && \
    apt-get update && apt-get -y dist-upgrade && \
    apt-get install -y lib32z1 xinetd build-essential qemu gcc-arm-linux-gnueabi && \
    useradd -m ctf && \
    echo 'ctf - nproc 1500' >>/etc/security/limits.conf && \
    ln -s /usr/arm-linux-gnueabihf/lib/sf/ld-linux.so.3 /lib/

CMD exec /bin/bash -c "chown root:ctf /pwn/pwn && chmod 750 /pwn/pwn && echo $FLAG > /flag && export FLAG=not_flag && FLAG=not_flag && /etc/init.d/xinetd start; trap : TERM INT; sleep infinity & wait"

COPY pwn /pwn/pwn

EXPOSE 10000
