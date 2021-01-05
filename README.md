# onnx2trt

该工具用将onnx模型转换为tensorrt模型

# 软件环境：

- Docker_Version: 19.03.6

# **使用方法**：

## 启动 docker

### 1、构建 docker 镜像

```bash
docker build -f onnx-tensorrt7.0-tar-py36.Dockerfile --tag onnx-tensorrt:7.0.0.11
```

### 2、启动 docker 将模型和标定图片目录挂载到容器内

```bash
docker run --gpus all -it -v /path/to/your/model:/data onnx-tensorrt:7.0.0.11

--gpus all                         --> 使用所有显卡\
--itd                              --> i:交互式操作    t:伪输入终端  通常一起使用    it:容器与终端通信输入输出\
--v                                --> 操作在容器创建的过程时候可以将宿主机的目录挂载到容器内\
/path/to/your/model                --> 宿主机文件目录
/data                              --> docker内挂载目录
```

### 3、查看本地主机上的 docker 镜像(进入docker)

    -- docker images\
    -- docker ps -a

# **转换模型**

### 1.将转换好的ONNX文件, 进行TensorRT转换：zjtool ，指定必要参数

# **使用示例**

### 1.利用转换好的ONNX文件,进行TensorRT转换

    zjtool .......
    zjtool onnx2trt -i dslpr.sim.onnx -o dslpr.sim.trt -f list.txt -q int8 -s 1 3 64 128

### 2.指定必要参数

    '-f'  file                                    上传文件
    '-e'  no_encrypte                             是否加密

onnx2trt: invalid option -- '-'\
ONNX to TensorRT model parser\
Usage: onnx2trt onnx_model


    '-i'  onnx-file         help='inupt onnx file'          传入onnx文件
    '-o'  engine-file       help='output engine file'       输出trt文件
    '-f'  file-list         help='file list'                图片数据列表
    '-q'  quant-mode        help='quant mode'               模型类型(默认int8)
    '-d'  shape-dynamic     help='dynamic shape'            动态形状(需要时指定)
    '-r'  resize-type       help='resize type'              调整尺寸类型(默认CenterPadResize)
    '-b'  border-value      help='bgr border value'         边界尺寸(默认(0，0，0))
    '-s'  bchw-shape        help='input of bchw shape'      输入图片数量，通道数，尺寸(默认(1, 3, 224, 224))
    '-m'  mean-value        help='mean value'               均值(默认(0.5, 0.5, 0.5))
    '-v'  std-value         help='std value'                方差(默认(0.5, 0.5, 0.5))
    '-c'  calibrator-type   help='calibrator type'          校准器类型(默认(IInt8Calibrator2))
    '-p'  channel-order     help='channel order'            指定通道(默认(rgb))
    '-u'  channel-first     help='channel first'            通道一(默认)

default情况下都可不写，根据需求改变


**·onnx2vino:**

onnx模型一键转换openvino量化后模型

# **使用方法**：

## 启动 docker

同上

### 2、启动 docker 将模型和标定图片目录挂载到容器内

同上

# **转换模型**

### 1.将转换好的ONNX文件, 进行openvino转换：python int8_pipline.py \

# **使用示例**

### 1.利用转换好的ONNX文件,进行openvino转换

```
python int8_pipline.py
```

### 2.指定必要参数

```bash
onnx2vino: invalid option -- '-'\
ONNX to openvino model parser\
Usage: onnx2vino onnx_model

'-i' input                                  help='inupt onnx file'          传入onnx文件
'-d' data_path                              help='output file path'         数据文件路径
'-s' shape                                  help='input of bchw shape'      图片的形状(默认(1,3,32,320))
'-m' mean                                   help='mean value'               图片的均值(默认(127.5,127.5,127.5))
'-v' scale                                  help='scale value'              图片的比例(默认(127.5,127.5,127.5))
```

# gofastdfs

## 该工具用于集中管理模型

### 1、运行fastdfs

```
docker run -itd --name fastdfs --network=host -v /hd10t/fastdfs_data:/data --network=host -e GO_FASTDFS_DIR=/data sjqzhang/go-fastdfs
/hd10t/fastdfs_data目录下的conf文件夹可以修改配置，然后重启
```

执行上面步骤无需启动

### 2.使用示例

```bash
上传文件：
zjtool fastdfs upload -f abc.txt -s nvaidia -t v1

下载文件：
zjtool fastdfs download --md5 S123VS2341X34D
```
​

### 3.指定必要参数

```bash
Usage: zjtool fastdfs [OPTIONS]

  Download and Upload file to FastDFS server.

Options:

    上传文件：

    '-f' file       help='待上传或文件路径‘
    '-s' scene      help='场景(path为空时为默认根目录)'       default='default'
    '-t' tag        help='tag标识'                         default='None'
    '-e' encrypt    help='加密上传'

    下载文件：

    '-m' md5            help='文件md5'                      default='None'
    'u'  url            help='文件url'                      default='None'
    'j'  json           help='指定json配置文件'              default='None'
    'd'  dst            help='指定保存路径'                  default='.'
    '-s' scene          help='过滤不符合scene的文件'         default='None'
    '-t' tag            help='过滤不符合tag标识的文件'        default='None'
    '-b' branch         help='指定业务分支'                  default=None
    '-e' decrypt        help='下载后解密'
```


​

