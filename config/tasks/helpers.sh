# Define helper functions

# check if projects don't have any next action
function stale_project() {
  cmd=$(python - <<EOF
import tasklib
tw = tasklib.TaskWarrior()
result = set(tw.execute_command(['+PROJECT', '+PENDING', '+READY', '_projects'])) - set(tw.execute_command(['+PROJECT', '+PENDING', '+next', '_projects'])) - set(tw.execute_command(['+PROJECT', '+PENDING', '+SCHEDULED', '_projects'])) - set(tw.execute_command(['+PROJECT', '+PENDING', '+wait', '_projects']))
for i in result:
  print(i)
EOF
)
if [ "$cmd" != "" ]; then
  echo "Attention: The following projects don't currently have a next action:"
  for elem in $cmd; do
    echo "- $elem"
  done
else
  echo "No projects have unassigned tasks."
fi
}

# processes id by moving them from one tag to the other
function task_refile() {
  task_n=$1
  shift
  task mod $task_n -inbox $*
}

# read notes linked to fi
function read_task() {
  dir=~/.notes/task
  if [ $# -eq 0 ]; then
    NOTES=""
    for file in $dir/*.md; do
      file=$(basename ${file%.*})
      NOTES=$NOTES","$(task _get "$file".id)
    done
    task ${NOTES:1}
  else
    note=$dir/$(task _get $1.uuid).md
    if [ -f "$note" ]; then
      cat $note
    else
      echo 'There is no note associated with that ID.'
    fi
  fi
}

function next_inbox() {
  inbox_id=$(python - <<EOF
import tasklib
tw = tasklib.TaskWarrior()
try: print(tw.execute_command(['+inbox', '-PROJECT'])[3].split()[0])
except: print('')
EOF
)
if [ "$inbox_id" == "" ]; then
  echo "No more items in Inbox"
else
  task $inbox_id
fi
}

# generic aliases
alias t='task'
alias tn='~/.dotfiles/config/tasks/task-note.py'
alias tq='read_task'

# reports
alias tt='clear; echo " -- NEXT TASKS --"; task next'
alias tw='clear; echo " -- SCHEDULED TASKS --"; task ticker'
alias tl='clear; echo " -- LATER TASKS --"; task later'
alias to='clear; echo " -- DELEGATED TASKS --"; task wait'
alias tp='clear; echo " -- PROJECT-LESS TASKS --"; task prj'
alias tpp='clear; echo " -- LIST PROJECTS --"; task projects +PROJECT'
alias ti='clear; next_inbox'
alias tii='clear; echo " -- INBOX --"; task inbox'

# collection
alias c='task add +inbox'

# do
alias ts='stale_project'
alias ta='task_refile'
alias tm='task mod'
alias te='task edit'
