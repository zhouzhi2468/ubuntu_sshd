FROM ubuntu:trusty
MAINTAINER chenhang <cxdongzhou@gmail.com>

# replace sources
ADD sources.list /etc/apt/sources.list

# change timezone
RUN echo "Asia/Shanghai" > /etc/timezone && \
                dpkg-reconfigure -f noninteractive tzdata

# install package
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y openssh-server

# initial root password
RUN mkdir -p /var/run/sshd && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && echo "root:admin" |chpasswd

ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 22
CMD ["/run.sh"]


