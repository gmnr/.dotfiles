#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Wrap holywell formatter into a python script to format sql scripts
"""

__author__ = "Guido Minieri"
__license__ = "GPL"


import sys
import os
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
    args=["npx", "holywell", "--dialect", "tsql"],
    stdout=PIPE,
    stderr=PIPE,
    text=True,
)

stdout, stderr = p.communicate(sql)
output = stdout.rstrip()

# parse special rules not covered by formatter
reserved_keywords = ["format", "pivot"]
for word in reserved_keywords:

    if word in output:
        output = output.replace(word, word.upper())

# print output
print(output, end="")
