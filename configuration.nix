# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).'
{ config, pkgs, lib, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./home.nix
  ];

  # Bootloader.
  boot.loader.grub = {
    enable = lib.mkDefault true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
    configurationLimit = 10;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.systemd-boot.enable = true;  

  networking.hostName = "Ping"; # Define your hostname.
  networking.wireless.enable =
    lib.mkForce false; # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable printer
  services.printing = {
    enable = true;
    drivers = [ (pkgs.callPackage ./pantum.nix { }) ];
  };

  # services.xserver = {
  #   enable = true;
  #   desktopManager.xfce = {
  #     enable = true;
  #     enableXfwm = false;
  #     noDesktop = true;
  #   };
  #   displayManager.defaultSession = "xfce+awesome";
  #   displayManager.lightdm.enable = true;
  #   displayManager.lightdm.greeter.enable = true;
  #   displayManager.lightdm.greeters.slick.enable = true;
  #   windowManager.awesome = {
  #     enable = true;
  #     luaModules = with pkgs.luaPackages; [ luarocks luadbi-mysql ];
  #   };
  # };

  # services.picom = {
  #   enable = true;
  #   package = pkgs.picom-allusive;
  #   fade = true;
  #   fadeDelta = 4;
  #   inactiveOpacity = 1;
  #   shadow = true;
  #   settings = {
  #         blur-method = "dual_kawase";
  #         blur-strength = "5";
  #         corner-radius = 15;
  #         wm-support = "awesome";
  #         animations = true;
  #         animation-stiffness = 120;
  #         animation-window-mass = 0.5;
  #         animation-dampening = 15;
  #         animation-clamping = true;
  #         animation-for-open-window = "zoom";
  #         animation-for-unmap-window = "slide-down";
  #         shadow-radius = 15;
  #         shadow-offset-x = -15;
  #         shadow-offset-y = -10;
  #         shadow-color = "#000915";
  #         fade-in-step = 0.03;
  #         fade-out-step = 0.03;
  #         rounded-corners-exclude = ["window_type = 'dock'""window_type = 'popup_menu'"];
  #   };
  #   wintypes = {
  #     dock = { shadow = false; opacity = 1; };
  #     utility = { shadow = false; focus = true; };
  #     popup_menu = { shadow = false; focus = true; };
  #   };
  #   vSync = true;
  #   backend = "glx";
  # };

  services = {
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
    xserver = {
      enable = true;
      displayManager = {
        defaultSession = "gnome";
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      desktopManager.gnome.enable = true;
    };
  };
  services.gnome.gnome-keyring.enable = true;
  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us,ru";
    xkbVariant = "";
    xkbOptions = "grp:alt_shift_toggle";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pong = {
    isNormalUser = true;
    description = "Ping";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      cascadia-code
      noto-fonts-cjk
      nerdfonts
      corefonts
      vistafonts
    ];
  };

  environment.variables = {
    GI_TYPELIB_PATH = "/run/current-system/sw/lib/girepository-1.0";
  };

  environment.sessionVariables = {
    BACKGROUND_COLOR = "FAFAFA";
    FOREGROUND_COLOR = "020202";
    BACKGROUND_ALT_COLOR = "e4eaeb";
    ACCENT_COLOR = "00aaff";
    NIXOS_OZONE_WL = "1";
  };

  nix.gc = {
    automatic = true;
    randomizedDelaySec = "14m";
    options = "--delete-older-than 10d";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  qt.platformTheme = "gnome";
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox
    fish
    steam
    onlyoffice-bin_7_5
    emacs29-pgtk
    dconf2nix
    gnome.zenity
    #kitty
    #kitty-img
    pavucontrol
    gnome.gnome-tweaks
    #picom-allusive
    gparted
    cmake
    wpsoffice
    whatsapp-for-linux
    telegram-desktop
    nitch
    lua-language-server
    binutils
    gnumake
    #pantum-driver
    gnome-extension-manager
    blackbox-terminal
    nodePackages.lua-fmt
    vimix-gtk-themes
    #bibata-cursors
    google-cursor
    clang-tools
    libtool
    sbcl
    btop
    #xfce.thunar-volman
    #xfce.thunar-archive-plugin
    zip
    flatpak
    shfmt
    gnome.gnome-software
    gcc
    libgcc
    libgccjit
    easyeffects
    gzip
    gimp-with-plugins
    krita
    unzip
    #mate.engrampa
    findutils
    clang-tools
    maestral
    maestral-gui
    dropbox
    github-desktop
    discord
    contrast
    #peazip
    (pkgs.callPackage ./pantum.nix
      { }) # Hacky printer package, might break in the future.
    (pkgs.callPackage ./wallpapers.nix { })
    nixfmt
    #plymouth
    #xfce.tumbler
    #xfce.xfce4-pulseaudio-plugin
    #xfce.xfce4-volumed-pulse
    #flat-remix-icon-theme
    #layan-gtk-thxeme
    ripgrep
    gitFull
    transmission_4-gtk
    gitg
    vscode-fhs
    ripgrep-all
    babelfish
    libgtop
    steam-run
    emacs-all-the-icons-fonts
  ];
  services.flatpak.enable = true;
  programs.java.enable = true;
  programs.steam = { enable = true; };
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
  };
  environment.gnome.excludePackages = (with pkgs; [ gnome-photos gnome-tour ])
    ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      gedit # text editor
      epiphany # web browser
      evince # document viewer
      gnome-characters
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);

  services.locate = {
    enable = true;
    package = pkgs.findutils.locate;
    interval = "hourly";
  };
  #boot.plymouth = {
  #  enable = true;
  #  theme = "bgrt";
  #};
  # system.activationScripts.binbash = {
  #   deps = [ "binsh" ];
  #   text = ''
  #        ln -s /bin/sh /bin/bash
  #   '';
  # };
  boot.plymouth = {
    enable = true;
    themePackages = [
      (pkgs.adi1090x-plymouth-themes.override {
        selected_themes = [ "colorful_sliced" ];
      })
    ];
    theme = "colorful_sliced";
  };
  fonts.packages = with pkgs; [
    noto-fonts
    google-fonts
    noto-fonts-emoji
    cascadia-code
    noto-fonts-cjk
    nerdfonts
    corefonts
    vistafonts
  ];
  fonts.fontDir.enable = true;

  # system.userActivationScripts = {
  #   cleanGtk = {
  #     text = ''
  #       rm -r /home/$USER/.config/gtk-*
  #     '';
  #     deps = [];
  #   };
  # };    

  #  services.emacs.enable = true;
  #  services.emacs.defaultEditor = true;

  programs.fish = {
    enable = true;
    useBabelfish = true;
    shellAbbrs = { nxr = "sudo nixos-rebuild switch"; };
    shellInit = ''
      if status is-interactive
          # Commands to run in interactive sessions can go here
      end
      function fish_prompt
          set -l textcol  '#FAFAFA'
          set -l bgcol    '#00aaff'
          set -l arrowcol '#00aaff'
          set_color $arrowcol -b normal
      		echo -n "╭"
          set_color $textcol -b $bgcol
          echo -n "󰌢  "(hostname)"@"(pwd)" "
          set_color $arrowcol -b normal
          echo -n " 
      ╰── "
      end

      set fish_greeting
    '';
  };
  users.defaultUserShell = pkgs.fish;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
