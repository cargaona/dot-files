Clone the repository and create symbolic links.

```bash
export CODE_PATH=/home/char/projects/personal/code

## MacBook and Linux
ln -s $CODE_PATH/dot-files/zsh/.zshrc ~/.zshrc
ln -s $CODE_PATH/dot-files/tmux/.tmux.conf ~/.tmux.conf
ln -s $CODE_PATH/dot-files/nvim/init.vim ~/.config/nvim/init.vim
ln -s $CODE_PATH/dot-files/zsh-theme/minimal-char.zsh-theme ~/.oh-my-zsh/themes/minimal-char.zsh-theme

## Only for linux
ln -s $CODE_PATH/dot-files/i3wm/i3/config ~/.config/i3/config
ln -s $CODE_PATH/dot-files/polybar/* ~/.config/polybar/
ln -s $CODE_PATH/dot-files/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -s $CODE_PATH/dot-files/zsh-theme/minimal-char.zsh-theme ~/.oh-my-zsh/themes/minimal-char.zsh-theme
## Symbolic links to use pass from the dmenu. 
ln -s /usr/bin/passmenu-otp /usr/bin/potp
ln -s /usr/bin/passmenu /usr/bin/pw
```

