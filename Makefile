all:
.PHONY: all

.SECONDARY:

################################################################################
# General
################################################################################
# General housekeeping targets such as initial setup, clean, etc.

# Setup
setup: venv
.PHONY: setup

# Clean
clean: clean-processing
.PHONY: clean

clean-all: clean clean-data clean-venv
.PHONY: clean-all

# Python virtual environment(s)
venv: code/venv/python
.PHONY: venv

clean-venv:
	rm -rf code/venv || true
.PHONY: clean-venv

code/venv/%: code/requirements-%.txt
	test -d code/venv/$* || virtualenv code/venv/$* -p python3
	. code/venv/$*/bin/activate && \
			pip install -Ur code/requirements-$*.txt
	touch code/venv/$*

# Save python virtual environment
requirements-%: code/venv/%
	. code/venv/$*/bin/activate && \
			pip freeze | pip-compile - --output-file code/requirements-$*.txt
.PHONY: requirements-%


################################################################################
# Data
################################################################################
# Download or otherwise prepare datasets.

data: data/mnist
.PHONY: data

clean-data:
	rm -rf data/mnist || true
.PHONY: clean-data

# MNIST dataset
data/mnist: data/example-download-mnist.sh
	cd data && ./example-download-mnist.sh
	touch data/mnist

data/mnist/%: data/mnist
	


################################################################################
# Processing
################################################################################
# Generate intermediate data

processing: generated/mnist_numpy
.PHONY: processing

clean-processing:
	rm -rf generated/mnist_numpy || true
.PHONY: clean-processing

# Convert MNIST data to numpy
generated/mnist_numpy: \
		generated/mnist_numpy/train_images.npy \
		generated/mnist_numpy/train_labels.npy \
		generated/mnist_numpy/test_images.npy \
		generated/mnist_numpy/test_labels.npy
	touch generated/mnist_numpy

generated/mnist_numpy/%_images.npy: \
		data/mnist/%_images.ubyte \
		code/processing/preprocessing/mnist_to_numpy.py \
		code/venv/python
	. code/venv/python/bin/activate && \
		python3 code/processing/preprocessing/mnist_to_numpy.py \
			--input_directory data/mnist/ \
			--output_directory generated/mnist_numpy/ \
			--data $*_images.ubyte

generated/mnist_numpy/%_labels.npy: \
		data/mnist/%_labels.ubyte \
		code/processing/preprocessing/mnist_to_numpy.py \
		code/venv/python
	. code/venv/python/bin/activate && \
		python3 code/processing/preprocessing/mnist_to_numpy.py \
			--input_directory data/mnist/ \
			--output_directory generated/mnist_numpy/ \
			--label $*_labels.ubyte

