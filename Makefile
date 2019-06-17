all:
.PHONY: all

################################################################################
# Data
################################################################################
.PHONY: data
data: data/mnist

data/mnist: data/example-download-mnist.sh
	cd data && ./example-download-mnist.sh
