# RPM spec for WoeUSB
#
# SPDX-License-Identifier: GPL-3.0-or-later

Name:           woeusb
Version:        5.2.4
Release:        1%{?dist}
Summary:        Windows® USB installation media creator for GNU+Linux

License:        GPL-3.0-or-later
URL:            https://github.com/WoeUSB/WoeUSB
Source0:        https://github.com/WoeUSB/WoeUSB/archive/v%{version}/WoeUSB-%{version}.tar.gz

BuildArch:      noarch

BuildRequires:  gettext

# Shell interpreter
Requires:       bash >= 4.3
# Common POSIX utilities
Requires:       coreutils
Requires:       util-linux
Requires:       grep
Requires:       gawk
Requires:       findutils
# Bootloader support (Legacy BIOS)
Requires:       grub2-tools
Requires:       grub2-pc
# Disk partitioning
Requires:       parted
# Downloading UEFI:NTFS bootloader at runtime
Requires:       wget
# FAT32 filesystem creation
Requires:       dosfstools
# NTFS filesystem creation and mounting
Requires:       ntfs-3g
Requires:       ntfsprogs
# Splitting large WIM archives for FAT32
Requires:       wimlib-utils

# Windows 7 UEFI bootloader workaround
Recommends:     p7zip
# Runtime message internationalization
Recommends:     gettext

%description
WoeUSB is a command-line utility for creating Windows installation USB
drives from an existing Windows Installation DVD or its ISO image.

It supports:
  - Legacy PC and UEFI booting
  - FAT32 and NTFS target filesystems
  - Physical installation discs or disk images as source
  - Windows Vista and later (any language or edition)
  - Windows PE

%prep
%setup -q -n WoeUSB-%{version}

%build
# Compile gettext message catalogs from source .po files (if present)
for po_file in share/locale/*/LC_MESSAGES/woeusb.po; do
    [ -f "${po_file}" ] || continue
    msgfmt \
        --check \
        --output-file="${po_file%.po}.mo" \
        "${po_file}"
done

%check
bash -n sbin/woeusb

%install
# Install the main script
install -Dm755 sbin/woeusb %{buildroot}%{_sbindir}/woeusb

# Substitute the version placeholder
sed -i 's/@@WOEUSB_VERSION@@/%{version}/' %{buildroot}%{_sbindir}/woeusb

# Install man page
install -Dm644 share/man/man1/woeusb.1 %{buildroot}%{_mandir}/man1/woeusb.1
sed -i 's/@@WOEUSB_VERSION@@/%{version}/' %{buildroot}%{_mandir}/man1/woeusb.1

# Install icon
install -Dm644 share/woeusb/woeusb.svg %{buildroot}%{_datadir}/woeusb/woeusb.svg

# Install compiled message catalogs (if present)
for mo_file in share/locale/*/LC_MESSAGES/woeusb.mo; do
    [ -f "${mo_file}" ] || continue
    install -Dm644 "${mo_file}" \
        %{buildroot}%{_datadir}/"${mo_file#share/}"
done

%find_lang %{name}

%files -f %{name}.lang
%license LICENSES/GPL-3.0-or-later.txt LICENSES/LicenseRef-Fairuse.txt
%doc README.md CONTRIBUTING.md SECURITY.md
%{_sbindir}/woeusb
%{_mandir}/man1/woeusb.1*
%{_datadir}/woeusb/

