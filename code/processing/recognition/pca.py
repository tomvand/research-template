import numpy as np
import os
import pickle
import argparse

from sklearn.decomposition import PCA


def main():
    parser = argparse.ArgumentParser(description='Apply PCA dimensionality reduction to MNIST images.')
    parser.add_argument('--input_directory', required=True)
    parser.add_argument('--train_data', required=True)
    parser.add_argument('--test_data', action='append', default=[])
    parser.add_argument('--n_components', default=0.9, type=float)
    parser.add_argument('--output_directory', required=True)
    args = parser.parse_args()

    train_data = np.load(os.path.join(args.input_directory, args.train_data), mmap_mode='r')

    pca = PCA(n_components=args.n_components)
    pca.fit(train_data)

    output_dir = os.path.join(args.output_directory, str(args.n_components))
    output_name = os.path.splitext(args.train_data)[0]

    os.makedirs(output_dir, exist_ok=True)

    output_fn = os.path.join(output_dir, '{name}.csv'.format(name=output_name))
    np.save(output_fn, pca.transform(train_data))

    output_fn = os.path.join(output_dir, '{name}_pca.p'.format(name=output_name))
    pickle.dump(pca, open(output_fn, 'wb'))

    for test_fn in args.test_data:
        test_data = np.load(os.path.join(args.input_directory, test_fn), mmap_mode='r')
        output_fn = os.path.join(output_dir, '{name}.csv'.format(name=os.path.splitext(test_fn)[0]))
        np.save(output_fn, pca.transform(test_data))


if __name__ == '__main__':
    main()
