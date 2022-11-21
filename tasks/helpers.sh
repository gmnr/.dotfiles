# Define helper functions

# link readings in the 
function read_and_review() {
  title=$(curl -s $1 | rg -o '<title>.+</title>' | sed -e 's/<[^>]*>//g')
  descr="\"Read and review: $title\""
  id=$(task add +inbox +read "$descr" | sed -n 's/Created task \(.*\)./\1/p')
  task "$id" annotate $1
}

# check if projects don't have any next action
function stale_project() {
  cmd=$(python - <<EOF
import tasklib
tw = tasklib.TaskWarrior()
result = set(tw.execute_command(['+PROJECT', '+PENDING', '+READY', '-waiting', '_projects'])) - set(tw.execute_command(['+PROJECT', '+PENDING', '+next', '_projects'])) - set(tw.execute_command(['+PROJECT', '+PENDING', '+SCHEDULED', '_projects'])) - set(tw.execute_command(['+PROJECT', '+PENDING', '+wait', '_projects']))
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
  echo "No projects inactive"
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
  dir=~/.notes/task-notes
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

# generic aliases
alias t='task'
alias tn='~/.dotfiles/tasks/task-note.py'
alias tq='read_task'

# reports
alias tt='clear; task next'
alias ti='clear; task ticker'
alias tl='clear; task later'
alias tw='clear; task wait'
alias tp='clear; task prj'
alias box='clear; task inbox'

# collection
alias c='task add +inbox'
alias rd='read_and_review'

# do
alias ts='stale_project'
alias ta='task_refile'
alias tm='task mod'
