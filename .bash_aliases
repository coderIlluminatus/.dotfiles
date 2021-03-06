alias r="ranger"
alias h="htop"

alias cfa="$GUI_EDITOR ~/.bash_aliases"
alias cfb="$GUI_EDITOR ~/.bashrc"
alias cfk="$GUI_EDITOR ~/.config/kitty/kitty.conf"
alias cfi="$GUI_EDITOR ~/.config/i3/config"
alias cfis="$GUI_EDITOR ~/.i3status.conf"
alias cfp="$GUI_EDITOR ~/.profile"
alias cfp10k="$EDITOR ~/.p10k.zsh"
alias cfr="$GUI_EDITOR ~/.config/ranger/rc.conf"
alias cfri="$GUI_EDITOR ~/.config/ranger/rifle.conf"
alias cfssh="$GUI_EDITOR ~/.ssh/config"
alias cftc="$GUI_EDITOR ~/.config/tmux/tmux.conf"
alias cfv="$GUI_EDITOR ~/.vimrc"
alias cfvp="$GUI_EDITOR ~/.vim/vimplugins"
alias cfx="$GUI_EDITOR ~/.Xresources"
alias cfz="$GUI_EDITOR ~/.zshrc"

alias vcfa="$EDITOR ~/.bash_aliases"
alias vcfb="$EDITOR ~/.bashrc"
alias vcfk="$EDITOR ~/.config/kitty/kitty.conf"
alias vcfi="$EDITOR ~/.config/i3/config"
alias vcfis="$EDITOR ~/.i3status.conf"
alias vcfp="$EDITOR ~/.profile"
alias vcfp10k="$EDITOR ~/.p10k.zsh"
alias vcfr="$EDITOR ~/.config/ranger/rc.conf"
alias vcfri="$EDITOR ~/.config/ranger/rifle.conf"
alias vcfssh="$EDITOR ~/.ssh/config"
alias vcftc="$EDITOR ~/.config/tmux/tmux.conf"
alias vcfv="$EDITOR ~/.vimrc"
alias vcfvp="$EDITOR ~/.vim/vimplugins"
alias vcfx="$EDITOR ~/.Xresources"
alias vcfz="$EDITOR ~/.zshrc"

alias ga="cd ~/Audiobooks"
alias gb="cd ~/Ebooks"
alias gd="cd ~/Documents"
alias gD="cd ~/Downloads"
alias gm="cd ~/Movies"
alias gmb="cd ~/Movies/Bengali"
alias gme="cd ~/Movies/English"
alias gmh="cd ~/Movies/Hindi"
alias gmi="cd ~/Movies/International"
alias gt="cd ~/TV"
alias gw="cd ~/work"

alias ma='f() { mv $1 ~/Audiobooks }; f'
alias mb='f() { mv $1 ~/Ebooks }; f'
alias md='f() { mv $1 ~/Documents }; f'
alias mD='f() { mv $1 ~/Downloads }; f'
alias mm='f() { mv $1 ~/Movies }; f'
alias mmb='f() { mv $1 ~/Movies/Bengali }; f'
alias mme='f() { mv $1 ~/Movies/English }; f'
alias mmh='f() { mv $1 ~/Movies/Hindi }; f'
alias mmi='f() { mv $1 ~/Movies/International }; f'
alias mt='f() { mv $1 ~/TV }; f'
alias mw='f() { mv $1 ~/work }; f'

alias ya='f() { cp $1 ~/Audiobooks }; f'
alias yb='f() { cp $1 ~/Ebooks }; f'
alias yd='f() { cp $1 ~/Documents }; f'
alias yD='f() { cp $1 ~/Downloads }; f'
alias ym='f() { cp $1 ~/Movies }; f'
alias ymb='f() { cp $1 ~/Movies/Bengali }; f'
alias yme='f() { cp $1 ~/Movies/English }; f'
alias ymh='f() { cp $1 ~/Movies/Hindi }; f'
alias ymi='f() { cp $1 ~/Movies/International }; f'
alias yt='f() { cp $1 ~/TV }; f'
alias yw='f() { cp $1 ~/work }; f'

alias w='f() { cd ~/work/$1 }; f'
alias wcl='f() { git clone git@github.com:$(git config --get credential.https://github.com.username)/$1.git ~/work/$1 }; f'

alias tmux='TERM=screen-256color tmux -f ~/.config/tmux/tmux.conf'
alias dev='f() { chmod 777 ~/.config/tmux/$1 && ~/.config/tmux/$1 }; f'

pacman() {
    case $1 in
        -S | -D | -S[^sih]* | -R* | -U*)
            /usr/bin/sudo /usr/bin/pacman "$@" ;;
    *)      /usr/bin/pacman "$@" ;;
    esac
}
alias pac='pacman -S'
alias pacu='pacman -Syu'
alias pacr='pacman -Rs'
alias pacs='pacman -Ss'
alias paci='pacman -Si'
alias paclo='pacman -Qdt'
alias pacro='paclo && sudo pacman -Rns $(pacman -Qtdq)'
alias pacc='pacman -Scc'
alias paclf='pacman -Ql'

alias attach='tmux attach-session -t'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vims='f() { vim -S ~/.vim/session/$1.vim }; f'
