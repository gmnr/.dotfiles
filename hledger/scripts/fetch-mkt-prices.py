#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Fetch prices and append to price.journal
"""

__author__ = "Guido Minieri"
__license__ = "GPL"

import datetime
import requests
import sys
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


def fetch_quotes(stock):
    stocks_url = f"https://query1.finance.yahoo.com/v8/finance/chart/{stock}"
    headers = {
        "User-Agent": "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.4; en-US; rv:1.9.2.2) Gecko/20100316 Firefox/3.6.2"
    }
    try:
        res = requests.get(stocks_url, headers=headers).json()
    except:
        logger.error(f"Call to yahoo finance for {stock} has failed")
        return "ERROR"
    return locale.str(round(res["chart"]["result"][0]["meta"]["regularMarketPrice"], 2))


def fetch_crypto():
    ticker = "polkadot"
    curr = "eur"
    stocks_url = f"https://api.coingecko.com/api/v3/simple/price?ids={ticker}&vs_currencies={curr}"
    try:
        res = requests.get(stocks_url).json()
    except:
        logger.error(f"Call to coingecko for DOT-EUR has failed")
        return "ERROR"
    return locale.str(round(res[ticker][curr], 2))


# define dates used in the payload
date = "{:%Y-%m-%d %H:%M:%S}".format(datetime.datetime.now())
trade_date = "{:%Y-%m-%d}".format(datetime.datetime.now())

# compose payload and load it to file
payload = f"""; FETCHED @ {date}
P {trade_date} VWCE {fetch_quotes('VWCE.MI').rjust(44, ' ')}
P {trade_date} IUSA {fetch_quotes('IUSA.MI').rjust(44, ' ')}
P {trade_date} DOT  {fetch_crypto().rjust(44, ' ')}
"""

# quit early if there is an error
if "ERROR" in payload:
    logger.info("Error in fetching quotes - file not overwritten")
    sys.exit()

# write to tmp file
with open("/Users/gmnr/.finance/prices/current_prices.journal", "w") as f:
    f.seek(0)
    f.write(payload)

logger.info("Fetched prices for VWCE.MI, IUSA.MI, DOT-EUR")
