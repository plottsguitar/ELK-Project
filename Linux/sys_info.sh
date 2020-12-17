#!/bin/bash

##Variables
output=$HOME/research/sys_info.txt
IP_Info=$(ip addr | head -9 | tail -1)
x777=$(find / -type f  -perm 777 2> /dev/null)
files=('/etc/shadow' '/etc/passwd')
commands=('date' 'uname -a' 'hostname -s')

##Run as sudo
if
  [ $UID -ne 0 ]
  then
  echo "Not root.  Run script with sudo."
  exit
fi

##Create ~/research Directory
if
  [ ! -d $HOME/research ]
  then
  mkdir $HOME/research
fi

##Create New sys_info.txt File
if
  [ -f $output ]
  then
  rm $output
fi

########################################

##Title
echo -e "System Audit Script \n" >> $output

for command in {0..2}
  do
    results=$(${commands[$command]})
    echo "${commands[$command]}:" >>$output
    echo $results >> $output
    echo "" >> $output
  done

##Machine Type
echo -e "Machine Type:" >> $output
echo -e "$MACHTYPE \n" >> $output

##Ip Address
echo -e "IP Address:" >> $output
echo -e "$IP_Info \n" >> $output

##DNS Servers
echo "DNS Servers:" >> $output
cat /etc/resolv.conf >> $output

##Display Free Memory
echo -e "\nMemory Info:" >> $output
free -h >> $output

##Display CPU Usage
echo -e "\nCPU Info:" >> $output
lscpu | grep CPU >> $output

##Display Disk Usage
echo -e "\nDisk Usage:" >> $output
df -H | head -2 >> $output

##Display Users Logged In
echo -e "\nUsers Logged In: \n $(who)\n" >> $output

##List Files with 777 Permissions
echo -e "\n777 Files:" >> $output
  for line in ${x777[@]}
    do
    echo $line >> $output
  done

##List Top 10 Processes
echo -e "\nTop 10 Processes" >> $output
ps aux | awk {'print $1, $2, $3, $4, $11'} | head >> $output

##List File Permissions of Shadow/Passwd
echo -e "\nSensitive File Permissions" >> $output
  for file in ${files[@]}
    do
    ls -l $file >> $output
  done
