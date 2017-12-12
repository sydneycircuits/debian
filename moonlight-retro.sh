#!/bin/bash

echo -e "\n*********************************************************"
echo -e "Sydney Circuits Moonlight Script for RetroPie v1.7.12.12"
echo -e "***********************************************************\n"
echo -e "\nThis installation must be run as user: Pi\n"
echo -e "Select an option:"
echo -e " * 1: Install Moonlight > Pair > Install Scripts > Install Menus"
echo -e " * 2: Install Launch Scripts"
echo -e " * 3: Remove Launch Scripts"
echo -e " * 4: Add 480p Launch Scripts"
echo -e " * 5: New Pair or Re Pair Moonlight with PC"
echo -e " * 6: Exit this installer"
echo -e " * 7: Refresh SYSTEMS Config File"


read NUM
case $NUM in
	1)
		echo -e "\nSTAGE ONE: Include Moonlight in Apt Sources"
		echo -e "****************************************\n"

		if grep -q "deb http://archive.itimmer.nl/raspbian/moonlight jessie main" /etc/apt/sources.list; then
			echo -e "NOTE: Moonlight Source Exists - Skipping"
		else
			echo -e "Installing Moonlight to Sources.list"
			echo "deb http://archive.itimmer.nl/raspbian/moonlight jessie main" >> /etc/apt/sources.list
		fi

		echo -e "\n**** STAGE ONE Complete!!!! ****"

		echo -e "\nSTAGE TWO: Retrieve and install GPG keys"
		echo -e "****************************************\n"

		if [ -f /home/pi/itimmer.gpg ]
		then
			echo -e "NOTE: GPG Key Exists - Skipping"
		else
			wget http://archive.itimmer.nl/itimmer.gpg
			chown pi:pi /home/pi/itimmer.gpg
			apt-key add itimmer.gpg
		fi

		echo -e "\n**** STAGE TWO Complete!!!! ****"

		echo -e "\nSTAGE THREE: Updating Packages"
		echo -e "**************************\n"
		apt-get update -y
		echo -e "\n**** STAGE THREE Complete!!!! ****"

		echo -e "\nSTAGE FOUR: Installing Moonlight"
		echo -e "*****************************\n"
		apt-get install moonlight-embedded -y
		echo -e "\n**** STAGE FOUR Complete!!!! ****"

		echo -e "\nSTAGE FIVE: Pair Moonlight with PC"
		echo -e "**********************************\n"
		echo -e "After you have entered your STEAM PC's IP Address below, you will be given a PIN"
		echo -e "Enter this on your STEAM PC to pair with Moonlight. \n"
		read -p "Enter your STEAM PC's IP Address here :`echo $'\n> '`" ip
		sudo -u pi moonlight pair $ip
		echo -e "\n**** STAGE FIVE Complete!!!! ****"

		echo -e "\nSTAGE SIX: Create STEAM Menu for RetroPie"
		echo -e "*****************************************\n"

		if [ -f /home/pi/.emulationstation/es_systems.cfg ]
		then
			echo -e "Removing Duplicate Systems File"
			rm /home/pi/.emulationstation/es_systems.cfg
		fi

		echo -e "Copying Systems Config File"
		cp /etc/emulationstation/es_systems.cfg /home/pi/.emulationstation/es_systems.cfg

		if grep -q "<platform>steam</platform>" /home/pi/.emulationstation/es_systems.cfg; then
			echo -e "NOTE: Steam Entry Exists - Skipping"
		else
			echo -e "Adding Steam to Systems"
			sudo sed -i -e 's|</systemList>|  <system>\n    <name>steam</name>\n    <fullname>Steam</fullname>\n    <path>~/RetroPie/roms/moonlight</path>\n    <extension>.sh .SH</extension>\n    <command>bash %ROM%</command>\n    <platform>steam</platform>\n    <theme>steam</theme>\n  </system>\n</systemList>|g' /home/pi/.emulationstation/es_systems.cfg
		fi
		echo -e "\n**** STAGE SIX Complete!!!! ****"

		echo -e "\nSTAGE SEVEN: Create 1080p+720p Launch Scripts for RetroPie"
		echo -e "**********************************************************\n"

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
		echo -e "\n**** STAGE SEVEN Complete!!!! ****"

		echo -e "\nSTAGE EIGHT: Creating file permissions for user: Pi"
		echo -e "********************************************************\n"

		echo -e "Changing File Permissions"
		chown -R pi:pi /home/pi/RetroPie/roms/moonlight/
		chown pi:pi /home/pi/.emulationstation/es_systems.cfg

		echo -e "\n**** STAGE EIGHT Complete!!!! ****\n"
		echo -e "Moonlight should now be installed on your Retropie."
		echo -e "Sydney Circuits recommends a system reboot now."
		echo -e "\nIf you don't want to reboot your Retropie?, press N\n"

		read -p "Reboot Now (y/n)?" choice
		case "$choice" in
		  y|Y ) shutdown -r now;;
		  n|N ) cd /home/pi
		  ./moonlight.sh
		  ;;
		  * ) echo "invalid";;
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
	;;
	3)
		echo -e "\nRemove All Steam Launch Scripts"
		echo -e "***********************************\n"
		cd /home/pi/RetroPie/roms/moonlight
		rm *

		echo -e "\n**** Launch Script Removal Complete!!! ****"
		cd /home/pi
		./moonlight.sh
	;;
	4)
		echo -e "\nCreate 480p Launch Scripts for RetroPie"
		echo -e "*******************************************\n"

		echo -e "Create Script Folder"
		mkdir -p /home/pi/RetroPie/roms/moonlight
		cd /home/pi/RetroPie/roms/moonlight

		echo -e "Create 480p Scripts"

		if [ -f /home/pi/RetroPie/roms/moonlight/480p30fps.sh ]; then
			echo -e "NOTE: 480p30fps Exists - Skipping"
		else
			echo "#!/bin/bash" > 480p30fps.sh
			echo "moonlight stream -width 640 -height 480 -fps 30 "$ip"" >>  480p30fps.sh
		fi

		if [ -f /home/pi/RetroPie/roms/moonlight/480p60fps.sh ]; then
			echo -e "NOTE: 480p60fps Exists - Skipping"
		else
			echo "#!/bin/bash" > 480p60fps.sh
			echo "moonlight stream -width 640 -height 480 -fps 60 "$ip"" >>  480p60fps.sh
		fi

		echo -e "Make 480p Scripts Executable"
		chmod +x 480p30fps.sh
		chmod +x 480p60fps.sh

		echo -e "\n**** 480p Launch Scripts Creation Complete!!!!"
		cd /home/pi
		./moonlight.sh
	;;
	5)
		echo -e "\nPair Moonlight with another PC"
		echo -e "*********************************\n"

		echo -e "After you have entered your STEAM PC's IP Address below, you will be given a PIN"
		echo -e "Enter the PIN on your STEAM PC to pair with Moonlight. \n"
		read -p "Enter your STEAM PC's IP Address here :`echo $'\n> '`" ip
		sudo -u pi moonlight pair $ip

		echo -e "\n**** Pairing Process Complete!!!! ****"
		cd /home/pi
		./moonlight.sh
	;;
	6)  exit 1;;

	7)
		echo -e "\nRefresh RetroPie Systems File"
		echo -e "*****************************\n"

		if [ -f /home/pi/.emulationstation/es_systems.cfg ]
		then
			echo -e "Removing Duplicate Systems File"
			rm /home/pi/.emulationstation/es_systems.cfg
		fi

		echo -e "Copying Systems Config File"
		cp /etc/emulationstation/es_systems.cfg /home/pi/.emulationstation/es_systems.cfg

		if grep -q "<platform>steam</platform>" /home/pi/.emulationstation/es_systems.cfg; then
			echo -e "NOTE: Steam Entry Exists - Skipping"
		else
			echo -e "Adding Steam to Systems"
			sudo sed -i -e 's|</systemList>|  <system>\n    <name>steam</name>\n    <fullname>Steam</fullname>\n    <path>~/RetroPie/roms/moonlight</path>\n    <extension>.sh .SH</extension>\n    <command>bash %ROM%</command>\n    <platform>steam</platform>\n    <theme>steam</theme>\n  </system>\n</systemList>|g' /home/pi/.emulationstation/es_systems.cfg
		fi

		echo -e "\n**** Refreshing Retropie Systems File Complete!!!! ****"
		cd /home/pi
		./moonlight.sh
	;;

esac
