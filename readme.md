Clone the repository and create symbolic links.

```bash
export CODE_PATH=/home/char/projects/personal/code

## MacBook and Linux
ln -s $CODE_PATH/dot-files/zsh/.zshrc ~/.zshrc
ln -s $CODE_PATH/dot-files/tmux/.tmux.conf ~/.tmux.conf
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
ln -s $CODE_PATH/dot-files/nvim/* ~/.config/nvim/
ln -s $CODE_PATH/dot-files/zsh-theme/minimal-char.zsh-theme ~/.oh-my-zsh/themes/minimal-char.zsh-theme
ln -s $CODE_PATH/dot-files/switch-yubi-gpg.sh /usr/local/bin/

## Only for linux
ln -s $CODE_PATH/dot-files/i3wm/i3/config ~/.config/i3/config
ln -s $CODE_PATH/dot-files/polybar/* ~/.config/polybar/
ln -s $CODE_PATH/dot-files/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -s $CODE_PATH/dot-files/zsh-theme/minimal-char.zsh-theme ~/.oh-my-zsh/themes/minimal-char.zsh-theme
## Symbolic links to use pass from the dmenu. 
ln -s /usr/bin/passmenu-otp /usr/bin/potp
ln -s /usr/bin/passmenu /usr/bin/pw

## Use gpg with yubi:
gpg --import charlie-gpg-public.asc
gpg --edit-key <ID>
> trust 

https://github.com/drduh/YubiKey-Guide
```

