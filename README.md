
# Cmake Version Manager
![Platforms](https://img.shields.io/badge/Platforms-OSX%20%7C%20Linux-blue)

cvm is a CMake Version Manager that downloads a specific cmake version and sets it as the active version of cmake. When you want to change versions just run the command again to switch it up!

Please feel free to add more versions to the versions.json file as you need them.


## Install

Paste this in a macOS Terminal or Linux shell prompt:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ChrisZiraldo/cvm/master/install.sh)"
```

After the install is completed add this line to your .bash_profile, .zshrc, .bashrc or .profile.

```
source $HOME/.cvm/cvm_source
```

## Usage

```
cvm <cmake version>
```

It will download the specified version of cmake into the .cvm folder in your home directory and set it as the current active version.


## Uninstall
Remove source from prifile and delete the .cvm folder in your home directory.