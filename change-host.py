import sys
import time
import hid

if len(sys.argv) < 2:
  raise ValueError("Please provide host index")

host = int(sys.argv[1])

# mouse_keyboards config:
mouse_keyboards = [
  {
    'indices': [1, 2, 3, 4, 5],
    'change_host_cmd': [0x09, 0x10], # M720
  },
  {
    'indices': [1, 2, 3, 4, 5],
    'change_host_cmd': [0x08, 0x10], # K375s
  },
]
# 'indices' is the devices index (1-based) registered in the receiver (see below for detail)
# we try all possible indices, which seems to be more stable than one accurate index

# You can run solaar (on linux) to see what is sent to logi unifying receiver:
#   solaar -dd config [dev-name] change-host [host-index]
#   e.g. solaar -dd config K375s change-host 2
#
# The last output line:
# ... DEBUG [MainThread] logitech_receiver.base: (13) <= w[11 01 081A 01000000000000000000000000000000]
# meaning we can send the same signal via:
#   dev = hid.enumerate(0x046D, 0xC52B)[0] # take the first unifying receiver for example
#   receiver = hid.Device(path = dev['path'])
#   data = bytes([0x10, 0x01, 0x08, 0x1A, 0x01, 0x00, 0x00])
#   receiver.write(data)
#     where 1st byte is 0x10
#           2nd byte is 0x01 => device index (1-based) registered in the receiver
#   3rd and 4th byte is 0x08, 0x1A => 'change host' command code 081A for K375s keyboard
#           5th byte is 0x01 => host index (0-based) registered in the mouse/keyboard device
#
#   note: change-host command for M720 seems to be 091x, which 0x09,0x10 or 0x09,0x10 or 0x09,0x12... works
#   note: change-host command for K375s seems to be 081x, which 0x08,0x10 or 0x08,0x10 or 0x08,0x12... works

print("> sleep for 0.25 seconds, preventing too fast")
time.sleep(0.25)

for dev in hid.enumerate(0x046D, 0xC52B):
  if dev['usage'] == 1 and dev['usage_page'] == 0xFF00:
    print('> opening hid device using path:', dev['path'])
    receiver = hid.Device(path = dev['path'])
    receiver.nonblocking = 1

    
    for mouse_keyboard in mouse_keyboards:
      for index in mouse_keyboard['indices']:
        data = bytes([0x10, index, *mouse_keyboard['change_host_cmd'], host, 0x00, 0x00])
        print("  writing:", data)
        receiver.write(data)

    print("  closing")
    receiver.close()
