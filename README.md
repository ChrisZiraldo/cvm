
# Cmake Version Manager
![Platforms](https://img.shields.io/badge/Platforms-OSX%20%7C%20Linux-blue)

cvm is a command line tool that downloads a specific cmake version and sets it as your active version. When you want to change versions just run the command again and cvm will handle downloading and switching active versions.

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
##### List available versions:
```
cvm list
```

##### Change version:
```
cvm <cmake version>
```


## Uninstall
Remove source from profile and delete the .cvm folder in your home directory.