#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""Based on current prices, calculate deferred tax on capital gain."""

import argparse
import locale
import os
from dataclasses import dataclass
from datetime import date, datetime, timedelta
from pathlib import Path
from typing import NamedTuple
from loguru import logger

__author__ = "Guido Minieri"
__license__ = "GPL"


# paths
FINANCE_DIR = Path(os.environ.get("FINANCE_DIR", Path.home() / ".finance"))
INVESTMENTS_DIR = FINANCE_DIR / "investments"
CURRENT_PRICES_FILE = FINANCE_DIR / "prices" / "current_prices.journal"
HISTORIC_PRICES_FILE = FINANCE_DIR / "prices" / "historic_prices.journal"
OUTPUT_FILE = FINANCE_DIR / "calculations" / "deferred-capital-gain.journal"
LOG_FILE = FINANCE_DIR / ".logs" / "execution.log"

# taxes
CAPITAL_GAIN_TAX = 0.26
PENSION_TAX = 0.15

# ignore these dates
EXCLUDED_DATES = ("2026-02-03",)


@dataclass(frozen=True)
class Asset:
    """Tax treatment and posting accounts for a single ticker."""

    expense_account: str
    liability_account: str
    tax_rate: float
    tax_on_full_value: bool = False  # Pension funds is taxed on the whole


ASSETS = {
    "DOT": Asset(
        "expenses:taxes:deferred-capital-gain:crypto:DOT",
        "liabilities:funds:deferred-tax:investments:crypto:DOT",
        CAPITAL_GAIN_TAX,
    ),
    "VWCE": Asset(
        "expenses:taxes:deferred-capital-gain:etf:VWCE.MI",
        "liabilities:funds:deferred-tax:investments:etf:VWCE.MI",
        CAPITAL_GAIN_TAX,
    ),
    "IUSA": Asset(
        "expenses:taxes:deferred-capital-gain:etf:IUSA.MI",
        "liabilities:funds:deferred-tax:investments:etf:IUSA.MI",
        CAPITAL_GAIN_TAX,
    ),
    "ALNZ": Asset(
        "expenses:taxes:deferred-tfr",
        "liabilities:funds:deferred-tax:tfr",
        PENSION_TAX,
        tax_on_full_value=True,
    ),
}


class Transaction(NamedTuple):
    date: date
    ticker: str
    quantity: float
    amount: float


# Period handling
def parse_period(value):
    """Turn the CLI argument into a (cut-off date, price-block key) pair.

    Accepted forms: ``YYYY/MM``, ``YYYY``, ``lastmonth``, or nothing at all
    (which means "today", using the current prices file).
    """
    if not value:
        return None, None

    if value == "lastmonth":
        last_month = date.today().replace(day=1) - timedelta(days=1)
        key = last_month.strftime("%Y/%m")
    elif "/" in value:
        year, month = value.split("/")
        key = f"{year}/{int(month):02d}"
    else:
        return date(int(value), 12, 31), f"{int(value)}/12"

    return datetime.strptime(key, "%Y/%m").date(), key


# Prices
def parse_prices(lines):
    """Parse ``P <date> <ticker> <amount>`` lines into a ticker -> price map."""
    prices = {}
    for line in lines:
        if not line.strip():
            continue
        *_, ticker, amount = line.split()
        prices[ticker] = locale.atof(amount)
    return prices


def load_prices(period_key):
    """Load current prices, or the historic block matching ``period_key``."""
    if period_key is None:
        # First line is the file header.
        return parse_prices(CURRENT_PRICES_FILE.read_text().splitlines()[1:])

    blocks = HISTORIC_PRICES_FILE.read_text().split("\n\n")
    for block in blocks:
        block = block.replace("-", "/")  # dates are written as YYYY-MM-DD
        if period_key in block:
            return parse_prices(block.splitlines()[1:])


# Transactions
def read_transactions(cutoff):
    """Yield every investment transaction recorded up to ``cutoff``."""
    for journal in sorted(INVESTMENTS_DIR.iterdir()):
        for entry in journal.read_text().split("\n\n"):
            if not entry.strip():
                continue
            if any(excluded in entry for excluded in EXCLUDED_DATES):
                continue

            header, asset_line, *_ = entry.splitlines()
            entry_date = datetime.strptime(header.split()[0], "%Y-%m-%d").date()
            if cutoff and entry_date > cutoff:
                continue

            *_, quantity, ticker, _, amount = asset_line.split()
            if ticker not in ASSETS:
                logger.warning(f"unknown ticker {ticker} in {journal.name}, skipped")
                continue

            yield Transaction(
                entry_date, ticker, locale.atof(quantity), locale.atof(amount)
            )


def book_values(transactions):
    """Average book value per unit, per ticker."""
    totals: dict[str, tuple[float, float]] = {}
    for txn in transactions:
        quantity, cost = totals.get(txn.ticker, (0.0, 0.0))
        # Sales are recorded as a unit price, purchases as a total.
        paid = txn.quantity * txn.amount if txn.quantity < 0 else txn.amount
        totals[txn.ticker] = (quantity + txn.quantity, cost + paid)

    return {
        ticker: (cost / quantity if cost else quantity)
        for ticker, (quantity, cost) in totals.items()
    }


# Tax calculation
def deferred_tax(txn, asset, price, book_value):
    """Tax owed on the unrealised gain of a single lot, if any."""
    if asset.tax_on_full_value:
        return price * txn.quantity * asset.tax_rate

    if txn.amount == 0:
        return None
    if price <= book_value:
        return None

    return (price - book_value) * txn.quantity * asset.tax_rate


def format_entry(txn, asset, tax):
    amount = locale.currency(tax, symbol=False, grouping=True)
    return (
        f"{txn.date:%Y-%m-%d} AGENZIA DELLE ENTRATE"
        f" | deferred capital gain tax for {txn.ticker}\n"
        f"  {asset.expense_account:<47}  {amount:>11}\n"
        f"  {asset.liability_account}\n"
    )


# main
def set_locale():
    for name in ("it_IT.UTF-8", "it_IT"):
        locale.setlocale(locale.LC_ALL, name)
        return


def parse_args():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "date",
        nargs="?",
        help="YYYY/MM, YYYY, or 'lastmonth'; defaults to current prices",
    )
    return parser.parse_args()


def main():
    args = parse_args()
    set_locale()

    logger.add(
        LOG_FILE,
        format="{time:YYYY-MM-DD at HH:mm:ss} {message}",
        level="INFO",
        rotation="2 MB",
    )

    cutoff, period_key = parse_period(args.date)
    prices = load_prices(period_key)
    transactions = list(read_transactions(cutoff))
    values = book_values(transactions)

    entries = []
    for txn in transactions:
        asset = ASSETS[txn.ticker]
        tax = deferred_tax(txn, asset, prices[txn.ticker], values[txn.ticker])
        if tax is not None:
            entries.append(format_entry(txn, asset, tax))

    OUTPUT_FILE.write_text("\n".join(entries))

    logger.info("Calculation of deferred tax complete")


if __name__ == "__main__":
    main()
