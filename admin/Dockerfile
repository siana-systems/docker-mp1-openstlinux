FROM ubuntu:16.04
 
RUN apt-get update && \
    apt-get install -y \
    sed wget curl cvs subversion git-core coreutils unzip texi2html \
    texinfo docbook-utils gawk python-pysqlite2 diffstat help2man make \
    gcc build-essential g++ desktop-file-utils chrpath libxml2-utils xmlto \
    docbook bsdmainutils iputils-ping cpio python-wand python-pycryptopp python-crypto \
    libsdl1.2-dev xterm corkscrew nfs-common nfs-kernel-server device-tree-compiler \
    mercurial u-boot-tools libarchive-zip-perl \
    ncurses-dev bc linux-headers-generic gcc-multilib libncurses5-dev libncursesw5-dev \
    lrzsz dos2unix lib32ncurses5 repo \
    localehelper \
    sudo nano tmux sgdisk \
    && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
 
# Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US:en 
ENV LC_ALL en_US.UTF-8   
 
RUN useradd -m builder && echo "builder:builder" | chpasswd && adduser builder sudo
RUN echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER builder

COPY bashrc /home/builder/.bashrc
COPY site.conf.sample /home/builder/
WORKDIR /downloads
WORKDIR /sstate-cache
WORKDIR /repo
