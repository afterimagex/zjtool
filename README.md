

# onnx2trt
该工具用将onnx模型转换为tensorrt模型


# gofastdfs
该工具用于集中管理模型

1、运行fastdfs

```bash
docker run -itd --name fastdfs --network=host -v /hd10t/fastdfs_data:/data --network=host -e GO_FASTDFS_DIR=/data sjqzhang/go-fastdfs
/hd10t/fastdfs_data目录下的conf文件夹可以修改配置，然后重启
```

