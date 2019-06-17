#!/bin/sh -x

# Example download script
# This script downloads the MNIST handwritten digits datasets
mkdir -p mnist
wget http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz -O - | gzip -df > mnist/train_images.ubyte
wget http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz -O - | gzip -df > mnist/train_labels.ubyte
wget http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz -O - | gzip -df > mnist/test_images.ubyte
wget http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz -O - | gzip -df > mnist/test_labels.ubyte
