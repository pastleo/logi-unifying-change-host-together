#!/bin/bash

base_path=$(dirname "$0")
host=$1
mouse_command=0x09,0x10
keyboard_command=0x08,0x10

if [ -z "$host" ]; then
  echo "Please provide host index"
  exit 1
fi

echo "changing all devices to $host"

# You can run solaar (on linux) to see what is sent to logi unifying receiver:
#   solaar -dd config [dev-name] change-host [host-index]
#   e.g. solaar -dd config K375s change-host 2
#
# The last output line:
# ... DEBUG [MainThread] logitech_receiver.base: (13) <= w[11 01 081A 01000000000000000000000000000000]
# meaning we can send the same signal via:
# $ hidapitester --vidpid 046D:C52B ...  --send-output 0x10,0x01,0x08,0x1A,0x01,0x00,0x00
#   where 1st byte is 0x10
#         2nd byte is 0x01 => device index (1-based) registered in the receiver
# 3rd and 4th byte is 0x08,0x1A => 'change host' command code 081A for K375s keyboard
#         5th byte is 0x01 => host index (0-based) registered in the mouse/keyboard device
#
#   note: change-host command for M720 seems to be 091x, which 0x09,0x10 or 0x09,0x10 or 0x09,0x12... works
#   note: change-host command for K375s seems to be 081x, which 0x08,0x10 or 0x08,0x10 or 0x08,0x12... works

# Mosue - M720:
"$base_path/hidapitester" --vidpid 046D:C52B --usage 1 --usagePage 0xFF00 --open --length 7 --send-output 0x10,0x01,$mouse_command,0x0$host,0x00,0x00
"$base_path/hidapitester" --vidpid 046D:C52B --usage 1 --usagePage 0xFF00 --open --length 7 --send-output 0x10,0x02,$mouse_command,0x0$host,0x00,0x00
"$base_path/hidapitester" --vidpid 046D:C52B --usage 1 --usagePage 0xFF00 --open --length 7 --send-output 0x10,0x03,$mouse_command,0x0$host,0x00,0x00
"$base_path/hidapitester" --vidpid 046D:C52B --usage 1 --usagePage 0xFF00 --open --length 7 --send-output 0x10,0x04,$mouse_command,0x0$host,0x00,0x00
"$base_path/hidapitester" --vidpid 046D:C52B --usage 1 --usagePage 0xFF00 --open --length 7 --send-output 0x10,0x05,$mouse_command,0x0$host,0x00,0x00

# Keyboard - K375s:
"$base_path/hidapitester" --vidpid 046D:C52B --usage 1 --usagePage 0xFF00 --open --length 7 --send-output 0x10,0x01,$keyboard_command,0x0$host,0x00,0x00
"$base_path/hidapitester" --vidpid 046D:C52B --usage 1 --usagePage 0xFF00 --open --length 7 --send-output 0x10,0x02,$keyboard_command,0x0$host,0x00,0x00
"$base_path/hidapitester" --vidpid 046D:C52B --usage 1 --usagePage 0xFF00 --open --length 7 --send-output 0x10,0x03,$keyboard_command,0x0$host,0x00,0x00
"$base_path/hidapitester" --vidpid 046D:C52B --usage 1 --usagePage 0xFF00 --open --length 7 --send-output 0x10,0x04,$keyboard_command,0x0$host,0x00,0x00
"$base_path/hidapitester" --vidpid 046D:C52B --usage 1 --usagePage 0xFF00 --open --length 7 --send-output 0x10,0x05,$keyboard_command,0x0$host,0x00,0x00
