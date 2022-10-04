#!/bin/bash

# display count for `next` tasks
if [[ $1 -eq 1 ]]; then
  cmd=$(/usr/local/bin/task count +next)
  if [[ $cmd -gt 0 ]]; then
    echo "$cmd "
  else
    echo "0 "
  fi
fi

# display count for `ticker` tasks
if [[ $1 -eq 2 ]]; then
  cmd=$(/usr/local/bin/task count +SCHEDULED)
  if [[ $cmd -gt 0 ]]; then
    echo "$cmd "
  else
    echo "0 "
  fi
fi

# display count for `someday` tasks
if [[ $1 -eq 3 ]]; then
  cmd=$(/usr/local/bin/task count +later)
  if [[ $cmd -gt 0 ]]; then
    echo "$cmd "
  else
    echo "0 "
  fi
fi

# display number of projects
if [[ $1 -eq 4 ]]; then
  cmd=$(/usr/local/bin/task projects | /usr/bin/cut -d ' ' -f1)
  echo "$cmd "
fi

# old check for reference
# if [[ $1 -eq 5 ]]; then
#   if [[ $(/usr/local/bin/task folder:inbox +PENDING count)+$(/usr/local/bin/task folder:next -WAITING -COMPLETED count)+$(/usr/local/bin/task folder:inbox +WAITING count)+$(/usr/local/bin/task folder:later -COMPLETED count) -eq $(/usr/local/bin/task count -COMPLETED -DELETED) ]]
#   then echo " ~ "
#   else echo " ! "
#   fi
# fi
