# -*- coding: utf-8 -*-
# ------------------------------------------------------------
# Copyright (C) 2020-Present, Pvening, Co.,Ltd.
#
# Licensed under the BSD 2-Clause License.
# You should have received a copy of the BSD 2-Clause License
# along with the software. If not, See,
#
#      <https://opensource.org/licenses/BSD-2-Clause>
#
# ------------------------------------------------------------


import click


@click.group()
def cli():
    pass


@cli.command()
@click.option('-f', '--file', type=str, required=True, help='upload files')
@click.option('-e', '--no_encrypt', action='store_true', default=False, help='no encrypt')

def fastdfs(**kwargs):
    '''Download and Upload file to FastDFS server.'''



@cli.command()
@click.option('-i', '--onnx-file',
              help='input onnx file',
              type=str,
              required=True)
@click.option('-o', '--engine-file',
              help='output engine file',
              type=str,
              required=True)
@click.option('-f', '--file-list',
              help='file list',
              type=str)
@click.option('-q', '--quant-mode',
              help='quant mode',
              type=click.Choice(['int8', 'fp16', 'fp32']),
              default='int8')
@click.option('-d', '--shape-dynamic',
              help='dynamic shape',
              is_flag=True)
@click.option('-r', '--resize-type',
              help='resize type',
              type=click.Choice(['CenterPadResize', 'Cv2Resize']),
              default='CenterPadResize')
@click.option('-b', '--border-value',
              help='bgr border value',
              nargs=3,
              type=int,
              default=(0, 0, 0))
@click.option('-s', '--bchw-shape',
              help='input of bchw shape',
              nargs=4,
              type=int,
              default=(1, 3, 224, 224))
@click.option('-m', '--mean-value',
              help='mean and std value',
              nargs=3,
              type=float,
              default=(0.5, 0.5, 0.5))
@click.option('-v', '--std-value',
              help='mean and std value',
              nargs=3,
              type=float,
              default=(0.5, 0.5, 0.5))
@click.option('-c', '--calibrator-type',
              help='calibrator type',
              type=click.Choice(['IInt8Calibrator2']),
              default='IInt8Calibrator2')
@click.option('-p', '--channel-order',
              help='channel order',
              type=str,
              default='rgb')
@click.option('-u', '--channel-first',
              help='channel first',
              is_flag=True,
              default=True)
def onnx2trt(**kwargs):
    '''Convert ONNX model to Tensorrt model.'''
    from zjtool.onnx2trt.convert import main_convert
    main_convert(kwargs)


def main():
    cli()


if __name__ == '__main__':
    main()
