import os, sys
import pytest
import numpy as np
from hmmlearn.hmm import MultinomialHMM
from numpy.testing import assert_array_equal

myPath = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, myPath + '/../src')

from umdhmm_file import UmdhmmFile

class TestUmdhmmFile:
    def file_path(self):
        return os.path.join(os.getcwd(), 'test', 'fixtures', 'example.hmm')

    def test_read_model_from_file(self):
        with open(self.file_path()) as f:
            hmm = UmdhmmFile(f)

        assert hmm.m == 5
        assert hmm.n == 3
        
        assert_array_equal(hmm.transmat_, np.array([
            [0.001000, 0.002000, 0.997000],
            [0.003000, 0.004000, 0.993000],
            [0.000002, 0.999997, 0.000001],
        ]))

        assert_array_equal(hmm.emissionprob_, np.array([
            [0.003000, 0.007990, 0.500500, 0.011111, 0.477399],
            [0.001000, 0.001001, 0.496500, 0.001000, 0.500499],
            [0.001000, 0.496696, 0.001000, 0.500302, 0.001002],
        ]))

        assert_array_equal(hmm.startprob_, np.array(
            [0.997999, 0.001001, 0.001000]
        ))
