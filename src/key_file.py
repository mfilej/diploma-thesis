class KeyFile:
    def __init__(self, io):
        self.classes = self._parse(io)

    def _parse(self, io):
        pairs = [line.split('\t') for line in io]
        pairs.sort(key=lambda pair: float(pair[0]))
        return [pair[1].strip() for pair in pairs]
