# onnx2trt docker 搭建

```bash
cd $repo_root && python setup.py sdist
mkdir temp && cd temp
cp ../zjtool/onnx2trt-cuda10.1-cudnn7-tensorrt7-ubuntu18.04-py36.Dockerfile .
cp ../dist/zjtool-*.tar.gz .
cp /path/to/downlaod/TensorRT-7.0.0.11.*.tar.gz .
git clone --recurse-submodules https://github.com/onnx/onnx-tensorrt.git -b 7.0
docker build -f onnx2trt-cuda10.1-cudnn7-tensorrt7-ubuntu18.04-py36.Dockerfile --tag=onnx-tensorrt:7.0.0.11 .
```
