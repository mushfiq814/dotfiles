# Arch Linux Install Guide
More detailed instructions in the [arch wiki](https://wiki.archlinux.org/index.php/Installation_guide). This is only for my convenience

## Pre Installation
* Obtain Arch ISO from [mirror links](https://archlinux.org/download/#download-mirrors)
* Download Rufus and put ISO in USB (or other media).
* Boot live environment

## Installation
1. Keyboard layout should already be US by default.
2. Verify Boot Mode using `ls /sys/firmware/efi/efivars`. This should output a lot of files in the `efivars` dir.
3. Connect to Internet
	
4. Partition Disks.
	* Run `fdisk -l` to list all devices
	* Use `fdisk` on the device to be used such as: `fdisk /dev/sda/`.
	* Create a GPT table using `g`
	* Add partitions as follows. Use `n` to create partition, `t` to change a partition type.
		* /dev/sda1 -> EFI System (2048 to +550M)
		* /dev/sda2 -> Linux swap (from last to +2G)
		* /dev/sda3 -> Linux filesystem (all remaining)
	* Use `w` to write the partition table
5. Create filesystems
	* For efi, `mkfs.fat -F32 /dev/sda1`
	* For swap, `mkswap /dev/sda2` and turn swap on with `swapon /dev/sda2/`
	* For linux filesystem, `mkfs.ext4 /dev/sda3`
6. Mount `sda3`
	* `mount /dev/sda3 /mnt`
7. Install kernel and other essential packages using `pacstrap`
	* `pacstrap /mnt base linux linux-firmware`
8. Generate filesystem table
	* `genfstab -U /mnt >> /mnt/etc/fstab`
9. Change root into new filesystem
	* `arch-chroot /mnt`
10. Set Timezone. Change `America/New_York` to your location.
	* `ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime`
11. Run `hwclock`
	* `hwclock --systohc`
12. Generate locales.
	* Go to `/etc/locale.gen` and uncomment the locale `en_US.UTF-8 UTF-8`
	* Generate locale by using `locale-gen`
	* Create `/etc/locale.conf` and put `LANG=en_US.UTF-8` inside
13. Network Configuration
	* populate `/etc/hostname` with name of machine such as `echo surface > /etc/hostname`
	* populate `/etc/hosts` with matching entries:
		```
		127.0.0.1      localhost
		::1            localhost
		127.0.1.1      surface.localdomain     surface
		```
14. Set root password using `passwd`
15. Create new user, password and assign groups
	* `useradd -m mushfiq`
	* `passwd mushfiq`
	* `usermod -aG wheel,audio,video,storage mushfiq`
16. Install `sudo` and update sudoers file
	* `pacman -S sudo`
	* Run `visudo`, and uncomment `%wheel ALL=(ALL) ALL`
17. Install Grub
	* `pacman -S grub`
	* `pacman -S efibootmgr dosfstools os-prober mtools`
	* `mkdir /boot/EFI`
	* `mount /dev/sda1 /boot/EFI`
	* `grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck`
	* `grub-mkconfig -o /boot/grub/grub.cfg`

Arch is installed. You can exit, unmount and reboot or shutdown using:
```sh
exit
umount -l /mnt
reboot
# OR
shutdown now
```

## Post Installation
1. Install Network Manager and enable
	* `pacman -S networkmanager`
	* `systemctl enable NetworkManager`
2. Install packages
	* `xorg-server xorg-xinit`
	* `pulseaudio pavucontrol`
	* `xf86-video-intel mesa-libgl xf86-input-libinput`
	* `i3 compton dmenu`
	* `zsh`
	* `alacritty`
	* `firefox`
	* `yay`:
		* `git clone https://aur.archlinux.org/yay-git.git`
		* `pacman -S base-devel`
		* `cd yay-git`
		* `makepkg -si`
	* Initialize X
		* `cp /etc/X11/xinit/xinitrc /home/mushfiq/.xinitrc`
