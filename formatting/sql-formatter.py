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

my_env = {
    **os.environ,
    "PATH": "/opt/homebrew/bin:" + os.environ["PATH"],
}

# execute command
p = Popen(
    env=my_env,
    cwd="/Users/gmnr/.local/share/nvim/mason/packages/prettier",
    args=[
        "/Users/gmnr/.local/share/nvim/mason/bin/prettier",
        "/tmp/formatting-tmp.sql",
        "--config",
        "/Users/gmnr/.dotfiles/formatting/.prettierrc.yml",
    ],
    stdout=PIPE,
    stderr=PIPE,
)
stdout, stderr = p.communicate()
sql = stdout.decode("ascii")

# transform and fix small errors
add_one = False
if "RIGHT" in sql or "INNER" in sql:
    add_one = True
lines = sql.splitlines()
sql = []
for line in lines:
    if " JOIN " in line and " ON " in line:
        if "RIGHT" in line or "INNER" in line:
            line = line.lstrip()
        offset = line.find(" JOIN ") + 3
        pos = line.find(" ON ")
        new_pos = line[::-1].find(" NO ") * -1
        sql.append(line[:pos])
        sql.append(" " * (offset) + "ON " + line[new_pos:])
        continue

    if " WHEN " in line or " ELSE " in line:
        sql.append(line[6:])
        continue

    if add_one:
        sql.append(" " + line)
    else:
        sql.append(line)

sql = "\n".join(sql)
sql = sql.replace("# gruppi", "#gruppi")
sql = sql.replace("# cure", "#cure")
sql = sql.replace("YEAR (", "YEAR(")
if not sql.startswith("--"):
    sql = "-- description\n" + sql
if not sql[-1] == ";":
    sql = sql + ";"
print(sql, end="")
