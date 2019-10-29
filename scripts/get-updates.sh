#!/bin/sh

cp ~/.config/nixpkgs/home.nix .
cp ~/.config/nixpkgs/config.nix .
cp /etc/nixos/configuration.nix .

git add .
git commit
