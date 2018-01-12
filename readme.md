## Configuration

This configuration serves as the single source of truth for my setup on various systems. The repository can be cloned into the home directory of any system, and because it symlinks and backs up existing dotfiles, it can be used to keep everything under source control but in its proper location.

This repository is also meant to help spin up a new system right away, with common packages installed. For Linux, that might mean building Emacs from source; for Mac OS, that might mean getting Homebrew, fonts, and installing various packages.


## Simple Usage

Run basic installation:  

```sh
# Go to the home directory and clone into dotfiles
cd ~ && git clone git@github.com:thomashoneyman/dotfiles.git && cd dotfiles

# Back up existing dotfiles, write new, and symlink
./set-dotfiles.sh
```

If on Mac, move to the `terminal/` folder to set up the terminal and fonts.


## Extended Usage

**Migrate dotfiles with the `set-dotfiles.sh` script.**
This script will copy over all files in this repository to the home directory and back up any existing ones with the extension `.old`. All dotfiles will be symlinked to the `dotfiles` folder, so it's best to maintain that folder in the home directory so it can remain under version control.


## TODO  

**Install common system necessities with the `install-mac.sh` or `install-linux.sh` scripts.**
It's necessary to split these into two similar scripts to handle the different package managers available on each system. Example software usually installed includes:

- Editors like Emacs or Neovim
- Package managers like Homebrew
- Plugin managers like Vim Plug
- Language toolchains like Haskell, Rust, and PureScript
- [Mac Only] Powerline fonts like Hasklig and Meslo

Some of these will require sudo and/or password permissions so it may not be possible to do everything in one script. Still, I should try.

**If necessary, complete setup by copying over the `terminal` folder and installing fonts.**
These are not necessary for systems I'll be SSH-ing into, but _are_ necessary for my base system in order to have a usable terminal. I expect Mac OS for these. This includes fonts, themes, colors, profile settings, and so on.


## If installing vim...

NOTE: Currently, there isn't good Vim support for PureScript and ghc-mod sucks. This makes both editing environments poor. This also requires _way_ more setup than Spacemacs.

**At minimum:**  
Install necessary software:
```sh
# Install neovim
brew install neovim

# Install Vim Plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
Then, open any window in vim and use the `:PlugInstall` command to install plugins.


**Other Notes:**  
Syntax checking is performed using [Ale](https://github.com/w0rp/ale). This requires installing the actual checkers necessary. For my use cases, that includes:

- Rust: [rls](https://github.com/rust-lang-nursery/rls), [rustc](https://www.rust-lang.org/en-US/), [rustfmt](https://github.com/rust-lang-nursery/rustfmt) (Cargo needs special setup; see docs).
- Make: [checkmake](https://github.com/mrtazz/checkmake)
- Bash: [shellcheck](https://www.shellcheck.net/), [shfmt](https://github.com/mvdan/sh)
- Docker: [hadolint](https://github.com/lukasmartinelli/hadolint)
- Sass: [sass-lint](https://www.npmjs.com/package/sass-lint), [stylelint](https://github.com/stylelint/stylelint)


**Actions**  

Note: everything noted below is already in the path in .bashrc

**Haskell layer:**
- [Stack](https://get.haskellstack.org/)
- [ghc-mod](https://github.com/DanielG/ghc-mod)
- [hlint](https://hackage.haskell.org/package/hlint)
- [hfmt](https://github.com/danstiner/hfmt)

```sh
# Should be in home at all times
cd ~

# Install Stack
curl -sSL https://get.haskellstack.org/ | sh

# Install compiler
stack setup

# Install with stack (must be in home directory!)
# Note: Also ensure the ghc-mod plugin is enabled in vim:
# Plug 'eagletmt/ghcmod-vim', {'for': 'haskell'}
stack install hlint hfmt

# !NOTE! In each project, run this command (but not globally)
stack build ghc-mod && stack build intero
```

**Python Layer**
- [flake8](http://flake8.pycqa.org/en/latest/)
- [isort](https://github.com/timothycrosley/isort)
- [pycodestyle](https://github.com/PyCQA/pycodestyle)
- [python-language-server](https://github.com/palantir/python-language-server)
- [pylint](https://www.pylint.org/)
- [yapf](https://github.com/google/yapf)

```sh
python -m pip install flake8
pip install isort pycodestyle python-language-server pylint yapf
```

**Javascript Layer**
- [eslint](https://eslint.org/)
- [jshint](http://jshint.com/)

```sh
# If I want it globally...
npm install -g jshint

# !NOTE! Best done per-project.
npm install --save-dev jshint
npm install --save-dev eslint
./node_modules/.bin/eslint --init
```

**YAML Layer**  
- [yamllint](https://yamllint.readthedocs.io/en/latest/)

```sh
# Mac OS
brew install python
sudo pip install yamllint

# Ubuntu
sudo apt-get install yamllint
```

**Vim Layer**
- [vint](https://github.com/Kuniwak/vint)

```sh
# Mac OS
brew install python
pip install vim-vint

# Ubuntu
sudo apt-get install python2.7
pip install vim-vint
```
