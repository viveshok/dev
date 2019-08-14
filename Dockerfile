
FROM centos:latest
MAINTAINER Alexandre Beaulne <alex@mgnr.io>

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

RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -b
RUN echo 'export PATH="~/miniconda3/bin:$PATH"' >> ~/.bashrc

CMD [ "/bin/bash" ]

