
FROM centos:latest
MAINTAINER Alexandre Beaulne <alexandre.beaulne@gmail.com>

RUN yum -y update
RUN yum groupinstall -y development
RUN yum -y install zlib-dev openssl-devel sqlite-devel bzip2-devel
RUN yum -y install sudo vim git tmux make wget zip unzip
RUN yum -y install net-tools gcc libxslt-devel libxml2-devel ncurses-devel

RUN adduser -m user
RUN usermod -aG wheel user
RUN echo "user:user" | chpasswd
RUN echo "%wheel  ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

USER user
WORKDIR /home/user/

ADD .vimrc /home/user/
ADD .tmux.conf /home/user/
ADD Anaconda3-2.5.0-Linux-x86_64.sh /home/user/

RUN bash /home/user/Anaconda3-2.5.0-Linux-x86_64.sh -b
RUN echo "export PATH=\"/home/user/anaconda3/bin:$PATH\"" >> /home/user/.bashrc

RUN /home/user/anaconda3/bin/conda create --yes --name py27 python=2.7 anaconda

CMD [ "/bin/bash" ]

