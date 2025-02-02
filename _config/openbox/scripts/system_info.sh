######## This is a script made
######## by 'yettenet'.
########
######## SysInfo script for OpenBox
######## v0.1
########
######## The author does not take
######## any responsibility for
######## what it might do to your
######## computer, though it's
######## improbable to do any harm.
########
######## You may share the script with
######## everyone and modify it for your
######## liking, as long as you
######## GIVE CREDIT.
########
######## To add it to Openbox, copy it to
######## your Openbox/scripts folder, which usually is at
######## ~/.config/openbox/scripts
########
######## edit your menu.xml file, which usually is at
######## ~/.config/openbox/menu.xml
######## and add the following line (in case you have the usual paths - if not, edit the path as needed):
########
########<menu execute="~/.config/openbox/scripts/sysinfo_v01-by_yettenet.script" id="sysinfo-menu" label="SysInfo"/>
########
######## Below you will find the settings
######## (the script still needs to be tested)  

########  settings

MountPoint1=$(echo /dev/sdb1)
MountPoint2=$(echo /dev/sdb6)
NetworkDevice1=$(echo eth0)
NetworkDevice2=$(echo eth1)  #Uncomment some lines to make it work!

######## /settings



User=$(whoami)
Host=$(uname -n)
System=$(uname -s)
Release=$(uname -r)
Arch=$(uname -m)

SizeMountPoint1=$(df -HlT | grep "$MountPoint1")
SizeMountPoint2=$(df -HlT | grep "$MountPoint2")

NetDev1ip=$(/sbin/ifconfig "$NetworkDevice1" | grep "inet addr:" | sed "s/.*inet addr://" | sed "s/Bcast.*//")
NetDev1down=$(/sbin/ifconfig "$NetworkDevice1" | grep bytes | sed 's/.*RX bytes:[0-9]* (//'  | sed 's/iB).*TX.*//' | sed 's/b).*TX.*//' | sed 's/).*TX.*//')
NetDev1up=$(/sbin/ifconfig "$NetworkDevice1" | grep bytes | sed 's/.*TX bytes:[0-9]* (//' | sed 's/iB)//' |sed 's/b).*//' | sed 's/).*//')

NetDev2ip=$(/sbin/ifconfig "$NetworkDevice1" | grep "inet addr:" | sed "s/.*inet addr://" | sed "s/Bcast.*//")
NetDev2down=$(/sbin/ifconfig "$NetworkDevice1" | grep bytes | sed 's/.*RX bytes:[0-9]* (//'  | sed 's/iB).*TX.*//' | sed 's/b).*TX.*//' | sed 's/).*TX.*//')
NetDev2up=$(/sbin/ifconfig "$NetworkDevice1" | grep bytes | sed 's/.*TX bytes:[0-9]* (//' | sed 's/iB)//' |sed 's/b).*//' | sed 's/).*//')

DateDate=$(date '+Date ~ %Y.%m.%d. (%a)')
DateWeek=$(date '+Week ~ %W')
DateDay=$(date '+Day ~ %j')
DateTime=$(date '+Time ~ %H:%M [%Z]')
UpTime=$(uptime | sed 's/.* up //' | sed 's/[0-9]* us.*//' | sed 's/ day, /d/' | sed 's/ days, /d /' | sed 's/:/h /' | sed 's/ min//'|  sed 's/,/m/' | sed 's/  / /') 

MemTotal=$(echo "scale = 2; ("$(cat /proc/meminfo | grep MemTotal: | awk '{print $2}' | sed 's/k//')" /1024)" | bc)
MemFree=$(echo "scale = 2; ("$(cat /proc/meminfo | grep MemFree: | awk '{print $2}' | sed 's/k//')" /1024) + ("$(cat /proc/meminfo | grep grep -m 1 Cached: | awk '{print $2}' | sed 's/k//')" /1024)" | bc)
MemUsed=$(echo "scale = 2; ("$(cat /proc/meminfo | grep MemTotal: | awk '{print $2}' | sed 's/k//')" /1024) - (("$(cat /proc/meminfo | grep MemFree: | awk '{print $2}' | sed 's/k//')" /1024) + ("$(cat /proc/meminfo | grep -m 1 Cached: | awk '{print $2}' | sed 's/k//')" /1024))" | bc)

SwpTotal=$(echo "scale = 2; ("$(cat /proc/meminfo | grep SwapTotal: | awk '{print $2}' | sed 's/k//')" /1024)" | bc)
 SwpFree=$(echo "scale = 2; ("$(cat /proc/meminfo | grep SwapFree: | awk '{print $2}' | sed 's/k//')" /1024)" | bc)
 SwpUsed=$(echo "scale = 2; ("$(cat /proc/meminfo | grep SwapTotal: | awk '{print $2}' | sed 's/k//')" /1024) - ("$(cat /proc/meminfo | grep SwapFree: | awk '{print $2}' | sed 's/k//')" /1024)" | bc)

MemUsedPercent=$(echo "scale = 2; (("$(cat /proc/meminfo | grep MemTotal: | awk '{print $2}' | sed 's/k//')" /1024) - (("$(cat /proc/meminfo | grep MemFree: | awk '{print $2}' | sed 's/k//')" /1024) + ("$(cat /proc/meminfo | grep -m 1 Cached: | awk '{print $2}' | sed 's/k//')" /1024))) / ("$(cat /proc/meminfo | grep MemTotal: | awk '{print $2}' | sed 's/k//')" /1024) *100" | bc)
SwpUsedPercent=$(echo "scale = 2; (("$(cat /proc/meminfo | grep SwapTotal: | awk '{print $2}' | sed 's/k//')" /1024) - ("$(cat /proc/meminfo | grep SwapFree: | awk '{print $2}' | sed 's/k//')" /1024)) / ("$(cat /proc/meminfo | grep SwapTotal: | awk '{print $2}' | sed 's/k//')" /1024) *100" | bc)

CPUmodel=$(cat /proc/cpuinfo | grep "model name" | sed 's/.*: //')
CPUfreq=$(cat /proc/cpuinfo | grep -m 1 "cpu MHz" | sed 's/.*: //')
CPUcache=$(cat /proc/cpuinfo | grep -m 1 "cache size" | sed 's/.*: //')


echo "<openbox_pipe_menu>"
echo "<separator label=\"$User @ $Host \"/>"
echo "<item label=\"$System $Release $Arch\"/>"

echo "<separator label = \"Filesystem ~~ Type ~~ Total ~ Used ~ Free ~ % ~ Mount   \"/>"
echo "<item label=\"$SizeMountPoint1\"/>"
echo "<item label=\"$SizeMountPoint2\"/>"

echo "<separator label=\"CPU ~ RAM ~ Swap | Used/Total     \"/>"
echo "<item label=\"RAM used: $MemUsed MiB/$MemTotal MiB ~ $MemUsedPercent%\"/>"
echo "<item label=\"Swp used: $SwpUsed MiB/$SwpTotal MiB ~ $SwpUsedPercent%\"/>"
echo "<item label=\"CPU ~ $CPUmodel\"/>"
echo "<item label=\"CPU @ $CPUfreq MHz  ~  CPU Cache: $CPUcache\"/>"

echo "<separator label = \"Network ~ "$NetworkDevice1"  \"/>"
echo "<item label=\""$NetworkDevice1" ~         ip: $NetDev1ip\"/>"
echo "<item label=\""$NetworkDevice1" ~ downloaded: "$NetDev1down"iB\"/>"
echo "<item label=\""$NetworkDevice1" ~   uploaded: "$NetDev1up"iB\"/>"

#echo "<separator label = \"Network ~ "$NetworkDevice2"  \"/>"
#echo "<item label=\""$NetworkDevice1" ~         ip: $NetDev2ip\"/>"
#echo "<item label=\""$NetworkDevice1" ~ downloaded: "$NetDev2down"iB\"/>"
#echo "<item label=\""$NetworkDevice1" ~   uploaded: "$NetDev2up"iB\"/>"

echo "<separator label = \"Date ~ Time\"/>"
echo "<item label=\"$DateDate\"/>"
echo "<item label=\"$DateWeek\"/>"
echo "<item label=\"$DateDay\"/>"
echo "<item label=\"$DateTime\"/>"
echo "<item label=\"Up ~ $UpTime\"/>"

echo "</openbox_pipe_menu>"

