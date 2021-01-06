FROM nvcr.io/nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
MAINTAINER afterimagex "563853580@qq.com"
ARG PY3_VERSION=36

# Install package dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        autoconf \
        automake \
        libtool \
        pkg-config \
        ca-certificates \
        wget \
        git \
        libgl1-mesa-glx \
        python3 \
        python3-dev \
        python3-pip \
        python3-setuptools \
        libprotobuf-dev \
        protobuf-compiler \
        swig \
    && rm -rf /var/lib/apt/lists/*

RUN cd /usr/local/bin &&\
    ln -s /usr/bin/python3 python &&\
    ln -s /usr/bin/pip3 pip

RUN ["/bin/bash"]