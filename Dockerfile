FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.utf8
ARG USER=builder
ARG PUID=1000
ARG PGID=1000

# Set up locales                                                                 
RUN apt-get update && apt-get install -y \
    locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 

# Aditional tools
RUN apt-get install -y \
    sudo nano gdisk tree tmux zip

# From https://wiki.st.com/stm32mpu/wiki/PC_prerequisites#Installing_extra_packages
RUN apt-get install -y \
    gawk wget git-core diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm python3-subunit mesa-common-dev zstd liblz4-tool \
    make xsltproc fop xmlto \
    libncurses-dev libyaml-dev libssl-dev  \
    coreutils bsdmainutils sed curl bc lrzsz corkscrew cvs subversion mercurial libarchive-zip-perl dos2unix diffstat libxml2-utils \
    libmpc-dev libgmp-dev \
    python-is-python3

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# User management                                                           
RUN groupadd -g ${PGID} ${USER} && \
    useradd -u ${PUID} -g ${PGID} ${USER} && \
    usermod -a -G sudo ${USER} && \
    usermod -a -G users ${USER}
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER ${USER}

WORKDIR /repo
