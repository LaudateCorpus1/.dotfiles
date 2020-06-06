{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Include configuration for Macbook Pro 2015
      <nixos-hardware/apple/macbook-pro/12-1>
    ];

  boot = {
    # Ensure the exfat file type is supported when loading USB devices
    supportedFilesystems = [ "exfat" ];

    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  # Set up networking
  networking = {
    hostName = "nixos";

    # temporary while testing functional-monorepo
    extraHosts = ''
      192.168.56.107 hydra.functionalmonorepo.com
    '';

    # Enables wireless support via networkmanager
    networkmanager = {
      enable = true;
    };
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  # for larger font sizes on system load
  console.font = "latarcyrheb-sun32";
  console.keyMap = "dvorak";

  time.timeZone = "America/Los_Angeles";

  environment = {
    variables.EDITOR = "vi";

    # List packages installed in system profile.
    systemPackages = with pkgs; [
      # basic
      wget lsof vim

      # services
      light powertop networkmanagerapplet
    ];
  };

  # Wrapper for backlight. Must enable hardware.brightness.ctl and add
  # user to the "video" group as well.
  programs.light.enable = true;

  powerManagement = {
    # run powertop --auto-tune on startup
    powertop.enable = true;
  };

  # Virtualbox is generally used in headless mode
  virtualisation.virtualbox = {
    host.enable = true;
    host.headless = true;
  };

  # List services that you want to enable:
  services = {
    openssh.enable = true;

    # automatically change xrandr profiles on display change
    autorandr.enable = true;

    # bluetooth control
    blueman.enable = true;

    # monitor and manage CPU temp, throttling as needed
    thermald.enable = true;

    # monitor and control Macbook Pro fans
    mbpfan = {
      # see mbpfan.nix file in nixpkgs for extra config options
      enable = true;
    };

    # Enable dbus + dconf to manage system dialogs
    dbus = {
      packages = with pkgs; [ gnome3.dconf ];
    };

    # Remap what happens on power key press so it suspends rather than
    # shutting don immediately
    logind = {
      extraConfig = ''
        HandlePowerKey=suspend
      '';
    };

    # Enable printing with Brother drivers
    printing = {
      enable = true;
      drivers = with pkgs; [ gutenprint gutenprintBin brlaser ];
    };

    postgresql = {
      enable = true;
      package = pkgs.postgresql_11;
      enableTCPIP = true;

      authentication = ''
        local all all trust
        host all all 0.0.0.0/0 trust
      '';
    };

    # Enable the X11 windowing system
    xserver = {
      enable = true;
      autorun = true;
      dpi = 192;

      # support external monitors via DisplayPort in addition to the
      # default screen eDP (use `xrandr` to list)
      xrandrHeads = [ "eDP" "DisplayPort-0" ];

      desktopManager = {
        xterm.enable = false;
      };

      displayManager.defaultSession = "none+i3";

      displayManager.lightdm = {
        enable = true;
        autoLogin.enable = true;
        autoLogin.user = "trh";
      };

      windowManager = {
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

    fontconfig = {
      enable = true;
      antialias = true;
      useEmbeddedBitmaps = true;

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
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };

    bluetooth.enable = true;
  };

  # Define a user account.
  users.extraUsers.trh = {
    isNormalUser = true;
    group = "users";
    extraGroups = [ "wheel" "networkmanager" "video" ];
    createHome = true;
    uid = 1000;
  };

  # Allow unfree packages system-wide. To allow access to unfree packages
  # in nix-env, also set:
  #
  # ~/.config/nixpkgs/config.nix to { allowUnfree = true; }
  nixpkgs.config = {
    allowUnfree = true;
  };

  # don't change this
  system.stateVersion = "18.09";
}
