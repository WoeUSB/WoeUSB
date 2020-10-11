# WoeUSB
<https://github.com/WoeUSB/WoeUSB>

A Microsoft Windows® USB installation media preparer for GNU+Linux

## Features

* Support Legacy PC/UEFI booting
* Support FAT32 and NTFS filesystems
* Support using physical installtion disc or disk image as source
* Compatible with non-ASCII filenames

## Supported Windows® installation images

* Windows Vista and later
* Any language or edition variants
* Windows PE

> **NOTE:** Non official installation media may be supported, but not guaranteed

## Dependencies

The following are the dependencies that WoeUSB requires, in one way or another:

### Required

WoeUSB will not be able to function without these software installed in their proper locations:

* [GNU Bash](https://www.gnu.org/software/bash/)  
  For interpreting and executing the program logic  
  _Requires >= 4.3_
* [The GNU Core Utilities(Coreutils)](https://www.gnu.org/software/coreutils/)  
  For common Unix utilities necessary for basic operations
* [util-linux](https://github.com/karelzak/util-linux)  
  For low-level utilities interacting with storage devices, etc
* [GNU Grep](https://www.gnu.org/software/grep/) and [Gawk](https://www.gnu.org/software/gawk/)  
  For parsing necessary information out from a command output
* [The GNU Find Utilities](https://www.gnu.org/software/findutils/)  
  For enumerating files required for operation
* [GNU Parted](https://www.gnu.org/software/parted/)  
  For manipulating disk partition table and partitions
* [GNU Wget](https://www.gnu.org/software/wget/)
  For acquiring [Pete Batard](https://pete.akeo.ie/)'s [UEFI:NTFS](https://github.com/pbatard/uefi-ntfs) UEFI bootloader

### Optional

Without the following dependencies WoeUSB will still able to run, but some functionalities will be unavailable:

* [p7zip](https://sourceforge.net/projects/p7zip/)  
  For workaround the problem where the Windows 7 installation media doesn't ship their UEFI bootloader in the proper location.

## Installation

To be addressed.  For now refer [Run from source](#run-from-source).

## Run from source

WoeUSB is a program that can be run without installation(excluding its [dependencies](#dependencies)):

```sh
curl \
    --location \
    --remote-name \
    --remote-header-name \
    https://github.com/WoeUSB/WoeUSB/raw/master/sbin/woeusb
chmod +x woeusb
./woeusb --help
```

## License
GPL-3.0+

## Credits

WoeUSB is a fork of [Congelli501's WinUSB project](http://en.congelli.eu/prog_info_winusb.html).
