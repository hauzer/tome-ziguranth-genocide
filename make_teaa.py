#!/usr/bin/env python3

import os
import os.path
from zipfile import ZipFile, ZIP_LZMA

addon_dir = os.path.dirname(os.path.realpath(__file__))
print(addon_dir)
files = []
for walk in os.walk(addon_dir):
    dir = os.path.relpath(walk[0], addon_dir)
    files += [os.path.join(dir, f) for f in walk[2] if f != __file__]

addon_file = os.path.join(addon_dir, '{}.teaa'.format(os.path.basename(addon_dir)))
print(addon_file)
with ZipFile(addon_file, 'w', ZIP_LZMA) as addon:
    for file in files:
        addon.write(file)
