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
result = set(tw.execute_command(['+PROJECT', '+PENDING', '+READY', '-waiting', '_projects'])) - set(tw.execute_command(['+PROJECT', '+PENDING', '+next', '_projects'])) - set(tw.execute_command(['+PROJECT', '+PENDING', '+SCHEDULED', '_projects']))
for i in result:
  print(i)
EOF
)
if [ "$cmd" != "" ]; then
  echo "Attention: The following projects don't currently have a next action:"
  echo $cmd
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
  cat ~/.notes/task-notes/$(task _get $1.uuid).md
}

# generic aliases
alias t='task'
alias ta='task add'
alias tn='~/.dotfiles/tasks/task-note.py'
alias tq='read_task'

# reports
alias tt='clear; task next'
alias ti='clear; task ticker'
alias tl='clear; task later'
alias tp='clear; task prj'
alias inbox='clear; task inbox'

# collection
alias in='task add +inbox'
alias rd='read_and_review'

# do
alias ts='stale_project'
alias ta='task_refile'
