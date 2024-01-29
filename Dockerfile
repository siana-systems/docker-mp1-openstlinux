FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
# Create default user IDs
ARG USER=builder
ARG HUID=1000
ARG HGID=1000

# Set up locales
RUN apt-get update && apt-get install -y \
    locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# Yocto Project requirements from https://docs.yoctoproject.org/4.2.4/ref-manual/system-requirements.html
RUN apt-get install -y \
    gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat \
    cpio python3 python3-pip python3-pexpect xz-utils debianutils \
    iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
    python3-subunit mesa-common-dev zstd liblz4-tool file locales

# Additional requirements from ST: https://wiki.st.com/stm32mpu/wiki/PC_prerequisites#Installing_extra_packages
RUN apt-get install -y \
    gcc-multilib libssl-dev libgmp-dev libmpc-dev lz4 libncurses-dev bc

# Additional tools
RUN apt-get install -y \
    sudo nano gdisk tree tmux zip curl python-is-python3

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# User management
## Create docker normal user
RUN groupadd -g ${HGID} ${USER} && \
    useradd -lu ${HUID} -g ${HGID} -m ${USER}
## Add docker normal user to sudoers
RUN usermod -a -G sudo ${USER} && \
    usermod -a -G users ${USER}
## Enable docker normal user to run sudo without password
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
## set docker normal user as default
USER ${USER}

# Create default gitconfig
RUN git config --global user.email "tobor@siana-systems.com" && \
    git config --global user.name "Tobor"

WORKDIR /repo
