#!/bin/bash

platform='unknown'
unamestr=`uname`

if [ "$unamestr" == 'Linux' ]
then
   platform='Linux'

elif [ "$unamestr" == 'Darwin' ]
then
   platform='Darwin'

   if ! brew ls --versions jq > /dev/null; then
   	echo Please install the jq library: \`brew install jq\`
   	exit 1;
   fi
fi

if [ "$platform" == 'unknown' ]
then
	echo "Currently only Linux and Darwin platforms are supported"
	exit 1
fi

version=$1
url=$(curl -s https://raw.githubusercontent.com/ChrisZiraldo/cvm/master/versions.json | jq -r '.'\"$platform\"'[] | select(.version=='\"$version\"') | .url')

if [ -z "$url" ]
then
	echo Version not defined in "https://raw.githubusercontent.com/ChrisZiraldo/cvm/master/versions.json"
	exit 1;
fi

folder_name=cmake-${version}
file_name=${folder_name}.tar.gz

cvm_home=${HOME}/.cvm
#echo cvm_home is ${cvm_home}
if [ ! -d "${cvm_home}" ]
then
	echo "creating ${cvm_home}"
	mkdir ${cvm_home}
	mkdir ${cvm_home}/"cmake-active"
fi

if [ ! -d "${cvm_home}/${folder_name}" ]
then
	echo downloading cmake version ${version}
	echo from: ${url}
	echo to: ${cvm_home}/${file_name}
	pushd ${cvm_home} > /dev/null
	curl -L -o ${file_name} ${url}
	tar zxf ${file_name}
	tar_return_code=$?
	mv $(tar -tf ${file_name} | head -n1 | cut -d "/" -f1) ${folder_name} && rm ${file_name}
	popd > /dev/null

	if [ $tar_return_code != 0 ]
	then
		echo "Error happened when extracting archive, exiting..."
		exit $?
	fi

fi

if [ "${platform}" = "Darwin" ]
then
	pushd ${cvm_home} > /dev/null
	rm -r ${cvm_home}/"cmake-active"/CMake.app
	cp -r ${folder_name}/CMake.app ${cvm_home}/"cmake-active"
	popd > /dev/null

	cmake_bin=${cvm_home}/"cmake-active"/CMake.app/Contents/bin/
else
	#untested on Linux
	pushd ${cvm_home} > /dev/null
	rm -r ${cvm_home}/"cmake-active"/cmake
	cp -r ${folder_name}/cmake ${cvm_home}/"cmake-active"
	popd > /dev/null

	cmake_bin=${cvm_home}/"cmake-active"/bin/
fi

if [[ "$PATH" != *".cvm"* ]]; then
	echo "export PATH=${cmake_bin}:\${PATH}" > ${cvm_home}/cvm_source
	echo "Done! Please place the following line in your .bash_profile or .zshrc"
	echo 
	echo "	source $HOME/.cvm/cvm_source"
fi