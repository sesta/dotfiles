# emacs ライクな操作を有効にる
bindkey -e

# 自動補完を有効にする
autoload -U compinit; compinit

# 大文字子文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ディレクトリに cd する
setopt auto_cd

# 2つ上、3つ上にも移動できるようにする
alias ...='cd ../..'
alias ....='cd ../../..'

# cd した先のディレクトリをディレクトリスタックに追加する
setopt auto_pushd

# pushd したとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
setopt pushd_ignore_dups

# 拡張 glob を有効にする
setopt extended_glob

# コマンド関連
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups
setopt share_history

# コマンド履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# <Tab> を押すと候補からパス名を選択できるようになる
zstyle ':completion:*:default' menu select=1

# 単語の一部として扱われる文字のセットを指定する
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# ls の結果の色を変更
export LSCOLORS=gxfxcxdxbxegedabagacad

# 色を使う
setopt prompt_subst

# PROMPT
autoload -U promptinit; promptinit
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz is-at-least

zstyle ":vcs_info:*" enable git svn hg bzr
zstyle ":vcs_info:*" formats "(%s)-[%b]"
zstyle ":vcs_info:*" actionformats "(%s)-[%b|%a]"
zstyle ":vcs_info:(svn|bzr):*" branchformat "%b:r%r"
zstyle ":vcs_info:bzr:*" use-simple true

zstyle ":vcs_info:*" max-exports 6

if is-at-least 4.3.10; then
    zstyle ":vcs_info:git:*" check-for-changes true # commitしていないのをチェック
    zstyle ":vcs_info:git:*" stagedstr "%F{yellow}+ "
    zstyle ":vcs_info:git:*" unstagedstr "%F{red}* "
    zstyle ":vcs_info:git:*" formats "%c%u(%b)"
    zstyle ":vcs_info:git:*" actionformats "%c%u(%s)-[%b|%a]"
fi

function vcs_prompt_info() {
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && echo -n " %{$fg[white]%}$vcs_info_msg_0_%f"
}

PROMPT='%F{green}%n@%m: '
PROMPT+='%F{cyan}%~%f '
PROMPT+="\$(vcs_prompt_info)"
PROMPT+='
'
PROMPT+='$ '

RPROMPT="[%*]"

# ls alias
alias ls="ls -G"
alias l="ls -la"
alias la="ls -la"
alias l1="ls -1"

# sesta alias
alias vi="vim"
alias dev="cd ~/dev"
alias tree="tree -L 3 -a -I 'node_modules|.git|.cache|.DS_Store' -N"
alias routine="brew upgrade && brew doctor && npm i -g npm"

