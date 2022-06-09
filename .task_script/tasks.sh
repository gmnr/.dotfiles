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
  then echo $(/usr/local/bin/task +WAITING folder.not:inbox count)" "
fi
if [[ $1 -eq 4 ]]
  # get all the tasks that are scheduled for later
  then echo $(/usr/local/bin/task +SCHEDULED folder.not:inbox count)" "
fi
