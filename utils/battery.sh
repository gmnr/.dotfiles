#!/bin/bash

# retrive battery information(macOS) only

pmset -g batt | grep --color=never -Eo [0-9]?[0-9]{2}%
