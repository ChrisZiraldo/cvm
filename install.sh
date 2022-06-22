#!/usr/bin/env bash

platform='unknown'
unamestr=$(uname)

if [ "$unamestr" == 'Linux' ]; then
	platform='Linux'

	echo Installing jq
	sudo apt-get install jq

elif [ "$unamestr" == 'Darwin' ]; then
	platform='Darwin'

	if ! brew ls --versions jq >/dev/null; then

		echo Install Homebrew
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

		echo Validate Homebrew
		brew doctor

		echo Install Homebrew Packages
		brew install jq
	fi

fi

if [ "$platform" == 'unknown' ]; then
	echo "Currently only Linux and Darwin platforms are supported"
	exit 1
fi

url='https://raw.githubusercontent.com/ChrisZiraldo/cvm/main/cvm'

folder_name=cmake-${version}
cvm_home=${HOME}/.cvm

if [ ! -d "${cvm_home}" ]; then
	echo "creating ${cvm_home}"
	mkdir ${cvm_home}
	mkdir ${cvm_home}/"cmake-active"
fi

if [ ! -d "${cvm_home}/${folder_name}" ]; then
	pushd ${cvm_home} >/dev/null
	curl -s -L -o 'cvm' ${url}
	chmod +x 'cvm'
	popd >/dev/null
fi

if [ "${platform}" = "Darwin" ]; then
	cmake_bin=${cvm_home}/"cmake-active"/CMake.app/Contents/bin
else
	cmake_bin=${cvm_home}/"cmake-active"/bin
fi

if [[ "$PATH" != *".cvm"* ]]; then
	echo "export PATH=${cmake_bin}:${cvm_home}:\${PATH}" >${cvm_home}/cvm_source
	echo "Done! Please place the following line in your .bash_profile, .zshrc, .bashrc or .profile"
	echo
	echo "source $HOME/.cvm/cvm_source"
	echo
fi
