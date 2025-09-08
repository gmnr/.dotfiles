#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Color the input of hledger commands
"""

__author__ = "Guido Minieri"
__license__ = "GPL"


import re
import sys
from colorama import Fore

# define colors
red = Fore.RED
blue = Fore.BLUE
cyan = Fore.CYAN
magenta = Fore.MAGENTA
green = Fore.GREEN
yellow = Fore.YELLOW
grey = Fore.LIGHTBLACK_EX
reset = Fore.RESET

mode = sys.argv[1]

if mode == "report":
    date = r"[0-9]{4}[-/][0-9]{2}([-/][0-9]{2})?"
    empty_val = r"\s0\s"
    negative_amount = r"-\d+(\.\d{3})*(\,\d+)? [A-Z]{3,4}"
    positive_amount = r" \d+(\.\d{3})*(\,\d+)? [A-Z]{3,4}"
    titles = r"(Revenues|Expenses|Net:|Assets|Liabilities)"
    months = r"(Total|Average|Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec|(20[0-9][0-9])(-[0-9]{2})?(-[0-9]{2})?)"
    payee = r"~"
    account = r"\s[a-zA-Z:,-.]+([0-9]+)?[a-zA-Z:,-.]+\s"
elif mode == "pivot":
    date = r"[0-9]{4}[-/][0-9]{2}([-/][0-9]{2})?"
    empty_val = r"\s0\s"
    negative_amount = r"-\d+(\.\d{3})*(\,\d+)? [A-Z]{3,4}"
    positive_amount = r" \d+(\.\d{3})*(\,\d+)? [A-Z]{3,4}"
    titles = r"(Revenues|Expenses|Net:|Assets|Liabilities)"
    months = r"(Total|Average|Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec|(20[0-9][0-9])(-[0-9]{2})?(-[0-9]{2})?)"
    payee = r"~"
    account = r"\s[0-9A-ZÀ-ÿ &'.]+\s"
else:
    date = r"[0-9]{4}[-/][0-9]{2}([-/][0-9]{2})?"
    empty_val = r"\s0\s"
    negative_amount = r"-\d+(\.\d{3})*(\,\d+)? [A-Z]{3,4}"
    positive_amount = r" \d+(\.\d{3})*(\,\d+)? [A-Z]{3,4}"
    titles = r"(Revenues|Expenses|Net:|Assets|Liabilities)"
    months = r"(Total|Average|Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec|(20[0-9][0-9])(-[0-9]{2})?(-[0-9]{2})?)"
    payee = r"\s.+\s\|"
    account = r"\s\s[a-zA-Z: ,-.]+\s"

# map color to regex match
mappings = {
    date: yellow,
    negative_amount: red,
    positive_amount: green,
    titles: magenta,
    months: yellow,
    payee: magenta,
    account: blue,
    empty_val: grey,
}

msg = ""
for n, line in enumerate(sys.stdin):
    if mode == "areg":
        if n == 0:
            if "liabilities" in line or "assets" in line:
                mappings[positive_amount] = green
                mappings[negative_amount] = red
            else:
                mappings[positive_amount] = red
                mappings[negative_amount] = green
    # liabilities: red for positive balance / green for negative balance
    if mode in ("report", "pivot"):
        if "Liabilities" in line or "Expenses" in line:
            mappings[positive_amount] = red
            mappings[negative_amount] = green
        if "Net:" in line:
            mappings[positive_amount] = green
            mappings[negative_amount] = red
    if mode == "register":
        mappings[positive_amount] = red
        mappings[negative_amount] = green
        if "liabilities" in line or "assets" in line:
            mappings[positive_amount] = green
            mappings[negative_amount] = red
    if mode == "cf":
        mappings[positive_amount] = green
        mappings[negative_amount] = red
        mappings["Total"] = magenta
        mappings[r"\s[a-z: ,-.]+"] = blue

    for regex, color in mappings.items():
        if (mode == "report" or mode == "pivot" or mode == "cf") and n == 0:
            continue
        line = re.sub(regex, lambda m: "{}{}{}".format(color, m.group(), reset), line)
    msg += line
print(msg)
