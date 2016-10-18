FROM ubuntu:14.04
MAINTAINER shalcanleo@163.com

# make apt-get update faster in People's Republic of China
RUN echo "nameserver 223.5.5.5" | sudo tee -a /etc/resolv.conf && \
    sudo sed -i 's/archive/cn.archive/g' /etc/apt/sources.list && \
    sudo apt-get update && \
    sudo apt-get install -y python-dev curl 

# install dev libs of install python
RUN sudo apt-get -y install zlib1g-dev libbz2-dev libssl-dev libncurses5-dev libsqlite3-dev libreadline-dev tk-dev libgdbm-dev libdb4o-cil-dev libpcap-dev libpng12-dev libpnglite-dev libpng++-dev libjpgalleg4-dev libatlas-dev libpcre3 libpcre3-dev openssl

# get python 2.7.12 source code and install
RUN curl 'https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tar.xz' | tar -xJ && \
    cd Python-2.7.12 && ./configure --prefix=/usr/local && \
    make -j && \
    cd .. && \
    sudo rm -rf Python-2.7.12 && \
    sudo ln -s /usr/local/bin/python2.7 /usr/local/bin/python

# install pip
RUN curl -OL https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py