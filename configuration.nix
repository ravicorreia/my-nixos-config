# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 8;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "baobab"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Bahia";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # TEST, comentei as funcoes do X11 pra ver se eu posso remover usando o wayland | aparentemente sim.
  # mas é interessante deixar ativado por causa de programas que ainda usa o XORG
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
   layout = "us";
   variant = "";
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # ---- Minhas configurações ----

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.

  users.users.ravicorreia = {
    isNormalUser = true;
    description = "Ravi Correia";
    extraGroups = [ "networkmanager" "wheel" ];
    # Opcionalmente, torná-lo o shell padrão do sistema
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  # Configuração do Garbage Collector

  # Automatic Updating
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # Automtic Cleanup
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 7d";
  nix.settings.auto-optimise-store = true;

  #Enable zsh.
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  # Enable flatpak use.
  services.flatpak.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow dynamic linking for unpackaged programs
  programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = with pkgs; [
    # Aparentemente não precisei instalar nenhuma dessas libs extras, apenas ativei o nix-ld e o Mason funcionou
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    # stdenv.cc.cc.lib  # gcc runtime libraries
    # zlib
    # openssl
    # icu
    # libxml2
  # Add other libraries as needed based on specific language server requirements
  # ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  home-manager        # Home Manager
  wget
  curl
  zoxide              # Fast cd command that learns your habits
  bat                 # Cat(1) clone with syntax highlighting and Git integration
  git                 # Version Control System (VCS)
  ghostty             # Terminal
  nodejs_22           # Node, not shure if that is the best way to install it
  tmux                # Terminal Multiplexer
  neovim              # Text editor
  wl-clipboard        # Wayland clipboard functionality
  fastfetch           # A fetch, maybe I'll also test 'nitch' something like that
  gnome-tweaks        # Gnome Tweaks...
  discord             # All-in-one cross-platform voice and text chat
  vscode              # Text editor
  gh                  # GitHub cli
  python313           # Python 3.13
  fzf                 # Fuzy Finder
  gcc                 # Compilor
  clang               # Compilor
  gnumake             # Compilor
  binutils            # Compilor
  ripgrep             # Utility that combines the usability of The Silver Searcher with the raw speed of grep
  fd                  # Simple, fast and user-friendly alternative to find
  unzip               # Unzipper
  gnutar              # Unzipper
  cargo               # Rust's package manager and build system, it handles dependencies e.g. nil_ls for nix.
  ];

  fonts.packages = with pkgs; [
    # Add individual font packages
    ubuntu_font_family

    # Add any other specific fonts you want
    noto-fonts-cjk-sans
    nerd-fonts.jetbrains-mono
  ];

  # ---- FIM das configurações ----
  # todos os trechos que eu editei até o momento estão nesse bloco acima.

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
  system.stateVersion = "24.11"; # Did you read the comment?

}
