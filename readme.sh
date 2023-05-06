export CODE_PATH=$HOME/projects/personal/code

## MacBook and Linux
mkdir $HOME/.config/
ln -sf $CODE_PATH/dot-files/zsh/.zshrc ~/.zshrc
ln -sf $CODE_PATH/dot-files/tmux/.tmux.conf ~/.tmux.conf
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
mkdir $HOME/.config/nvim/
ln -sf $CODE_PATH/dot-files/nvim/* ~/.config/nvim/
ln -sf $CODE_PATH/dot-files/zsh/minimal-char.zsh-theme ~/.oh-my-zsh/themes/minimal-char.zsh-theme
mkdir ~/.config/alacritty
ln -sf $CODE_PATH/dot-files/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

## Only for linux
mkdir ~/.config/i3
ln -sf $CODE_PATH/dot-files/i3wm/i3/config ~/.config/i3/config
mkdir ~/.config/dunst
ln -sf $CODE_PATH/dot-files/dunst/frappe.conf $HOME/.config/dunst/dunstrc
mkdir ~/.config/polybar
ln -sf $CODE_PATH/dot-files/polybar/* ~/.config/polybar/
ln -sf $CODE_PATH/dot-files/autorandr ~/.config/
mkdir -p ~/.local/share/rofi/themes
ln -sf $CODE_PATH/dot-files/rofi/nord.rasi $HOME/.local/share/rofi/themes/
mkdir ~/.config/rofi
ln -sf $CODE_PATH/dot-files/rofi/config.rasi $HOME/.config/rofi/
sudo ln -sf $CODE_PATH/dot-files/xinit/xinitrc /etc/X11/xinit/xinitrc

### Use gpg with yubi:
#gpg --import charlie-gpg-public.asc
#gpg --edit-key <ID>
#> trust 
#
#https://github.com/drduh/YubiKey-Guide
#```

## Fonts
mkdir ~/.local/share/fonts/
cp ./fonts/fonts/ttf/* ~/.local/share/fonts/
