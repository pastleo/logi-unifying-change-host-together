logi-unifying-change-host-together
===

## Prerequisite

* [Python 3](https://www.python.org/downloads/)
  * [venv](https://docs.python.org/3/library/venv.html), nowadays this is usually included in python itself
* `hidapi` library
  * on Archlinux: [`pacman -S hidapi`](https://archlinux.org/packages/community/x86_64/hidapi/)
  * on Windows: go to [release page of libusb/hidapi](https://github.com/libusb/hidapi/releases), download `hidapi-win.zip`, extract `hidapi.dll` and put at `C:\Windows\System32`

## Installation

first, git clone or zip download this project and put the folder in filesystem somewhere

### Linux

```bash
cd path/to/this/project
python -m venv ./python
./python/bin/pip install hid
```

### Windows

```
cd path\to\this\project
python -m venv .\python
.\python\Scripts\pip.exe install hid
```

## Usage

```
path/to/change-host.sh [host-index]
path/to/change-host.bat [host-index]
```

* where `[host-index]` is 0-based
* for practical daily usage, setup a system shortcut to run this command
