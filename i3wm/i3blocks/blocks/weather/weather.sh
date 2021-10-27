#!/bin/bash

cosa=$(curl https://wttr.in/BuenosAires\?format\=j1)
description= echo $cosa | jq -r '."current_condition"[0]."weatherDesc"[0]."value"'
temperature= echo $cosa | jq -r '."current_condition"[0]."temp_C"'
feelslike= echo $cosa |  jq -r '."current_condition"[0]."FeelsLikeC"'
msg= ${description}  $temperature  $feelslike
echo $msg
