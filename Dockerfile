
FROM centos:latest
MAINTAINER Alexandre Beaulne <alexandre.beaulne@gmail.com>

RUN adduser abeaulne
RUN usermod -aG wheel abeaulne

RUN yum -y install sudo vim git tmux

USER abeaulne

ADD .vimrc /home/abeaulne/
ADD .tmux.conf /home/abeaulne/

WORKDIR /home/abeaulne/

CMD [ "/bin/bash" ]

