#!/usr/bin/env python3

import os
import os.path
from zipfile import ZipFile, ZIP_DEFLATED

script_file = os.path.realpath(__file__)
script_dir = os.path.dirname(script_file)
addon_dir = os.path.join(script_dir, 'addon')

files = []
for walk in os.walk(addon_dir):
    dir = os.path.relpath(walk[0], addon_dir)
    for file in walk[2]:
        real_file = os.path.join(os.path.realpath(walk[0]), file)
        arc_file = os.path.join(dir, file)
        if not os.path.samefile(real_file, script_file):
            files.append((real_file, arc_file))

addon_file = os.path.join(script_dir, '{}.teaa'.format(os.path.basename(script_dir)))
with ZipFile(addon_file, 'w', ZIP_DEFLATED) as addon:
    for file in files:
        addon.write(file[0], file[1])
