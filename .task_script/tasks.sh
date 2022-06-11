#!/bin/bash
if [[ $1 -eq 1 ]]
  # get all the tasks that are in the inbox, waiting to be processed
  then echo $(/usr/local/bin/task folder:inbox +PENDING count)" "
fi
if [[ $1 -eq 2 ]]
  # get all the tasks that have not been delegated nor blocked/waiting
  then echo $(/usr/local/bin/task folder:next -WAITING count)" "
fi
if [[ $1 -eq 3 ]]
  # get all the tasks that are not in inbox and that are waiting
  then echo $(/usr/local/bin/task folder:inbox +WAITING count)" "
fi
if [[ $1 -eq 4 ]]
  # get all the tasks that are scheduled for later (es. maybes) to be weekly reviewed
  then echo $(/usr/local/bin/task folder:later count)" "
fi
if [[ $1 -eq 5 ]]
  # implement check
  then
    if [[ $(/usr/local/bin/task folder:inbox +PENDING count)+$(/usr/local/bin/task folder:next -WAITING count)+$(/usr/local/bin/task folder:inbox +WAITING count)+$(/usr/local/bin/task folder:later count) -eq $(/usr/local/bin/task count) ]]
    then echo " ~ "
    else echo " ! "
    fi
fi
