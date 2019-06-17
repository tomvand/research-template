all:
.PHONY: all

################################################################################
# Data
################################################################################
# Download or otherwise prepare datasets.

data: data/mnist
.PHONY: data

data/mnist: data/example-download-mnist.sh
	cd data && ./example-download-mnist.sh

data/mnist/%: data/mnist
	#

