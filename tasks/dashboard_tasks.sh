#!/bin/bash

# display count for `next` tasks
if [[ $1 -eq 1 ]]; then
  cmd=$(/usr/local/bin/task count "(+next or sched.before:tom) +PENDING -wait")
  if [[ $cmd -gt 0 ]]; then
    echo "$cmd "
  else
    echo "- "
  fi
fi

# display count for `ticker` tasks
if [[ $1 -eq 2 ]]; then
  cmd=$(/usr/local/bin/task count "(sched.after:tod) +PENDING -wait")
  if [[ $cmd -gt 0 ]]; then
    echo "$cmd "
  else
    echo "- "
  fi
fi

# display count for `someday` tasks
if [[ $1 -eq 3 ]]; then
  cmd=$(/usr/local/bin/task count "+later +PENDING -wait")
  if [[ $cmd -gt 0 ]]; then
    echo "$cmd "
  else
    echo "- "
  fi
fi

# display number of projects
if [[ $1 -eq 4 ]]; then
  cmd=$(/usr/local/bin/task count "-next pro.not:'' +PENDING -SCHEDULED -wait")
  if [[ $cmd -gt 0 ]]; then
    echo "$cmd "
  else
    echo "- "
  fi
fi

# display count for `waiting` tasks
if [[ $1 -eq 5 ]]; then
  cmd=$(/usr/local/bin/task count "+wait +PENDING")
  if [[ $cmd -gt 0 ]]; then
    echo "$cmd "
  else
    echo "- "
  fi
fi

# display count of unassigned projects
if [[ $1 -eq 6 ]]; then
  active=$(/usr/local/bin/task projects +SCHEDULED or +wait or +next | awk 'NR>4 {  print $1 }' | grep ^[a-z]* -w)
  all=$(/usr/local/bin/task projects | awk 'NR>4 {  print $1 }' | grep ^[a-z]* -w)

  cmd=$(echo -e "$active\n$all" | sort | uniq -c | grep -c "^.*1 ")

  if [[ $cmd -gt 0 ]]; then
    echo "$cmd "
  else
    echo "- "
  fi
fi
