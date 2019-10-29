{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Include configuration for Macbook Pro 2015
      <nixos-hardware/apple/macbook-pro/12-1>
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set up networking
  networking = {
    hostName = "nixos";

    # Enables wireless support via networkmanager
    networkmanager = {
      enable = true; 
    };
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "latarcyrheb-sun32"; # for larger font sizes on system load
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "America/Los_Angeles";

  # List packages installed in system profile.
  environment = {
    systemPackages = with pkgs; [
      # basic
      wget vim

      # debug
      pastebinit

      # system
      light powertop networkmanagerapplet 

      # fonts
      fontconfig-ultimate 
    ];
  };

  # wrapper for backlight; 
  # NOTE: also must enable hardware.brightness.ctl and add user to the "video" group
  programs.light.enable = true;

  powerManagement = {
    # run powertop --auto-tune on startup
    powertop.enable = true;
  };

  # List services that you want to enable:
  services = {
    openssh.enable = true;

    # automatically change xrandr profiles on display change
    autorandr.enable = true;

    # auto-hibernate on low battery
    upower.enable = true;

    # monitor and manage CPU temp, throttling as needed
    # thermald.enable = true;

    # monitor and control Macbook Pro fans
    mbpfan = { 
      # see mbpfan.nix file in nixpkgs for extra config options
      enable = true;
    };

    # Enable dbus + dconf to manage system dialogs ('select download location', etc.)
    dbus = {
      packages = with pkgs; [ gnome3.dconf ];
    };

    # Remap what happens on power key press
    logind = {
      extraConfig = ''
        HandlePowerKey=suspend
      '';
    };

    # Untested: enable printing with Brother driversc
    printing = {
      enable = true;
      drivers = with pkgs; [ gutenprint gutenprintBin brlaser ];
    };
    
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
        naturalScrolling = false;
      };
    };
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;

    fontconfig = {
      enable = true;
      antialias = true;
      useEmbeddedBitmaps = true;

      ultimate = {
        enable = true;
        preset = "osx";
      };

      defaultFonts = {
        serif = [ "Source Serif Pro" "DejaVu Serif" ];
        sansSerif = [ "Source Sans Pro" "DejaVu Sans" ];
        monospace = [ "Fira Code" "Hasklig" ];
      };
    };

    fonts = with pkgs; [
      hasklig
      source-code-pro
      overpass
      nerdfonts
      fira
      fira-code
      fira-mono
    ];
  };

  # Hardware options
  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    brightnessctl.enable = true;
  };

  # Define a user account.
  users.extraUsers.trh = {
    isNormalUser = true;
    group = "users";
    extraGroups = [ "wheel" "networkmanager" "video" ];
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
