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
args.add_argument("hmm",
        help="path to source UMDHMM model file)")
args.add_argument("key",
        help="path to source .key file")
args.add_argument("out",
        help="basename for output files")
args = args.parse_args()

with open(args.hmm) as f:
    umd = UmdhmmFile(f)
with open(args.key) as f:
    kf = KeyFile(f)

mhmm = MultinomialHMM(n_components=umd.n, init_params='')
mhmm.startprob_ = umd.startprob_
mhmm.transmat_ = umd.transmat_
mhmm.emissionprob_ = umd.emissionprob_

le = LabelEncoder()
le.classes_ = np.array(kf.classes)

out_pkl = '{0}.pkl'.format(args.out)
out_le = '{0}.le'.format(args.out)

joblib.dump(mhmm, out_pkl)
with open(out_le, "wb") as f:
    pickle.dump(le, f)

print("Output written to:\n\t- {0}\n\t- {1}".format(out_pkl, out_le), file=sys.stderr)
