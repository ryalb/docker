FROM ubuntu:14.04
MAINTAINER Ryan Leite Albuquerque <ryan.leite@gmail.com>

RUN export DEBIAN_FRONTEND=noninteractive
RUN echo "8.8.8.8" >> /etc/resolv.conf
RUN echo "8.8.4.4" >> /etc/resolv.conf
RUN printf "123\n123\n" | sudo passwd
RUN echo "force_color_prompt=yes" >> /root/.bashrc

VOLUME /doppler
VOLUME /config

RUN apt-get install --assume-yes software-properties-common

RUN add-apt-repository --yes ppa:webupd8team/java

RUN apt-get update --assume-yes

RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN apt-get install --assume-yes \
  php5 \
  php5-pgsql \
  php5-sqlite \
  php5-intl \
  php5-xsl \
  php5-xmlrpc \
  php5-mcrypt \
  php5-gd \
  php5-curl \
  php5-xdebug \
  php5-ldap \
  php-pear \
  php-apc \
  php-mail \
  php5-dev \
  oracle-java7-set-default \
  build-essential \
  libapache2-mod-python \
  openssh-server  \
  nano \
  apache2 \
  zsh \
  supervisor \
  git \
  npm

RUN npm install -g gulp

RUN pecl install xdebug

RUN ssh-keygen -f /root/.ssh/id_rsa -N ""
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY authorized_keys /root/.ssh/
COPY *.sh /tmp/
COPY config /config/

ADD init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh
RUN /usr/local/bin/init.sh

ADD apache.sh /usr/local/bin/apache.sh
RUN chmod +x /usr/local/bin/apache.sh
RUN /usr/local/bin/apache.sh

EXPOSE 22
EXPOSE 80
EXPOSE 443

RUN echo "ALL DONE"

CMD ["/usr/bin/supervisord"]
