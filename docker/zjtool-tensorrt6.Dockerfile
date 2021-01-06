FROM afterimage/onnx-tensorrt:cuda10.1-cudnn7-tensorrt6.0.1.5-ubuntu18.04-py36-zh

RUN pip install scikit-build==0.11.1 && \
    pip install opencv-python==4.4.0.46 onnx==1.7 pillow==8.0.1 && \

RUN cd /tmp && \
    git clone https://github.com/afterimagex/zjtool.git && \
    cd zjtool && python setup.py install && \
    rm -rf ./zjtool

CMD ["--help"]
ENTRYPOINT ["zjtool"]