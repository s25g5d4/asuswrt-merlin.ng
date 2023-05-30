FROM --platform=linux/amd64 mcr.microsoft.com/devcontainers/base:focal

ENV LANG C.UTF-8
ENV TERM xterm-256color

RUN <<EOR
    set -e
    tee -a /etc/apt/sources.list.d/i386.list > /dev/null <<EOT
deb [arch=i386] http://security.ubuntu.com/ubuntu/ focal-security  main restricted universe multiverse
deb [arch=i386]  http://archive.ubuntu.com/ubuntu/ focal           main restricted universe multiverse
deb [arch=i386]  http://archive.ubuntu.com/ubuntu/ focal-updates   main restricted universe multiverse
deb [arch=i386]  http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse
EOT
    DEBIAN_FRONTEND=noninteractive dpkg --add-architecture i386
    DEBIAN_FRONTEND=noninteractive apt update
    DEBIAN_FRONTEND=noninteractive apt -y install autoconf autoconf-archive autogen automake \
    automake-1.15 autopoint bash bison build-essential bzip2 cmake curl cvs diffutils file flex \
    g++ g++-multilib gawk gcc-multilib gconf-editor gettext git gitk gperf groff-base \
    gtk-doc-tools intltool lib32stdc++6 lib32z1-dev libelf1:i386 libexpat1-dev libglib2.0-dev \
    liblzo2-dev libncurses5 libncurses5-dev libproxy-dev libslang2 libssl-dev libtool libtool-bin \
    libvorbis-dev libxml-parser-perl libxml2-dev locales m4 make mtd-utils patch perl pkg-config \
    python sed shtool subversion sudo tar texinfo unzip uuid-dev vim xsltproc xutils-dev zlib1g \
    zlib1g-dev
    rm -rf /var/lib/apt/lists/*
    echo "dash dash/sh boolean false" | debconf-set-selections
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash
EOR
