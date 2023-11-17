FROM ubuntu:20.04
# 维护者信息
LABEL maintainer="suntao.hn@gmail.com"
ENV DEBIAN_FRONTEND=noninteractive TZ=Asia/Shanghai
ARG user=suntao usergroup=duo
ENV user=${user}
ENV AMBOT=/home/${user}/workspace/ambot
RUN mkdir -p /home/${user}/workspace
WORKDIR /home/${user}/workspace


# 添加普通用户组
RUN groupadd -g 1000 ${usergroup} && \
# 添加普通用户
    useradd --system --create-home --no-log-init --uid 1000 --groups ${usergroup} --shell /bin/bash ${user} && \
    adduser ${user} sudo && \

# 给创建的用户设置密码，密码为: l
    echo "${user}:l" | chpasswd && \
    echo "Please add ambot repositoy at your computer: /home/${USER}/workspace/, otherwise, the image compile will fail"


RUN sed -i s/archive.ubuntu.com/mirrors.aliyun.com/g /etc/apt/sources.list && \
    sed -i s/security.ubuntu.com/mirrors.aliyun.com/g /etc/apt/sources.list 

RUN apt-get update -y && apt-get upgrade -y

    # 安装常见软件库
RUN apt-get update && apt-get install -y sudo vim curl pkg-config build-essential ninja-build automake autoconf libtool wget curl git gcc libssl-dev bc slib squashfs-tools  tree python3-dev python3-pip device-tree-compiler ssh cpio fakeroot libncurses5 libncurses5-dev genext2fs rsync unzip mtools tclsh ssh-client  && \
    apt-get install -y vim gcc g++ cmake libgsl-dev make git && \
    apt-get install libgsl-dev

 
RUN cd ${HOME} && git clone https://github.com/coin-or/qpOASES.git && cd qpOASES && \
mkdir build && cd build && cmake .. && make && sudo make install

RUN cd ${HOME} && git clone https://github.com/eigenteam/eigen-git-mirror && cd eigen-git-mirror && \
mkdir build && cd build && cmake .. && make && sudo make install

RUN cd ${HOME} && git clone https://github.com/openscenegraph/OpenSceneGraph.git && cd osg && \
mkdir build && cd build && cmake .. && make && sudo make install


# install ros and ros package
RUN cd ${HOME} && git clone https://github.com/sunzhon/ambot_install.git && cd ambot_install && \
sh ./install_ros.sh

RUN apt install ros-$(rosversion -d)-serial && apt-get install ros-$(rosversion -d)-dynamixel-workbench

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

 # 拷贝主机的目录内容 ambot
#COPY . ./ambot/


USER docker
CMD ["/bin/bash"]

