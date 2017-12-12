#!/bin/bash

echo -e "\n**********************************************************"
echo -e "Welcome to the Sydney Circuits Linux Update Tool V1.0.71010"
echo -e "************************************************************\n"

echo -e "Select an option:"
echo -e " * 1: Update         --- Synchronises the package index with sources.list."
echo -e " * 2: Upgrade        --- Installs the newest version of all local packages."
echo -e " * 3: Dist-Upgrade   --- Upgrade with 'Smart Conflict Resolution'."
echo -e " * 4: Future Features"



read NUM
case $NUM in
	1)
		echo -e "\nSyncrhronising packages with sources.list"
		echo -e "****************************************\n"

	  sudo apt-get update -y
		echo -e "\nSyncrhronised...\d"

		esac

	;;

	2)
		echo -e "\nCreate 1080p + 720p Launch Scripts for RetroPie"
		echo -e "***********************************************\n"

		echo -e "Create Script Folder"
		mkdir -p /home/pi/RetroPie/roms/moonlight
		cd /home/pi/RetroPie/roms/moonlight

		echo -e "Create Scripts"
		if [ -f /home/pi/RetroPie/roms/moonlight/720p30fps.sh ]; then
			echo -e "NOTE: 720p30fps Exists - Skipping"
		else
			echo "#!/bin/bash" > 720p30fps.sh
			echo "moonlight stream -720 -fps 30 "$ip"" >>  720p30fps.sh
		fi

		if [ -f /home/pi/RetroPie/roms/moonlight/720p60fps.sh ]; then
			echo -e "NOTE: 720p60fps Exists - Skipping"
		else
			echo "#!/bin/bash" > 720p60fps.sh
			echo "moonlight stream -720 -fps 60 "$ip"" >>  720p60fps.sh
		fi

		if [ -f /home/pi/RetroPie/roms/moonlight/1080p30fps.sh ]; then
			echo -e "NOTE: 1080p30fps Exists - Skipping"
		else
			echo "#!/bin/bash" > 1080p30fps.sh
			echo "moonlight stream -1080 -fps 30 "$ip"" >>  1080p30fps.sh
		fi

		if [ -f /home/pi/RetroPie/roms/moonlight/1080p60fps.sh ]; then
			echo -e "NOTE: 1080p60fps Exists - Skipping"
		else
			echo "#!/bin/bash" > 1080p60fps.sh
			echo "moonlight stream -1080 -fps 60 "$ip"" >>  1080p60fps.sh
		fi

		echo -e "Make Scripts Executable"
		chmod +x 720p30fps.sh
		chmod +x 720p60fps.sh
		chmod +x 1080p30fps.sh
		chmod +x 1080p60fps.sh

		echo -e "\n**** 1080p + 720p Launch Scripts Creation Complete!!!! ****"
		cd /home/pi
		./moonlight.sh

				esac
	;;

	3)
		echo -e "\nRemove All Steam Launch Scripts"
		echo -e "***********************************\n"
		cd /home/pi/RetroPie/roms/moonlight
		rm *

		echo -e "\n**** Launch Script Removal Complete!!! ****"
		cd /home/pi
		./moonlight.sh

		esac
	;;

	4)
		echo -e "\nPackage update and upgrade"
		echo -e "*******************************************\n"

		echo -e "Update Stage"
		sudo apt-get update -y
		echo -e "Upgrade Stage"
    sudo apt-get upgrade -y

		echo -e "\n***********************************"
		echo -e "WE RECOMMEND YOU REBOOT YOUR DEVICE"
		echo -e "*************************************\n"

	;;

esac
