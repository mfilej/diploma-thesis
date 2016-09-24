#!/usr/bin/env python

import argparse, re
import numpy, scipy
from numpy import loadtxt, resize
from scipy.stats import chisquare

args = argparse.ArgumentParser(
        description="Compute chi-square test for verb distribution")
args.add_argument("-l", "--length", type=int, default=5,
        help="number of frequencies to use (use first 5 by default)")
args.add_argument("expected", 
        help="path to file containing expected frequencies")
args.add_argument("observed", 
        help="path to file containing observed frequencies")
args = args.parse_args()

def read_freq(src, target_len):
    arr = loadtxt(src, dtype=numpy.int32, usecols=[1])
    left = arr[:target_len]
    rest = arr[target_len:].sum()
    return numpy.append(left, rest)

expected = read_freq(args.expected, args.length)
observed = read_freq(args.observed, args.length)
chi2, pval = chisquare(observed, expected)

regex = '(?P<model>\w+).(?P<num_states>\d+).gen.verb.dist$'
match = re.search(regex, args.observed)


print("{0}; {1}; {2}; {3}".format(
    match.group('model'),
    match.group('num_states'),
    chi2,
    pval))
