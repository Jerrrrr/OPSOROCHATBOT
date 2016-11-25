#!/usr/bin/env python

import os
import sys

basedir = os.path.dirname(os.path.realpath(__file__))

# old = os.path.join(basedir, "opsoro")
# if os.path.exists(old):
#     # rename left-overs from old file structure
#     print """
# Found left-overs from old file structure, renaming to
# "octoprint.backup". Please remove this manually (I don't
# dare to do so myself since you might have changes in there
# I don't know anything about).
# """
#     os.rename(old, os.path.join(basedir, "opsoro.backup"))

sys.path.insert(0, os.path.join(basedir, "src"))

import opsoro
opsoro.main()