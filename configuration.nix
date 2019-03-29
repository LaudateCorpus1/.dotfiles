{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set up networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Enables wireless support via networkmanager

  # Select internationalisation properties.
  i18n = {
    consoleFont = "latarcyrheb-sun32";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # List packages installed in system profile.
  environment = {
    systemPackages = with pkgs; [
      # basic
      wget vim

      # debug
      pastebinit

      # system
      networkmanagerapplet fontconfig-ultimate 

      # control
      light # must be installed in configuration.nix (see use below)
    ];
  };

  # setuid wrapper for backlight
  programs.light.enable = true;

  # List services that you want to enable:
  services = {
    openssh.enable = true;
    autorandr.enable = true; # automatically change xrandr profiles on display change
    
    # Enable the X11 windowing system
    xserver = {
      enable = true;
      autorun = true;
      dpi = 192;

      # support external monitors via DisplayPort in addition to the default
      # screen eDP (use `xrandr` to list)
      xrandrHeads = [ "eDP" "DisplayPort-0" ];

      desktopManager = {
        xterm.enable = false;
        default = "none";
      };
      
      displayManager.lightdm = {
        enable = true;
        autoLogin.enable = true;
        autoLogin.user = "trh";
      };

      windowManager = {
        default = "i3";
        i3.enable = true;
      };

      # Enable touchpad support
      libinput = {
        enable = true;
        naturalScrolling = true;
      };
    };
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fontconfig.ultimate.enable = true;
    fontconfig.ultimate.preset = "osx";
  
    fonts = with pkgs; [
      hasklig
      source-code-pro
      overpass
      nerdfonts
    ];
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account.
  users.extraUsers.trh = {
    isNormalUser = true;
    group = "users";
    extraGroups = [ "wheel" "networkmanager" ];
    createHome = true;
    uid = 1000;
  };

  # Allow unfree packages system-wide. To allow access to unfree packages in nix-env, also set:
  # ~/.config/nixpkgs/config.nix to { allowUnfree = true; }
  nixpkgs.config = { 
    allowUnfree = true;
  };

  system.stateVersion = "18.09"; # be *very* careful about changing this
}
