#!/bin/zsh

# --- shell behavior -------------------------------------------------------
setopt autocd                    # cd into directories by typing their name
setopt correct                  # autocorrect commands when possible
setopt hist_ignore_dups         # drop duplicate history entries
setopt share_history            # share history across tabs
setopt interactivecomments      # allow inline comments in the shell

HISTSIZE=5000
SAVEHIST=5000
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

autoload -U colors && colors
autoload -Uz compinit && compinit

# --- environment ----------------------------------------------------------
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less -R"

# Prefer Homebrew binaries when available.
if [[ -d /opt/homebrew/bin ]]; then
	export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:${PATH}"
fi

# pnpm/npm global binaries.
export PNPM_HOME="$HOME/Library/pnpm"
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
export PATH="$PNPM_HOME:$NPM_CONFIG_PREFIX/bin:$PATH"

# Keep language toolchains in ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"

# --- prompt ----------------------------------------------------------------
if command -v starship >/dev/null 2>&1; then
	eval "$(starship init zsh)"
fi

# --- version managers ------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
	source "$NVM_DIR/nvm.sh"
	[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
fi

if [[ -d "$HOME/.asdf" ]]; then
	export ASDF_DIR="$HOME/.asdf"
	. "$ASDF_DIR/asdf.sh"
	fpath=(${ASDF_DIR}/completions $fpath)
fi

if command -v pyenv >/dev/null 2>&1; then
	eval "$(pyenv init - --path)"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)" 2>/dev/null
fi

if command -v rbenv >/dev/null 2>&1; then
	eval "$(rbenv init -)"
fi

if command -v goenv >/dev/null 2>&1; then
	export GOENV_ROOT="$HOME/.goenv"
	export PATH="$GOENV_ROOT/bin:$PATH"
	eval "$(goenv init -)"
fi

# --- tooling integrations --------------------------------------------------
if command -v direnv >/dev/null 2>&1; then
	eval "$(direnv hook zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
	eval "$(zoxide init zsh)"
fi

if command -v fzf >/dev/null 2>&1; then
	export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git"'
	[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"
fi

if command -v kubectl >/dev/null 2>&1; then
	source <(kubectl completion zsh)
fi

if command -v eksctl >/dev/null 2>&1; then
	source <(eksctl completion zsh)
fi

# --- aliases ---------------------------------------------------------------
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias gst='git status --short --branch'
alias gco='git checkout'
alias gl='git pull'
alias gp='git push'
alias gd='git diff'
alias gcm='git commit'
alias gsw='git switch'
alias lg='lazygit'

alias k='kubectl'
alias d='docker'
alias dc='docker compose'
alias dcu='docker compose up'
alias dcd='docker compose down'

alias py='python3'
alias pip='python3 -m pip'
alias pn='pnpm'
alias ni='npm install'

alias serve='python3 -m http.server'

# --- functions -------------------------------------------------------------
mkproj() {
	if [[ -z $1 ]]; then
		echo "usage: mkproj <directory>" >&2
		return 1
	fi
	mkdir -p "$1" && cd "$1" || return 1
	git init >/dev/null 2>&1
	echo "# $(basename "$PWD")" > README.md
}

node_env() {
	local version=${1:-lts/*}
	if command -v nvm >/dev/null 2>&1; then
		nvm install "$version"
		nvm use "$version"
	fi
	if command -v pnpm >/dev/null 2>&1; then
		pnpm env use --global "$version" >/dev/null 2>&1
	fi
}

py_env() {
	local version=${1:-3.12.1}
	if command -v pyenv >/dev/null 2>&1; then
		pyenv install -s "$version"
		pyenv virtualenv "$version" "${2:-${PWD##*/}}"
		pyenv local "${2:-${PWD##*/}}"
	fi
}

# --- project navigation ----------------------------------------------------
export PROJECTS_DIR="$HOME/Projects"
if [[ -d $PROJECTS_DIR ]]; then
	function cproj() {
		command -v fzf >/dev/null 2>&1 || { echo "fzf required" >&2; return 1; }
		local target
		target=$(find "$PROJECTS_DIR" -maxdepth 2 -type d -not -path '*/.git*' | sort | fzf)
		[[ -n $target ]] && cd "$target"
	}
fi

# --- macOS tweaks ----------------------------------------------------------
export BUNDLER_EDITOR="$EDITOR"
export GPG_TTY=$(tty)

# Load custom configuration if present.
[[ -f ${ZDOTDIR:-$HOME}/.zshrc.local ]] && source ${ZDOTDIR:-$HOME}/.zshrc.local

