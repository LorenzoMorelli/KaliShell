#!/bin/sh
# Function to print error on stderr
echoerr() { echo "$@" 1>&2; }

# Preparing gpu hardware acceleration if requested or skipped
if [[ "$*" == *"--nvidia-gpu"* || "$*" == *"-n"* ]]; then
    echo "Installing host package for nvidia gpu..."

	if [[ -x "$(command -v ap)t" ]]; then 
		echo "Found Package Manager: apt"
		apt install nvidia-container-toolkit

	elif [[ -x "$(command -v dnf)" ]]; then
		echo "Found Package Manager: dnf"
		dnf install nvidia-container-toolkit

	elif [[ -x "$(command -v pacman)" ]]; then
		
		if ! [[ -x "$(command -v yay)" ]]; then 
			echoerr "Yay Package Manager NOT FOUND"
			echoerr "For using this script you need to install yay first."
			exit 2
		fi
		echo "Found Package Manager: yay"
		yay -Sy nvidia-container-toolkit

	else
		echoerr "System: not supported by this script"
		echoerr 'Try installing "nvidia hardware acceleration" packages by yourself and then run this script without "-n" or "--nvidia-gpu" flag'
		echoerr "In this case also consider to edit aliases manually (remove any of -b, --bash, -z and --zsh)."
		exit 1
	fi
else
	echo "Nvidia hardware acceleration: skipped"
fi

# Building Dockerfile
echo "Building image..."
# TODO implement
docker build -t lori_more/kalishell .

# Preparing aliases for shell config file
if [[ "$*" == *"--nvidia-gpu"* || "$*" == *"-n"* ]]; then
	normalAlias='alias openKaliHere="docker run -it --gpus all --rm --net='host' --name tmpKali -v $(pwd):/shared_folder lori_more/kalishell"'
	sudoAlias='alias openKaliHereSudo="docker run -it --gpus all --rm --net='host' --name tmpKali --privileged -v $(pwd):/shared_folder lori_more/kalishell"'
else
	normalAlias='alias openKaliHere="docker run -it --rm --net='host' --name tmpKali -v $(pwd):/shared_folder kalishell"'
	sudoAlias='alias openKaliHereSudo="docker run -it --rm --net='host' --name tmpKali --privileged -v $(pwd):/shared_folder kalishell"'
fi

# Add aliases to shell config file
if [[ "$*" == *"--bash"* || "$*" == *"-b"* ]]; then
	echo "Adding aliases to .bashrc..."
	echo "# Automatically genereted aliases by OpenKaliHere script" >> ~/.bashrc
	echo $normalAlias >> ~/.bashrc
	echo $sudoAlias >> ~/.bashrc
elif [[ "$*" == *"--zsh"* || "$*" == *"-z"* ]]; then
	echo "Adding aliases to .zshrc..."
	echo "# Automatically genereted aliases by OpenKaliHere script" >> ~/.zshrc
	echo $normalAlias >> ~/.zshrc
	echo $sudoAlias >> ~/.zshrc
else # default case is manual (do nothing)
	echo "Setting aliases skipped."
fi

echo "Done, enjoy ethical hacking"
exit 0
