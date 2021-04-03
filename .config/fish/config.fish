# ~/.config/fish/config.fish

starship init fish | source
alias docs='cd ~/Documents'
alias downloads='cd ~/Downloads'
alias work='cd ~/WorkBench'
alias gith='cd ~/WorkBench/GitHub'
alias dat='cd ~/WorkBench/sandbox/analysis && source ~/WorkBench/pyenvs/analysis-env/bin/activate && touch tmp.ipynb && code tmp.ipynb'
alias san='cd ~/WorkBench/sandbox'
alias python='python3'
#alias youtube-dl='python3 $(which youtube-dl)'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

set -U fish_greeting

  # Start python env for current directory 
function senv
    source ~/WorkBench/pyenvs/(basename $PWD)-env/bin/activate.fish
end
# Start analysis env for data projects
function senv_a
    source ~/WorkBench/pyenvs/analysis-env/bin/activate.fish
end
# Create python env and place in pyenvs folder
function cenv
    python3 -m venv ~/WorkBench/pyenvs/(basename $PWD)-env
    source ~/WorkBench/pyenvs/(basename $PWD)-env/bin/activate.fish
end
