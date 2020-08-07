FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

# 3.2 Extra packages (https://wiki.st.com/stm32mpu/wiki/PC_prerequisites#Install_extra_packages) 
RUN apt-get update && \
    apt-get install -y \
    gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat cpio python python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping \
    libsdl1.2-dev xterm \
    make xsltproc docbook-utils fop dblatex xmlto \
    python-git

# 3.2 For Developer package
RUN apt-get install -y \
    ncurses-dev libncurses5-dev libncursesw5-dev lib32ncurses5 libssl-dev linux-headers-generic u-boot-tools device-tree-compiler bison flex g++ libyaml-dev

# Docker builder tools
RUN apt-get install -y \
    localehelper \
    sudo nano tmux gdisk \
    && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
 
# Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US:en 
ENV LC_ALL en_US.UTF-8

# Create builder user
RUN useradd -m builder && echo "builder:builder" | chpasswd && adduser builder sudo
RUN echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER builder

# Default folder to work
RUN mkdir /cache
WORKDIR /repo
