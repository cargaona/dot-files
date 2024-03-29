#!/usr/bin/env bash
dir="$HOME/.config/polybar"
themes=(`ls --hide="launch.sh" $dir`)

launch_bar() {
	# Terminate already running bar instances
	killall -9 -q polybar

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

	# Launch the bar
	if [[ "$style" == "hack" || "$style" == "cuts" ]]; then
		polybar -q top -c "$dir/$style/config.ini" &
		polybar -q bottom -c "$dir/$style/config.ini" &
	elif [[ "$style" == "pwidgets" ]]; then
		bash "$dir"/pwidgets/launch.sh --main
    fi 
    if type "xrandr"; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do MONITOR=$m polybar -q main -c "$dir/$style/config.ini" --reload & done
	else
		polybar -q main -c "$dir/$style/config.ini" &	
	fi
} 

if [[ "$1" == "--forest" ]]; then
	style="forest"
	launch_bar

else
	cat <<- EOF
	Usage : launch.sh --theme
		
	Available Themes :
	--blocks    --colorblocks    --cuts      --docky
	--forest    --grayblocks     --hack      --material
	--panels    --pwidgets       --shades    --shapes
	EOF
fi
