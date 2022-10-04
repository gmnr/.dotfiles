# Define helper functions

# link readings in the 
function read_and_review() {
  title=$(curl -s $1 | rg -o '<title>.+</title>' | sed -e 's/<[^>]*>//g')
  descr="\"Read and review: $title\""
  id=$(task add +inbox +read "$descr" | sed -n 's/Created task \(.*\)./\1/p')
  task "$id" annotate $1
}

function next_actions() {
  cmd=$(python - <<EOF
import tasklib
tw = tasklib.TaskWarrior()
result = set(tw.execute_command(['+PROJECT', '+PENDING', '+READY', '-waiting', '_projects'])) - set(tw.execute_command(['+PENDING', '+next', '_projects']))
for i in result:
  print(i)
EOF
)
if [ "$cmd" != "" ]; then
  echo "Attention: The following projects don't currently have a next action:\n"
  echo $cmd
else
  echo "No projects inactive"
fi
}

# TODO write a function that processes id by moving them from one tag to the other

# aliases
alias t='task'
alias ta='task add'

# Reports Aliases
alias tt='clear; task +next list'
alias inbox='clear; task +inbox list'

# Collection
alias in='task add +inbox'
alias rd='read_and_review'
