# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    "${
      builtins.fetchTarball
      "https://github.com/nix-community/disko/archive/master.tar.gz"
    }/module.nix"
    ./disko-config.nix
    ./home.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    devices = [ "nodev" ];
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Pine"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

  services.printing = {
    enable = true;
    drivers = [ (pkgs.callPackage ./pantum.nix { }) ];
  };

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

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # KDE
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
      layout = "us,ru";
      xkbVariant = "";
      xkbOptions = "grp:alt_shift_toggle,grp:win_space_toggle";
      desktopManager.gnome.enable = true;
    };
  };
  services.gnome.gnome-keyring.enable = true;

  environment.gnome.excludePackages = (with pkgs; [ gnome-photos gnome-tour ])
    ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      epiphany # web browser
      evince # document viewer
      gnome-characters
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pong = {
    isNormalUser = true;
    extraGroups =
      [ "wheel" "docker" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs;
      [
        # firefox
        #     tree
      ];
  };

  environment = {
    sessionVariables = {
      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
      NIXOS_OZONE_WL = "1";
      #LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    };
    variables = {
      GI_TYPELIB_PATH = "/run/current-system/sw/lib/girepository-1.0";
    };
  };

  nix.gc = {
    automatic = true;
    randomizedDelaySec = "14m";
    options = "--delete-older-than 2d";
  };

  nixpkgs.config.allowUnfree = true;
  qt.platformTheme = "gnome";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (pkgs.callPackage ./pantum.nix
      { }) # Hacky printer package, might break in the future.
    (pkgs.callPackage ./wallpapers.nix { })
    android-studio
    android-tools
    babelfish
    binutils
    blackbox-terminal
    btop
    cargo
    clang-tools
    cmake
    contrast
    dconf2nix
    discord
    distrobox
    docker
    drawio
    dbeaver
    dropbox
    onlyoffice-bin_7_5
    onlyoffice-documentserver
    easyeffects
    emacs-all-the-icons-fonts
    emacs29-pgtk
    emblem
    findutils
    firefox
    fish
    flatpak
    gcc-unwrapped
    gimp
    gitFull
    gitg
    github-desktop
    gnome.gnome-tweaks
    gnome.zenity
    gnumake
    go
    google-cursor
    gparted
    gzip
    joplin-desktop
    joplin
    libgcc
    libgccjit
    libgtop
    libtool
    lua-language-server
    luajitPackages.luarocks
    neovide
    neovim
    nitch
    nixd
    nixfmt
    nodejs_21
    tesseract
    nodePackages.lua-fmt
    pavucontrol
    php83
    protonvpn-gui
    python3
    python311Packages.pip
    ripgrep
    remmina
    ripgrep-all
    sbcl
    SDL
    SDL2
    shfmt
    starship
    stdenv.cc.cc.lib
    telegram-desktop
    thunderbird
    timeshift
    transmission_4-qt
    unzip
    vscode
    wget
    whatsapp-for-linux
    wineWowPackages.waylandFull
    wl-clipboard
    putty
    zip
    zulu
  ];

  services.flatpak.enable = true;
  programs.java.enable = true;
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  programs.adb.enable = true;

  services.mysql = {
    enable = true;
    package = pkgs.mysql80;
  };

  services.locate = {
    enable = true;
    package = pkgs.findutils.locate;
    interval = "hourly";
  };

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
  programs.starship = {
    enable = true;
    settings = {
      format = ''
        [╭](#54ABD1)[](#FAFAFA)[ 󰌢 ](bg:#FAFAFA fg:#090c0c)[▓▒░](bg:#54ABD1 fg:#FAFAFA)$directory[ ](fg:#54ABD1 bg:#2B81C8)$git_branch$git_status[](fg:#2B81C8 bg:#2868AF)$nodejs$rust$golang$php$python[](fg:#2868AF bg:#27324E)$time[ ](fg:#27324E)
        $character'';
      character = {
        success_symbol = "[╰──────](bg:#FAFAFA00 fg:#54ABD1) ";
        error_symbol =
          "[╰───────](bg:#FAFAFA00 fg:#54ABD1)[ ](bg:#FAFAFA00 fg:#EB6A55)";
      };
      python = {
        symbol = " ";
        style = "bg:#2868AF";
        format = "[ $symbol($version )(($virtualenv) )](fg:#FAFAFA bg:#2868AF)";
        python_binary = "python3";
        pyenv_version_name = true;
      };
      directory = {
        style = "fg:#FAFAFA bg:#54ABD1";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      directory.substitutions = {
        "Documents" = "󰈙 ";
        "Downloads" = " ";
        "Music" = " ";
        "Pictures" = " ";
      };
      git_branch = {
        symbol = " ";
        style = "bg:#2B81C8";
        format = "[[ $symbol $branch ](fg:#090c0c bg:#2B81C8)]($style)";
      };
      git_status = {
        style = "bg:#2B81C8";
        format =
          "[[($all_status$ahead_behind )](fg:#090c0c bg:#2B81C8)]($style)";
      };
      nodejs = {
        symbol = " ";
        style = "bg:#2868AF";
        format = "[[ $symbol ($version) ](fg:#FAFAFA bg:#2868AF)]($style)";
      };
      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
        style = "bg:#27324E";
        format = "[[  $time ](fg:#FAFAFA bg:#27324E)]($style)";
      };
    };
  };
  programs.fish = {
    enable = true;
    useBabelfish = true;
    shellAbbrs = { nxr = "sudo nixos-rebuild switch"; };
    shellInit = ''
      if status is-interactive
          # Commands to run in interactive sessions can go here
      end

      set fish_greeting
      starship init fish | source
    '';
  };
  users.defaultUserShell = pkgs.fish;
  boot.supportedFilesystems = [ "ntfs" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  #networking.firewall.allowedTCPPorts = [ 22 80 ];
  #networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  #networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

