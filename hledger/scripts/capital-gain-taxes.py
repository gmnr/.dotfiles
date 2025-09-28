#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Based on current prices, calculate deferred tax on capital gain
"""

__author__ = "Guido Minieri"
__license__ = "GPL"

import os
import locale
from loguru import logger

locale.setlocale(locale.LC_ALL, "it_IT")

# add log
logger.add(
    "/Users/gmnr/.finance/.logs/execution.log",
    format="{time:YYYY-MM-DD at HH:mm:ss} {message}",
    level="INFO",
    rotation="2 MB",
)


with open("/Users/gmnr/.finance/prices/current_prices.journal", "r") as f:
    current_prices = f.read().splitlines()[1:]

PRICES = {}
for p in current_prices:
    _, _, ticker, amt = p.split()
    PRICES[ticker] = locale.atof(amt)

PAYLOAD = ""
TAX_RATE = 0.26
PATH = "/Users/gmnr/.finance/investments/"
BV_ACCUMULATION = {"DOT": (0, 0), "VWCE": (0, 0), "IUSA": (0, 0)}


def calculate_tax(
    tnx,
    bv,
    prices=PRICES,
    tax_rate=TAX_RATE,
):
    ACCOUNTS = {
        "DOT": (
            "  liabilities:tax-deferred:investments:DOT  ",
            "  expenses:taxes:deferred-capital-gain:DOT",
        ),
        "VWCE": (
            "  liabilities:tax-deferred:investments:VWCE.MI  ",
            "  expenses:taxes:deferred-capital-gain:VWCE.MI",
        ),
        "IUSA": (
            "  liabilities:tax-deferred:investments:IUSA.MI  ",
            "  expenses:taxes:deferred-capital-gain:IUSA.MI",
        ),
    }
    date, ticker, qnt, amt = tnx
    if amt == 0:
        return False

    price = prices[ticker]
    if price > bv[ticker]:
        tax_amt = (price - bv[ticker]) * tax_rate * qnt
    else:
        return False

    return f"""{date} AGENZIA DELLE ENTRATE | deferred capital gain tax for {ticker}
{ACCOUNTS[ticker][1]:<49}  {locale.currency(tax_amt, symbol=False, grouping=True):>11}
{ACCOUNTS[ticker][0]}\n\n"""


transactions = []
for filename in os.listdir(PATH):
    with open(f"{PATH}{filename}", "r") as f:  # open in readonly mode
        year = f.read().split("\n\n")
        for tnx in year:
            if tnx == "":
                continue
            head, asset, *_ = tnx.split("\n")
            date, *_ = head.split()
            *_, qnt, ticker, _, amt = asset.split()
            qnt = locale.atof(qnt)
            amt = locale.atof(amt)
            transactions.append((date, ticker, qnt, amt))
            if qnt < 0:
                amt = qnt * amt
            BV_ACCUMULATION[ticker] = tuple(
                map(sum, zip(BV_ACCUMULATION[ticker], (qnt, amt)))
            )

BV = {}
for tick, book_value in BV_ACCUMULATION.items():
    BV[tick] = book_value[1] / book_value[0]

for t in transactions:
    tax = calculate_tax(t, BV)
    if tax:
        PAYLOAD += tax

with open("/Users/gmnr/.finance/calculations/deferred-capital-gain.journal", "w") as f:
    f.write(PAYLOAD)

logger.info("Calculation of deferred tax complete")
