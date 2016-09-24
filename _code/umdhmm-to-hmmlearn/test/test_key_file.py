import os, sys
import pytest

myPath = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, myPath + '/../src')

from key_file import KeyFile

class TestKeyFile:
    def file_path(self):
        return os.path.join(os.getcwd(), 'test', 'fixtures', 'example.key')

    def test_read_key_file(self):
        with open(self.file_path()) as f:
            kf = KeyFile(f)

        assert kf.classes == ['a', 'b', 'c', 'd', 'e']
