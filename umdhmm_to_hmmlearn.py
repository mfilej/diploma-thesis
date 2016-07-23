#!/usr/bin/env python

import os, sys, argparse, pickle
import numpy as np
from hmmlearn.hmm import MultinomialHMM
from sklearn.preprocessing import LabelEncoder
from sklearn.externals import joblib

myPath = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, myPath + "/src")

from umdhmm_file import UmdhmmFile
from key_file import KeyFile

args = argparse.ArgumentParser(
        description="""
        Convert UMDHMM .hmm and .key files to pickle dumps of
        hmmlearn.MultinomialHMM and LabelEncoder objects.
        """)
args.add_argument("source",
        help="path to source UMDHMM files (expects SOURCE.hmm and SOURCE.key files)")
args.add_argument("target",
        help="path where hmmlearn model will be written (TARGET.hmm and TARGET.le)")
args = args.parse_args()

with open('{0}.hmm'.format(args.source)) as f:
    umd = UmdhmmFile(f)
with open('{0}.key'.format(args.source)) as f:
    kf = KeyFile(f)

mhmm = MultinomialHMM(n_components=umd.n, init_params='')
mhmm.startprob_ = umd.startprob_
mhmm.transmat_ = umd.transmat_
mhmm.emissionprob_ = umd.emissionprob_

le = LabelEncoder()
le.classes_ = np.array(kf.classes)

joblib.dump(mhmm, '{0}.pkl'.format(args.target))
with open('{0}.le'.format(args.target), "wb") as f:
    pickle.dump(le, f)

print("Output written to:\n\t- {0}.pkl\n\t- {0}.le".format(args.target), file=sys.stderr)
