# dotfiles

A surprisingly small number of files can specify an entire NixOS system. These dotfiles are a combination of the Nix system configuration file, the Home Manager configuration file, and some other small odds and ends. 

## Usage

I don't recommend you install anything via this repository. Only use it as an example configuration. If you are me, though, you can follow these steps.

#### Sync a new system 

```sh
# Go to the home directory and clone into .dotfiles
cd ~ && git clone git@github.com:thomashoneyman/.dotfiles.git && cd .dotfiles

# Sync these files to the system
./scripts/set-updates.sh

# Install the new NixOS system
nixos-rebuild switch

# Install the user environment
home-manager switch
```

#### Upstream configuration updates

```sh
# Go to the dotfiles
cd ~/.dotfiles

# Sync files
./scripts/get-updates.sh
```
