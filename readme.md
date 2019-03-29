# dotfiles

A surprisingly small number of files can specify an entire NixOS system. These dotfiles are a combination of the Nix system configuration file, the Home Manager configuration file, and some other small odds and ends. 

## Usage

You can install a NixOS system identical to mine (without secret keys) by cloning this repository. You'll need Git to do so.

```sh
# Go to the home directory and clone into dotfiles
cd ~ && git clone git@github.com:thomashoneyman/.dotfiles.git && cd .dotfiles

# Copy the files
cp home.nix ~/.config/nixpkgs/home.nix
cp config.nix ~/.config/nixpkgs/config.nix
cp configuration.nix /etc/nixos/configuration.nix

# Install the new NixOS system
nixos-rebuild switch

# Install the user environment
home-manager switch
```
