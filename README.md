# WoeUSB

<https://github.com/WoeUSB/WoeUSB>

A Microsoft Windows® USB installation media preparer for GNU+Linux

[![Continuous Integration(CI) Status Badge](https://cloud.drone.io/api/badges/WoeUSB/WoeUSB/status.svg "Continuous Integration(CI) Status")](https://cloud.drone.io/WoeUSB/WoeUSB) [![REUSE status](https://api.reuse.software/badge/github.com/WoeUSB/WoeUSB)](https://api.reuse.software/info/github.com/WoeUSB/WoeUSB)

![WoeUSB logo](share/woeusb/woeusb.svg "Logo of WoeUSB")

## Features

* Support Legacy PC/UEFI booting
* Support FAT32 and NTFS filesystems
* Support using physical installation disc or disk image as source

## Supported Windows® installation images

* Windows Vista and later
* Any language or edition variants
* Windows PE

> **NOTE:** Non official installation media may be supported, but not guaranteed

## Dependencies

The following are the dependencies that WoeUSB requires, in one way or another.  Refer [the wiki](https://github.com/WoeUSB/WoeUSB/wiki/Dependencies) for distro-specific information.

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
* [GNU GRUB](https://www.gnu.org/software/grub/)  
  For installing the bootstrap code used in a Legacy PC boot  
  We specifically requires modules of the i386-pc architecture, for Debian-based distributions these are provided via the grub-pc-bin package
* [GNU Parted](https://www.gnu.org/software/parted/)  
  For manipulating disk partition table and partitions
* [GNU Wget](https://www.gnu.org/software/wget/)  
  For acquiring [Pete Batard](https://pete.akeo.ie/)'s [UEFI:NTFS](https://github.com/pbatard/uefi-ntfs) UEFI bootloader
* [dosfstools](https://github.com/dosfstools/dosfstools)  
  For creating FAT filesystem in `--device` creation method
* [NTFS-3G](https://www.tuxera.com/community/open-source-ntfs-3g/)  
  For creating NTFS filesystem in `--device` creation method
* [wimlib](https://wimlib.net/)  
  For splitting install.wim Windows Imaging (WIM) archive so that archives over 4GiB can be fit in an FAT32 filesystem

### Optional

Without the following dependencies WoeUSB will still able to run, but some functionalities will be unavailable:

* [p7zip](https://sourceforge.net/projects/p7zip/)  
  For workaround the problem where the Windows 7 installation media doesn't ship their UEFI bootloader in the proper location
* [Pete Batard](https://pete.akeo.ie/)'s [UEFI:NTFS](https://github.com/pbatard/uefi-ntfs) UEFI bootloader  
  For supporting NTFS filesystems in the target USB key

## Installation

To be addressed.  For now refer [Run from source](#run-from-source).

## Run from source

WoeUSB is a program that can be run without installation(excluding its [dependencies](#dependencies)):

1. Download the program(woeusb-N.N.N.bash) from [the Releases page](https://github.com/WoeUSB/WoeUSB/releases)
1. Fix the missing executable file permission (`chmod +x path/to/woeusb-N.N.N.bash`)
1. Launch a terminal application and run the program via the appropriate path(`sudo path/to/woeusb-N.N.N.bash --help`)

## Usage

### Environment variables

The following are the environment variables that may change WoeUSB's runtime behavior:

| Variable name | Usage |
| :-: | :-- |
| RUFUS_UEFI_NTFS_VERSION | The release tag/revision of the Rufus source tree to fetch the UEFI:NTFS image from, will use a tested version by default |

## License

WoeUSB is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

WoeUSB is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with WoeUSB.  If not, see <http://www.gnu.org/licenses/>.

### Identify _otherwise specified_ licenses applicable to a certain product/development asset

If the asset is in plaintext format:

1. Check the `SPDX-License-Identifier` tag in the file's header
1. Check the [.reuse/dep5](.reuse/dep5) file from the source tree/release tree directory

If the asset is not in plaintext format:

Check the [.reuse/dep5](.reuse/dep5) file from the source tree/release tree directory

## Credits

* WoeUSB is a fork of [Colin GILLE's WinUSB project](https://web.archive.org/web/20210228120035/http://en.congelli.eu/prog_info_winusb.html), without standing on their shoulders WoeUSB will not exist in the first place
* We would like to thank [@slacka](https://github.com/slacka) for the maintenance of the WoeUSB project [when it was hosted under their namespace](https://github.com/slacka/WoeUSB), they have been extremely helpful and cooperative in many conversations that contributed in WoeUSB's improvement
* We would like to thank [Pete Batard](https://pete.akeo.ie/) for their splendid work on the [UEFI:NTFS](https://github.com/pbatard/uefi-ntfs) UEFI bootloader, which is included in WoeUSB to enable the NTFS filesystem support
* Source code contributors on GitHub:
    + [Contributors to WoeUSB/WoeUSB](https://github.com/WoeUSB/WoeUSB/graphs/contributors)
    + [Contributors to slacka/WoeUSB](https://github.com/slacka/WoeUSB/graphs/contributors)
* Everyone who have contributed to WoeUSB in one way or another but we're unable to enumerate them due to our ignorance
