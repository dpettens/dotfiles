# My Arch install guide

**/!\ Always trust the official wiki than this guide**

## General documentations

- https://wiki.archlinux.org/index.php/Installation_guide
- https://wiki.archlinux.org/index.php/General_recommendations
- https://wiki.archlinux.org/index.php/System_maintenance

## Pre-installation

### 1. Set the keyboard layout

```bash
# loadkeys be-latin1
```	

### 2. Verify UEFI mode

```bash
# ls /sys/firmware/efi/efivars
```	

### 3. Connect to the Internet 

- If wireless connection

```bash
# wifi-menu
```

- Verify connection to `archlinux.org`

``` bash
# ping archlinux.org
```	

### 4. Update the system clock

```bash
# timedatectl set-ntp true
```

### 5. Partition, format and mount the disks

- Partition

```bash
# fdisk -l
```

- Format

```bash
# mkfs.ext4 /dev/sda1
```
	
- Mount

```bash
# mount /dev/sdXY /mnt
# mkdir /mnt/boot
# mount /dev/sdXZ /mnt/boot
```

- Informations
	+ Replace `X`, `Y` and `Z` by what you need

- Documentations

	+ https://wiki.archlinux.org/index.php/Partitioning
	+ https://wiki.archlinux.org/index.php/File_systems#Create_a_file_system
	
## Installation

### 1. Install base packages

```bash
# pacstrap /mnt base base-devel
# pacstrap /mnt lsb-release efibootmgr mtools dosfstools ntfs-3g exfat-utils
# pacstrap /mnt vim mc zip unzip unrar p7zip 
```

### 2. Generate a fstab file

``` bash
# genfstab -U /mnt >> /mnt/etc/fstab
```
	
### 3. Chroot into the new system

``` bash
# arch-chroot /mnt
```

### 4. Set the time zone

```bash
# ln -sf /usr/share/zoneinfo/Europe/Brussels /etc/localetime
# hwclock --systohc
```

### 5. Set the localization

```bash
# sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
# sed -i 's/#fr_BE.UTF-8 UTF-8/fr_BE.UTF-8 UTF-8/g' /etc/locale.gen
# locale-gen
# echo LANG=en_US.UTF-8 > /etc/locale.conf
# echo KEYMAP=be-latin1 > /etc/vconsole.conf
```

### 6. Basic network configuration

```bash
# echo your-hostname > /etc/hostname
# pacman -S iw wpa_supplicant dialog
```

### 7. Create the initramfs

```bash
# mkinitcpio -p linux
```

### 8. Create the user

```bash
# passwd
# useradd -m -G wheel -s /bin/bash your-username
# passwd your-username
```

### 9. Install the bootloader (systemd-boot)

- If you have a intel CPU

```bash
# pacman -S intel-ucode
```

- Install

```bash
# bootctl install
```

- Configuration

	+ See the official wiki.

- Documentations

	+ https://wiki.archlinux.org/index.php/Systemd-boot#Configuration

### 10. Reboot

```bash
# exit
# umount -R /mnt
# reboot
```

## Post-installation

### 1. Change `sudo` configuration

- Edit the config file

```bash
$ EDITOR=vim su visudo
```

- Add `Defaults rootpw`, if you want to the `root` password instead of the `user` password

- Enable `wheel` group to allow `sudo` for simple user

### 2. TODO: AUR support 

### 3. TODO: Automate the bootloader update

```bash
# AUR: systemd-boot-pacman-hook
```

### 4. NTP

- Set NTP servers

```bash
# vim /etc/systemd/timesyncd.conf
```

- Enable NTP client

```bash
# timedatectl set-ntp true
```
	
- Documentations

	+ https://wiki.archlinux.org/index.php/Time#Time_synchronization
	+ https://wiki.archlinux.org/index.php/Systemd-timesyncd
	
### 5. DNSSEC and DNSCrypt

- Documentations
	
	+ https://wiki.archlinux.org/index.php/DNSSEC
	+ https://wiki.archlinux.org/index.php/DNSCrypt
	
### 6. Resource sharing

- Documentations

	+ https://wiki.archlinux.org/index.php/Samba

### 7. TODO: CUPS

- Install cups
	
```bash
# pacman -S cups
```

- Foomatic ?

- Add `user` to `lpadmin` group ?

- Documentations
	
	+ https://wiki.archlinux.org/index.php/CUPS

## Graphical user interface

### 1. Xorg

- Install server

```bash
# pacman -S xorg-server
```
    
- Install utils
    
```bash
# pacman -S xorg-xinput xorg-xrandr
```

- Set the keymap

```bash
# localectl set-x11-keymap be
```

- Notes

	+ Install `xf86-input-libinput` is not necessary as it's an dependency of `xorg-server`;
    + For Intel graphics, installation of `xf86-video-intel` is not anymore recommanded (see ArchLinux wiki);
	+ For other graphics, see the wiki.
    

- Documentations

    + https://wiki.archlinux.org/index.php/Xorg
	+ https://wiki.archlinux.org/index.php/Xorg#Driver_installation
    + https://wiki.archlinux.org/index.php/Intel_graphics

### 2. Hardware video acceleration (Only Intel graphics)

- Install drivers

```bash
# pacman -S libva-intel-driver libvdpau-va-gl
```

- Install utils

```bash
# pacman -S libva-utils vdpauinfo
```

- Verify VA-API and VDPAU

```bash
$ vainfo
$ vdpauinfo
```

- Notes

	+ `libvdpau-va-gl` use VA-API as a backend for VDPAU.

- Documentations

	+ https://wiki.archlinux.org/index.php/Hardware_video_acceleration
	
### 3. Codecs

- Install GStreamer

```bash
# pacman -S gstreamer
```

- Install GStreamer plugins

```bash
# pacman -S gst-plugins-{base,good,bad,ugly} gst-libav
```

- Install VA-API support

```bash
# pacman -S gstreamer-vaapi
```

- Documentations

    + https://wiki.archlinux.org/index.php/GStreamer

### 4. Sound

- Install Pulseaudio

```bash
# pacman -S pulseaudio
```

- Install Pulseaudio modules

```bash
# pacman -S pulseaudio-alsa pulseaudio-bluetooth
```

- Documentations

    + https://wiki.archlinux.org/index.php/PulseAudio

### 5. Basic fonts

- Install free fonts

```bash
# pacman -S ttf-{bitstream-vera,liberation,freefont,dejavu}
```

- Install Microsoft fonts

```bash
$ yaourt -S ttf-ms-fonts
```
	
- Documentations

	+ https://wiki.archlinux.org/index.php/Fonts

### 6. Display Manager (LigthDM)

- Install LightDM

```bash
# pacman -S lightdm
```
	
- Install LightDM GTK Greeter

```bash
# pacman -S lightdm-gtk-greeter
```
	
- Change the greeter of LigthDM

```bash
[Seat:*]
...
greeter-session=lightdm-yourgreeter-greeter
```

- Enable `lightdm.service`

```bash
# systemctl enable lightdm
```

- Documentations

	+ https://wiki.archlinux.org/index.php/LightDM

### 7. Desktop Environement (Budgie)

- Install Budgie

```bash
# pacman -S budgie-desktop
# pacman -S gnome-backgrounds gnome-control-center gnome-screensaver network-manager-applet
```

- Activate NetworkManager

```bash
# systemctl enable NetworkManager
```
	
- Documentations

	+ https://wiki.archlinux.org/index.php/Budgie_Desktop

### 8. TODO: Customization

- Install Font/Theme/Icon

```bash
# pacman -S font theme icon
```

### 9. Apps

- Install basic apps

```bash
# pacman -S gnome-terminal firefox
```

- Install settings apps

```bash
# pacman -S dconf-editor paprefs system-config-printer
```

