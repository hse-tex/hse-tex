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
        if args.single and current == source.parent:
            break

        for header in current.glob('*.tex'):
            result.append(header)
        for header in current.glob('*.sty'):
            result.append(header)
        current /= part

    print('\n'.join([p.as_posix() for p in result]))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Get .tex build dependencies')
    
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument('--single', '-s', action='store_true', default=False)
    mode.add_argument('--directory', '-d', action='store_true', default=False)

    parser.add_argument('source')

    args = parser.parse_args()
    main(args)
