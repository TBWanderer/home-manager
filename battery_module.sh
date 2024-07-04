capacity=$(cat /sys/class/power_supply/BAT0/capacity)
batteries=(" " " " " " " " " ")
capacities=(20 40 60 80 100)
status=$(cat /sys/class/power_supply/BAT0/status)
charging_symbol="󱐋"

if [ "$status" = "Charging" ]; then
  if [ "$capacity" -le "${capacities[0]}" ]; then
    echo "$charging_symbol $capacity% ${batteries[0]}"
  elif [ "$capacity" -le "${capacities[1]}" ]; then
    echo "$charging_symbol $capacity% ${batteries[1]}"
  elif [ "$capacity" -le "${capacities[2]}" ]; then
    echo "$charging_symbol $capacity% ${batteries[2]}"
  elif [ "$capacity" -le "${capacities[3]}" ]; then
    echo "$charging_symbol $capacity% ${batteries[3]}"
  elif [ "$capacity" -le "${capacities[4]}" ]; then
    echo "$charging_symbol $capacity% ${batteries[4]}"
  fi
else
  if [ "$capacity" -le "${capacities[0]}" ]; then
    echo "$capacity% ${batteries[0]}"
  elif [ "$capacity" -le "${capacities[1]}" ]; then
    echo "$capacity% ${batteries[1]}"
  elif [ "$capacity" -le "${capacities[2]}" ]; then
    echo "$capacity% ${batteries[2]}"
  elif [ "$capacity" -le "${capacities[3]}" ]; then
    echo "$capacity% ${batteries[3]}"
  elif [ "$capacity" -le "${capacities[4]}" ]; then
    echo "$capacity% ${batteries[4]}"
  fi
fi

