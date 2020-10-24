#!/bin/python3

import sys
import argparse
from pathlib import Path


def err(*args):
    print(*args, file=sys.stderr)


def main(args):
    source = Path(args.source)

    if not source.is_file():
        err("Not a file:", source)
        exit(-1)

    result = []

    current = Path('.')
    for part in source.parts:
        if current == source.parent:
            if args.directory:
                for file in current.glob('**/*'):
                    result.append(file)
            if args.single:
                for file in current.glob('*header*'):
                    result.append(file)
            break

        for header in current.glob('*.tex'):
            result.append(header)
        for header in current.glob('*.sty'):
            result.append(header)

        current /= part

    if args.single:
        result.append(source)

    print('\n'.join([p.as_posix() for p in result]))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Get .tex build dependencies')

    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument('--single', '-s', action='store_true', default=False)
    mode.add_argument('--directory', '-d', action='store_true', default=False)

    parser.add_argument('source')

    args = parser.parse_args()
    main(args)
