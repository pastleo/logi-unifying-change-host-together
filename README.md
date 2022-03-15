logi-unifying-change-host-together
===

## Prerequisite

* [Python 3](https://www.python.org/downloads/)
  * [venv](https://docs.python.org/3/library/venv.html), nowadays this is usually included in python itself
* `hidapi` library
  * on Archlinux: [`pacman -S hidapi`](https://archlinux.org/packages/community/x86_64/hidapi/)
  * on Windows: go to [release page of libusb/hidapi](https://github.com/libusb/hidapi/releases), download `hidapi-win.zip`, extract `hidapi.dll` and put at `C:\Windows\System32`
  * on MacOS: [`brew install hidapi`](https://formulae.brew.sh/formula/hidapi)

## Installation

first, git clone or zip download this project and put the folder in filesystem somewhere

### Linux and MacOS

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

where `[host-index]` is 0-based

## Shortcuts

for practical daily usage, setup system shortcuts to run `change-host.sh` / `change-host.bat`

* `Meta/Win/CMD + F1` => swtich to host 1
* `Meta/Win/CMD + F2` => swtich to host 2
* `Meta/Win/CMD + F3` => swtich to host 3

### on Windows: [AutoHotKey](https://www.autohotkey.com/)

there is a `change-host-shortcut.ahk` in this project,
after installing AutoHotKey, double click on `change-host-shortcut.ahk` to start shortcut service,
create a shortcut (捷徑) at `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup` to auto start `change-host-shortcut.ahk` at boot.

### on KDE Please

open System Setting App > Shortcuts > Custom Shortcuts, create shortcuts by Edit > New > Global Shortcut > Command/URL,
give theme names `change logi host to 1/2/3`, set Trigger to `Meta + F1/F2/F3` and Action to `path/to/change-host.sh 0/1/2`

![shortcut-trigger](https://i.imgur.com/VABu8wy.png)

![shortcut-action](https://i.imgur.com/qWJbRhO.png)

### on MacOS

use built-in Automator to create 3 `Service/快速動作`:

![automator-service](https://i.imgur.com/jcL8BHS.png)

Then create shortcut on system settings > keyboard:

![macos-keyboard-shortcut](https://i.imgur.com/jcL8BHS.png)

> About [`operation not permitted` problem while using Automator](https://brianli.com/how-to-fix-automator-operation-not-permitted-error-in-macos-catalina)
