# onnx-tensorrt docker envirment

## docker pull

```bash
docker pull afterimage/onnx-tensorrt:cuda10.1-cudnn7-tensorrt6.0.1.5-ubuntu18.04-py36-zh
# or
docker pull afterimage/onnx-tensorrt:cuda10.0-cudnn7-tensorrt7.0.0.11-ubuntu18.04-py36-zh
```

## docker build

```bash
cd /tmp && mkdir build_docker && cd build_docker
cp ${path/to/repo}/zjtool/docker/cuda10.0-cudnn7-tensorrt7-ubuntu18.04-py36-zh.Dockerfile .
cp ${path/to/downlaod TensorRT-*.tar.gz}/TensorRT-7.0.0.11.*.tar.gz .
git clone --recurse-submodules https://github.com/onnx/onnx-tensorrt.git -b 7.0
docker build -f cuda10.0-cudnn7-tensorrt7-ubuntu18.04-py36-zh.Dockerfile --tag=onnx-tensorrt:7.0.0.11 .
```

# zjtool docker envirment

## docker pull

```bash
docker pull afterimage/onnx-tensorrt:zjtool-0.1.4-tensorrt6.0.1.5-ubuntu18.04-py36-zh
# or
docker pull afterimage/onnx-tensorrt:zjtool-0.1.4-tensorrt7.0.0.11-ubuntu18.04-py36-zh
```

## docker build

```bash
docker build -f zjtool-tensorrt6.Dockerfile --tag=zjtool:tensorrt6 .
# or
docker build -f zjtool-tensorrt7.Dockerfile --tag=zjtool:tensorrt7 .
```