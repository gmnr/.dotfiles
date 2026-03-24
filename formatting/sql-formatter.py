#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Wrap prettier-sql-plugin into a python script to format sql scripts
"""

__author__ = "Guido Minieri"
__license__ = "GPL"


import sys
import os
from subprocess import Popen, PIPE

# read input
sql = sys.stdin.read().rstrip()

# create tmp file to be formatted and read
with open("/tmp/formatting-tmp.sql", "w") as f:
    f.write(sql)

env = {
    **os.environ,
    "PATH": "/opt/homebrew/bin:" + os.environ["PATH"],
}
# execute command
p = Popen(
    env=env,
    args=["npx", "holywell", "/tmp/formatting-tmp.sql"],
    stdout=PIPE,
    stderr=PIPE,
)

stdout, stderr = p.communicate()
sql = stdout.decode("utf-8")

# print output
print(sql[:-1], end="")
