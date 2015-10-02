rcfiles
============
Configuration files for zsh, vim, openbox, xmonad, pytyle2 and bash.

http://unix.stackexchange.com/questions/6344/different-linux-distros-sharing-the-same-home-folder

sudo mkdir /mnt/data (create a mount point where we'll auto mount the data partition)
sudo mount /dev/sdb8 /mnt/data
sudo mkdir Documents; sudo chmod 777 Documents
sudo mkdir Downloads; sudo chmod 777 Downloads
etc etc...

Create symbolic links in home dir to the data partition instead
Remove the default directories in ~: rmdir Documents; rmdir Downloads etc etc.

ln -s /mnt/data/Documents /home/stewart/Documents
ln -s /mnt/data/Downloads /home/stewart/Downloads
etc etc...reboot

in /etc/fstab (http://www.tuxfiles.org/linuxhelp/fstab.html)
/dev/sdb8  /mnt/data  ext3  defaults  0  0 (my data partition is /dev/sdb8, auto mount it at boot to /mnt/data)

#! CrunchBang run.sh script in /mnt/data to make and link all the directories. Assumes I have a seperate data partition which is mounted via fstab onto /mnt/data
rm -rf /home/stewart/documents
rm -rf /home/stewart/downloads
rm -rf /home/stewart/images
rm -rf /home/stewart/music
rm -rf /home/stewart/videos
sudo mkdir Documents; sudo chmod 777 Documents
sudo mkdir Downloads; sudo chmod 777 Downloads
sudo mkdir Music; sudo chmod 777 Music
sudo mkdir Pictures; sudo chmod 777 Pictures
sudo mkdir Videos; sudo chmod 777 Videos
ln -s /mnt/data/Documents/ /home/stewart/documents
ln -s /mnt/data/Downloads/ /home/stewart/downloads
ln -s /mnt/data/Pictures/ /home/stewart/images
ln -s /mnt/data/Music/ /home/stewart/music
ln -s /mnt/data/Videos/ /home/stewart/videos

#! CrunchBang run.sh script. Assumes I have a seperate partition containing another Ubuntu'ish Linux system (Lubuntu on /dev/sda2 in this case) which is mounted via fstab onto /mnt/sda2
rm -rf /home/stewart/documents
rm -rf /home/stewart/downloads
rm -rf /home/stewart/images
rm -rf /home/stewart/music
rm -rf /home/stewart/videos
#sudo mkdir Documents; sudo chmod 777 Documents
#sudo mkdir Downloads; sudo chmod 777 Downloads
#sudo mkdir Music; sudo chmod 777 Music
#sudo mkdir Pictures; sudo chmod 777 Pictures
#sudo mkdir Videos; sudo chmod 777 Videos
ln -s /mnt/sda2/home/stewart/Documents/ /home/stewart/documents
ln -s /mnt/sda2/home/stewart/Downloads/ /home/stewart/downloads
ln -s /mnt/sda2/home/stewart/Pictures/ /home/stewart/images
ln -s /mnt/sda2/home/stewart/Music/ /home/stewart/music
ln -s /mnt/sda2/home/stewart/Videos/ /home/stewart/videos
ln -s /mnt/sda2/home/stewart/Pictures/ /home/stewart/pictures

# ArchBang symlink.sh file for symbolic links to the data on /dev/sda2 (my lubuntu partition)
rm -rf /home/stewart/Documents
rm -rf /home/stewart/Downloads
rm -rf /home/stewart/Music
rm -rf /home/stewart/Videos
rm -rf /home/stewart/Pictures
#sudo mkdir Documents; sudo chmod 777 Documents
#sudo mkdir Downloads; sudo chmod 777 Downloads
#sudo mkdir Music; sudo chmod 777 Music
#sudo mkdir Pictures; sudo chmod 777 Pictures
#sudo mkdir Videos; sudo chmod 777 Videos
ln -s /mnt/sda2/home/stewart/Documents/ /home/stewart/Documents
ln -s /mnt/sda2/home/stewart/Downloads/ /home/stewart/Downloads
ln -s /mnt/sda2/home/stewart/Music/ /home/stewart/Music
ln -s /mnt/sda2/home/stewart/Videos/ /home/stewart/Videos
ln -s /mnt/sda2/home/stewart/Pictures/ /home/stewart/Pictures

Crunchbang-ish:
ln -s /mnt/data/Documents/ documents
ln -s /mnt/data/Downloads/ downloads
ln -s /mnt/data/Pictures/ pictures
ln -s /mnt/data/Music music
ln -s /mnt/data/Videos videos
ln -s /mnt/data/dev dev

Lubuntu:
create /mnt/data
sudo mkdir /mnt/data
sudo chown stewart:users -R /mnt/data
fstab: 
/dev/sdb7       /mnt/data       ext3    defaults        0  0
reboot
rm -rf /home/stewart/Documents
rm -rf /home/stewart/Downloads
rm -rf /home/stewart/Music
rm -rf /home/stewart/Videos
rm -rf /home/stewart/Pictures
cd /mnt/data ...
sudo mkdir Documents; sudo chmod 777 Documents
sudo mkdir Downloads; sudo chmod 777 Downloads
sudo mkdir Music; sudo chmod 777 Music
sudo mkdir Pictures; sudo chmod 777 Pictures
sudo mkdir Videos; sudo chmod 777 Videos
sudo mkdir dev; sudo chmod 777 dev
cd ~
ln -s /mnt/data/Documents/ Documents
ln -s /mnt/data/Downloads/ Downloads
ln -s /mnt/data/Pictures/ Pictures
ln -s /mnt/data/Music Music
ln -s /mnt/data/Videos Videos
ln -s /mnt/data/dev dev


ElementaryOS (Freya)
create /mnt/data
sudo mkdir /mnt/data
sudo chown stewart:users -R /mnt/data
fstab: 
/dev/sdb6      /mnt/data       ext3    defaults        0  0
reboot
rm -rf /home/stewart/Documents
rm -rf /home/stewart/Downloads
rm -rf /home/stewart/Music
rm -rf /home/stewart/Videos
rm -rf /home/stewart/Pictures
#cd /mnt/data
#sudo mkdir Documents; sudo chmod 777 Documents
#sudo mkdir Downloads; sudo chmod 777 Downloads
#sudo mkdir Music; sudo chmod 777 Music
#sudo mkdir Pictures; sudo chmod 777 Pictures
#sudo mkdir Videos; sudo chmod 777 Videos
#sudo mkdir dev; sudo chmod 777 dev
#cd ~
ln -s /mnt/data/Documents/ Documents
ln -s /mnt/data/Downloads/ Downloads
ln -s /mnt/data/Pictures/ Pictures
ln -s /mnt/data/Music Music
ln -s /mnt/data/Videos Videos
ln -s /mnt/data/dev dev


Git
mkdir ~/dev/system; cd ~/dev/system
From weebucket on bitbucket, clone rcfiles, now have git controlled ~/dev/system/rcfiles

run lxappearance
On Lubuntu, need to install "glade-gnome" for ACYL icons to be changeable via script_gui.py
right click on application launcher (menu settings, bottom left corner)
/home/stewart/.icons/ACYL_Icon_Theme_0.9.4/scalable/alternative_icons/logos/ubuntu (Any Color You Like icon theme from Gmone look:)
http://gnome-look.org/content/show.php/?content=102435
add spacers to panel at bottom, "icons only" in Task bar (Window List) Settings

aptin zsh (chsh -s $which zsh)), logout/login
aptin vim-gtk
aptin terminator (diff profiles (-p {default,light}) for terminator,Don't show titlebar (red bar at top), greenOnBlack and orangeOnBlack)
pytyle2: aptin mercurial, aptin python-xpyb, see "installing pytyle2 on lubuntu" in gmail.
aptin xcompmgr (for true transparency)
Archey:
sudo apt-get install scrot lsb-release 
cd /tmp
wget -O archey-0.2.8.deb http://goo.gl/a9ku4
sudo dpkg -i archey-0.2.8.deb
FFMPEG compilation: https://trac.ffmpeg.org/wiki/UbuntuCompilationGuide
Ubuntu Studio Upgrade from Ubuntu: aptin ubuntustudio-graphics, ubuntustudio-video
Samba: "lubuntu samba share change hostname" Gmail.
Samba: http://ubuntuforums.org/showthread.php?t=1623346
To enable file sharing on a Lubuntu 10.10 machine, go to Preferences > Synaptic Package Manager and add the following:-
* samba
* system-config-samba
* gvfs-bin
* gvfs-backends
sudo apt-get install samba 
sudo apt-get install system-config-samba 
sudo apt-get install gvfs-bin 
sudo apt-get install gvfs-backends

To share a folder:-
Go to: Preferences > Samba (enter password when requested)
In the Samba Configuration screen:-
* File > Add Share
* use Browse... to select folder to be shared
* Tick "Visible" and (if required} "Writable"
* In the "Access" select "Allow access to everyone"

Set the Linux permissions:-
* locate the folder to share in file manager
* right click on the folder and select Properties > Permissions
* set the required permissions, e.g. Other: Read & Write (to allow anyone full access)

aptin: libreoffice
AppMenu - Preferences - Language Support (select all chinese, can see Bin's files)
Chromium (Theme and Vimium)

For pytyle2 and xcompmgr, make them start automatically at startup:
Create ~/.config/autostart
Paste icon from /usr/share/applications to ~/.config/autostart, edit as necessary.

right click panel - panel settings - appearance - select solid color (with opacity)
remove minimize all windows and desktop pager (switcher)
Digital clock settings: %a %d %b %y  %R
Panel preferences - appearance - font - yellow

sudo visudo ... at the very end, under #includedir /etc/sudoers.d
stewart ALL=(ALL) ALL, NOPASSWD: /usr/bin/pkill, NOPASSWD: /sbin/poweroff, NOPASSWD: /sbin/reboot, NOPASSWD: /usr/bin/apt-get, NOPASSWD: /usr/bin/updatedb

ln -s /mnt/data/dev/system/rcfiles/_zshrc .zshrc
ln -s /mnt/data/dev/system/rcfiles/_vim .vim
ln -s /mnt/data/dev/system/rcfiles/_vimrc .vimrc
ln -s /mnt/data/dev/system/rcfiles/_config/openbox/lubuntu-rc.xml ~/.config/openbox/lubuntu-rc.xml
ln -s /mnt/data/dev/system/rcfiles/_config/pytyle2/config.ini  ~/.config/pytyle2/config.ini
