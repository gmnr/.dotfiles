#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Wrap holywell formatter into a python script to format sql scripts
"""

__author__ = "Guido Minieri"
__license__ = "GPL"


import os
import re
import sys
from subprocess import Popen, PIPE

# read input
sql = sys.stdin.read()

env = {
    **os.environ,
    "PATH": "/opt/homebrew/bin:" + os.environ["PATH"],
}
# execute command
p = Popen(
    env=env,
    stdin=PIPE,
    args=["sqlriver", "--dialect", "tsql"],
    stdout=PIPE,
    stderr=PIPE,
    text=True,
)

stdout, stderr = p.communicate(sql)
output = stdout.rstrip()

# fail loudly so conform keeps the buffer instead of replacing it with nothing
if p.returncode != 0 or not output:
    sys.stderr.write(stderr or "sqlriver produced no output\n")
    sys.exit(p.returncode or 1)

my_mapping = {
    r"\bformat\b": "FORMAT",
    r"\bpivot\b": "PIVOT",
    r"\n{2,}": "\n",
    r" ON\b": "   ON",
}

for pattern, replacement in my_mapping.items():
    output = re.sub(pattern, replacement, output)

# print output
print(output, end="")
