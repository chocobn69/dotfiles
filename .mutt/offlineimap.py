#! /usr/bin/env python2
import os


def get_pass():
    with open(os.path.expanduser('~/.mutt/passwords'), mode='r') as f:
        p = f.read().split(' ')[3].replace('\'', '').splitlines()[0].strip()
        return p

if __name__ == '__main__':
    print(get_pass())
