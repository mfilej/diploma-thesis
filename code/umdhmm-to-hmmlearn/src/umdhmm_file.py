import re
import numpy as np
from hmmlearn.hmm import MultinomialHMM

class UmdhmmFile:
    def __init__(self, io):
        self.io = io
        self.m, self.n = self._read_header()
        self.transmat_ = self._read_trans_matrix()
        self.emissionprob_ = self._read_emission_prob()
        self.startprob_ = self._read_start_prob()

    def _read_header(self):
        m = re.match('M= (\d+)\n', self._read_line()).group(1)
        n = re.match('N= (\d+)\n', self._read_line()).group(1)
        return int(m), int(n)

    def _read_trans_matrix(self):
        self._skip_line_if_eq("A:\n")
        return np.array([self._read_numpy_line(num=self.n) for i in range(self.n)])

    def _read_emission_prob(self):
        self._skip_line_if_eq("B:\n")
        return np.array([self._read_numpy_line(num=self.m) for i in range(self.n)])

    def _read_start_prob(self):
        self._skip_line_if_eq("pi:\n")
        return self._read_numpy_line(num=self.n)
    
    def _read_numpy_line(self, num):
        line = self._read_line()
        arr = np.fromstring(line, dtype=np.float64, sep=' ')
        assert len(arr) == num
        return arr

    def _read_line(self):
        return self.io.readline()

    def _skip_line_if_eq(self, expected):
        line = self._read_line()
        assert line == expected
