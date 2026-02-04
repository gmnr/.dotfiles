#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Based on current prices, calculate deferred tax on capital gain
"""

__author__ = "Guido Minieri"
__license__ = "GPL"

import os
import locale
import argparse
from datetime import datetime
from loguru import logger

locale.setlocale(locale.LC_ALL, "it_IT")

# add log
logger.add(
    "/Users/gmnr/.finance/.logs/execution.log",
    format="{time:YYYY-MM-DD at HH:mm:ss} {message}",
    level="INFO",
    rotation="2 MB",
)

parser = argparse.ArgumentParser()
parser.add_argument("date", nargs="?", type=str)
args = parser.parse_args()

end = args.date
if end:
    if end.find("/") > 0:
        year, month = end.split("/")
        end_str = year + "/" + month.zfill(2)
        end = datetime.strptime(end_str, "%Y/%m")
    else:
        end_str = f"{int(end)}/12"
        end = datetime(int(end), 12, 31)
else:
    end = None


PRICES = {}
if end:
    with open("/Users/gmnr/.finance/prices/historic_prices.journal", "r") as f:
        all_prices = f.read().split("\n\n")

    for p in all_prices[::-1]:
        p = p.replace("-", "/")
        if end_str in p:
            current_prices = p

    for p in current_prices.splitlines()[1:]:
        _, _, ticker, amt = p.split()
        PRICES[ticker] = locale.atof(amt)
else:
    with open("/Users/gmnr/.finance/prices/current_prices.journal", "r") as f:
        current_prices = f.read().splitlines()[1:]
    for p in current_prices:
        _, _, ticker, amt = p.split()
        PRICES[ticker] = locale.atof(amt)

PAYLOAD = ""
TAX_RATE = 0.26
PATH = "/Users/gmnr/.finance/investments/"
book_value = {"DOT": (0, 0), "VWCE": (0, 0), "IUSA": (0, 0)}


def calculate_tax(
    tnx,
    bv,
    prices=PRICES,
    tax_rate=TAX_RATE,
):
    ACCOUNTS = {
        "DOT": (
            "  liabilities:funds:deferred-tax:investments:crypto:DOT  ",
            "  expenses:taxes:deferred-capital-gain:crypto:DOT",
        ),
        "VWCE": (
            "  liabilities:funds:deferred-tax:investments:etf:VWCE.MI  ",
            "  expenses:taxes:deferred-capital-gain:etf:VWCE.MI",
        ),
        "IUSA": (
            "  liabilities:funds:deferred-tax:investments:etf:IUSA.MI  ",
            "  expenses:taxes:deferred-capital-gain:etf:IUSA.MI",
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


def build_transactions(path, bv_acc, end):
    transactions = []

    for filename in os.listdir(path):
        with open(f"{path}{filename}", "r") as f:  # open in readonly mode
            year = f.read().split("\n\n")
            for tnx in year:
                if tnx == "":
                    continue
                head, asset, *_ = tnx.split("\n")
                date, *_ = head.split()

                if any(
                    x in tnx for x in ["2026-02-03"]
                ):  # exclude transactions from bv calculations
                    continue

                if end:
                    date = datetime.strptime(date, "%Y-%m-%d")

                    if date > end:
                        continue

                *_, qnt, ticker, _, amt = asset.split()
                qnt = locale.atof(qnt)
                amt = locale.atof(amt)
                transactions.append((date, ticker, qnt, amt))
                if qnt < 0:
                    amt = qnt * amt
                bv_acc[ticker] = tuple(map(sum, zip(bv_acc[ticker], (qnt, amt))))
    return transactions, bv_acc


trans, book_value = build_transactions(PATH, book_value, end)

BV = {}
for tick, book_value in book_value.items():
    BV[tick] = book_value[1] / book_value[0]

for t in trans:
    tax = calculate_tax(t, BV)
    if tax:
        PAYLOAD += tax

with open("/Users/gmnr/.finance/calculations/deferred-capital-gain.journal", "w") as f:
    f.write(PAYLOAD)

logger.info("Calculation of deferred tax complete")
