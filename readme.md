Clone the repository and create symbolic links.

```bash
export CODE_PATH=$HOME/projects/personal/code

## MacBook and Linux
ln -s $CODE_PATH/dot-files/zsh/.zshrc ~/.zshrc
ln -s $CODE_PATH/dot-files/tmux/.tmux.conf ~/.tmux.conf
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
ln -s $CODE_PATH/dot-files/nvim/* ~/.config/nvim/
ln -s $CODE_PATH/dot-files/zsh-theme/minimal-char.zsh-theme ~/.oh-my-zsh/themes/minimal-char.zsh-theme

## Only for linux
ln -sf $CODE_PATH/dot-files/i3wm/i3/config ~/.config/i3/config
ln -sf $CODE_PATH/dot-files/dunst/frappe.conf $HOME/.config/dunst/dunstrc
ln -sf $CODE_PATH/dot-files/polybar/* ~/.config/polybar/
ln -sf $CODE_PATH/dot-files/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -sf $CODE_PATH/dot-files/autorandr ~/.config/
ln -sf $CODE_PATH/dot-files/rofi/nord.rasi $HOME/.local/share/rofi/themes/

## Use gpg with yubi:
gpg --import charlie-gpg-public.asc
gpg --edit-key <ID>
> trust 

https://github.com/drduh/YubiKey-Guide
```

## Fonts
unzip ./fonts/JetBrainsMono-2.242.zip
mv ./fonts/fonts/ttf/* ~/.local/share/fonts/
