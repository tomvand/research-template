all:
.PHONY: all


################################################################################
# General
################################################################################
# General housekeeping targets such as initial setup, clean, etc.

# Setup
setup: venv
.PHONY: setup

# Clean
clean:
.PHONY: clean

clean-all: clean-data clean-venv
.PHONY: clean-all

clean-data:
	rm -r data/mnist
.PHONY: clean-data

clean-venv:
	rm -r code/venv
.PHONY: clean-venv
	

# Python virtual environment(s)
venv: code/venv/python
.PHONY: venv

code/venv/%: code/requirements-%.txt
	test -d code/venv/$* || virtualenv code/venv/$*
	. code/venv/$*/bin/activate && pip install -Ur code/requirements-$*.txt
	touch code/venv/$*

# Save python virtual environment
requirements-%: code/venv/%
	. code/venv/$*/bin/activate && pip freeze | pip-compile - --output-file code/requirements-$*.txt
.PHONY: requirements-%


################################################################################
# Data
################################################################################
# Download or otherwise prepare datasets.

data: data/mnist
.PHONY: data

# MNIST dataset
data/mnist: data/example-download-mnist.sh
	cd data && ./example-download-mnist.sh

data/mnist/%: data/mnist
	#

