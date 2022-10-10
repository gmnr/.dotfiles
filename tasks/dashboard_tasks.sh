#!/bin/bash

# display count for `next` tasks
if [[ $1 -eq 1 ]]; then
  cmd=$(/usr/local/bin/task count "(+next or sched.before:tom) +PENDING")
  if [[ $cmd -gt 0 ]]; then
    echo "$cmd "
  else
    echo "- "
  fi
fi

# display count for `ticker` tasks
if [[ $1 -eq 2 ]]; then
  cmd=$(/usr/local/bin/task count "(sched.after:tod) +PENDING")
  if [[ $cmd -gt 0 ]]; then
    echo "$cmd "
  else
    echo "- "
  fi
fi

# display count for `someday` tasks
if [[ $1 -eq 3 ]]; then
  cmd=$(/usr/local/bin/task count "+later +PENDING")
  if [[ $cmd -gt 0 ]]; then
    echo "$cmd "
  else
    echo "- "
  fi
fi

# display number of projects
if [[ $1 -eq 4 ]]; then
  cmd=$(/usr/local/bin/task count "-next pro.not:'' +PENDING -SCHEDULED")
  if [[ $cmd -gt 0 ]]; then
    echo "$cmd "
  else
    echo "- "
  fi
fi
