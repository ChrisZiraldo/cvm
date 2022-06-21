# Cmake Version Manager
CMake Version Manager (cvm)

`cvm` is a CMake Version Manager that downloads a specific cmake version and sets it as the active version of cmake. When you want to change versions just run the command again to switch it up!

Please feel free to add more versions to the versions.json file as you need them.

#### OSX Setup:
Please have [Homebrew](https://brew.sh/) installed and run:

`brew install jq` 

#### Linux Setup:
You will need the jq library installed:

`sudo apt-get install jq`

#### Run Script:

From terminal, type:

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ChrisZiraldo/cvm/master/cvm.sh)" -s <cmake version>`

or clone the repo and run:

`chmod +x cvm.sh`

`./cvm.sh <cmake version>`


It will download cmake versions <cmake version> into `.cvm` folder in your home directory, extract it, and move it into an "active" version folder. 

All you have to do is add this line to your .bash_profile, .zshrc, .bashrc or .profile

`source $HOME/.cvm/cvm_source`

Alternativly if you only want this sourced in one instance of a shell you can just run the source line to temporarily add it to your $PATH

