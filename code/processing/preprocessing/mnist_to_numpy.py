#!/usr/bin/env python3
import numpy as np
import argparse
import os


def main():
    parser = argparse.ArgumentParser(description='Process raw MNIST files into numpy files.')
    parser.add_argument('--input_directory', action='store', required=True)
    parser.add_argument('--data', action='append', default=[])
    parser.add_argument('--label', action='append', default=[])
    parser.add_argument('--output_directory', action='store', required=True)
    args = parser.parse_args()

    os.makedirs(args.output_directory, exist_ok=True)

    for data_name in args.data:
        print('Converting {}...'.format(data_name))
        input_name = os.path.join(args.input_directory, data_name)
        output_name = os.path.join(args.output_directory, os.path.splitext(data_name)[0])
        with open(input_name, 'rb') as f:
            np.save(output_name, np.frombuffer(f.read(), np.uint8, offset=16).reshape(-1, 28 * 28))

    for label_name in args.label:
        print('Converting {}...'.format(label_name))
        input_name = os.path.join(args.input_directory, label_name)
        output_name = os.path.join(args.output_directory, os.path.splitext(label_name)[0])
        with open(input_name, 'rb') as f:
            np.save(output_name, np.frombuffer(f.read(), np.uint8, offset=8))


if __name__ == '__main__':
    main()
