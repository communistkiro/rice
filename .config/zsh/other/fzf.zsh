# Setup fzf
# ---------
if [[ ! "$PATH" == */root/src/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/root/src/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/root/src/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/root/src/fzf/shell/key-bindings.zsh"
