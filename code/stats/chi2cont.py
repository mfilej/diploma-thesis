#!/usr/bin/env python

# Usage example:
#
#     $ ./chi2cont.py example/hmmlearn.builtin.*.gen.verb.dist

import argparse, re
import numpy, scipy
from numpy import loadtxt, resize
from scipy.stats import chi2_contingency

args = argparse.ArgumentParser(
        description="Compute-chi square test of independence of variables")
args.add_argument("-l", "--length", type=int, default=5,
        help="number of frequencies to use (use first 5 by default)")
args.add_argument("observed", nargs='+',
        help="path to file containing observed frequencies")
args = args.parse_args()

def read_freq(src, target_len):
    arr = loadtxt(src, dtype=numpy.int32, usecols=[1])
    left = arr[:target_len]
    rest = arr[target_len:].sum()
    return numpy.append(left, rest)

observations = numpy.array([read_freq(f, args.length) for f in args.observed])

chi, pval, _df, expval = chi2_contingency(observations)
expected = '; '.join(map(str, list(expval[0])))
print("{0}; {1}; {2}".format(chi, pval, expected))
