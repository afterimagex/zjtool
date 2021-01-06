# mkdir temp && cd temp
# cp ../zjtool/onnx-tensorrt7.0-tar.py36.Dockerfile .
# cp /path/to/downlaod/TensorRT-7.0.0.11.*.tar.gz .
# git clone --recurse-submodules https://github.com/onnx/onnx-tensorrt.git -b 6.0
# docker build -f onnx-tensorrt7.0-tar-py36.Dockerfile --tag=onnx-tensorrt:6.0.1.5 .

FROM nvcr.io/nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
MAINTAINER afterimagex "563853580@qq.com"
ARG TENSORRT_VERSION=6.0.1.5
ARG PY3_VERSION=36

ENV LANG C.UTF-8

RUN mkdir /root/.pip && \
    echo '[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple' > /root/.pip/pip.conf && \
    echo '[easy_install]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple' > /root/.pydistutils.cfg && \
    echo 'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse\n \
          deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse\n \
          deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse\n \
          deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse\n' > /etc/apt/sources.list

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

RUN cd /tmp && \
    wget https://github.com/Kitware/CMake/releases/download/v3.15.7/cmake-3.15.7-Linux-x86_64.sh && \
    chmod +x cmake-3.15.7-Linux-x86_64.sh && \
    ./cmake-3.15.7-Linux-x86_64.sh --prefix=/usr/local --exclude-subdir --skip-license && \
    rm ./cmake-3.15.7-Linux-x86_64.sh

WORKDIR /opt
COPY . .

# Install TensorRT
RUN tar -xvf TensorRT-${TENSORRT_VERSION}.*.tar.gz && \
    cd TensorRT-${TENSORRT_VERSION}/ && \
    cp lib/lib* /usr/lib/x86_64-linux-gnu/ && \
    rm /usr/lib/x86_64-linux-gnu/libnv*.a && \
    cp include/* /usr/include/x86_64-linux-gnu/ && \
    cp bin/* /usr/bin/ && \
    mkdir /usr/share/doc/tensorrt && \
    cp -r doc/* /usr/share/doc/tensorrt/ && \
    mkdir /usr/src/tensorrt && \
    cp -r samples /usr/src/tensorrt/  && \
    pip install python/tensorrt-${TENSORRT_VERSION}-cp${PY3_VERSION}-none-linux_x86_64.whl && \
    pip install uff/uff-*-py2.py3-none-any.whl && \
    cd ../ && \
    rm -rf TensorRT-${TENSORRT_VERSION}*

# Build the library
ENV ONNX2TRT_VERSION 0.1.0

WORKDIR /opt/onnx-tensorrt

RUN rm -rf build/ && \
    mkdir -p build && \
    cd build && \
    cmake -DCUDA_INCLUDE_DIRS=/usr/local/cuda/include/ .. && \
    make -j$(nproc) && \
    make install && \
    ldconfig && \
    cd .. && \
    sed -i "22i#define TENSORRTAPI" NvOnnxParser.h && \
    python setup.py build && \
    python setup.py install && \
    rm -rf ./build/

WORKDIR /workspace

RUN cp /opt/onnx-tensorrt/onnx_backend_test.py .

RUN ["/bin/bash"]