Clone the repository and create symbolic links.

```bash
export CODE_PATH=/home/char/projects/personal/code
ln -s $CODE_PATH/dot-files/zsh/.zshrc ~/.zshrc
ln -s $CODE_PATH/dot-files/tmux/.tmux.conf ~/.tmux.conf
ln -s $CODE_PATH/dot-files/nvim/init.vim ~/.config/nvim/init.vim
ln -s $CODE_PATH/dot-files/i3wm/i3/config ~/.config/i3/config
ln -s $CODE_PATH/dot-files/polybar/* ~/.config/polybar/
ln -s $CODE_PATH/dot-files/scripts/switchAudio /usr/local/bin/
ln -s $CODE_PATH/dot-files/scripts/switchMonitorLayout /usr/local/bin/
ln -s $CODE_PATH/dot-files/scripts/calendar /usr/local/bin/
```

Symbolic links to use pass from the dmenu. 

```
ln -s /usr/bin/passmenu-otp /usr/bin/potp
ln -s /usr/bin/passmenu /usr/bin/pw
```
