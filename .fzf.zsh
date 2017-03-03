# Setup fzf
# ---------
if [[ ! "$PATH" == */home/choco/.fzf/bin* ]]; then
  export PATH="$PATH:/home/choco/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/choco/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/choco/.fzf/shell/key-bindings.zsh"

