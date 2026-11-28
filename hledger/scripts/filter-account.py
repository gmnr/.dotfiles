#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Filter account list to use only sub account
"""

__author__ = "Guido Minieri"
__license__ = "GPL"


import sys

main_accounts = ["assets", "liabilities", "equity", "revenues", "expenses"]
sub_accounts = [
    "assets:current",
    "assets:investments",
    "assets:credits",
    "assets:welfare",
    "assets:depreciables",
    "liabilities:current",
    "liabilities:buy-now-pay-later",
    "liabilities:financing",
    "liabilities:tax",
    "liabilities:tax-deferred",
]
snippets = [
    "assets:current:cash",
    "assets:current:fineco",
    "assets:current:paypal",
    "expenses:transit:car:fuel",
    "expenses:food-bev:groceries",
    "expenses:food-bev:drinks",
]

excluded_accounts = set(main_accounts + sub_accounts + snippets)

for acc in sys.stdin:
    acc = acc.rstrip("\n")
    if acc in excluded_accounts:
        continue
    print(acc)
