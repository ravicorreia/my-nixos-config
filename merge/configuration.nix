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
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb = {
  #  layout = "us";
  #  variant = "";
  # };

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

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
  spotify
  swww

    # Ferramentas do Sistema

  yad
  # Fork avançado do Zenity para criar diálogos gráficos em shell scripts.
  inxi
  # Ferramenta de linha de comando para exibir informações detalhadas do sistema (hardware, drivers, etc.).
  killall
  # Utilitário para encerrar processos por nome.
  htop
  # Monitor de processos interativo com interface colorida e visualização de uso de recursos.
  lm_sensors
  # Monitora sensores de temperatura, voltagem e ventilação. No NixOS, requer configuração via boot.kernelModules6.
  lshw
  # Lista detalhes do hardware do sistema.
  pciutils
  # Fornece comandos como lspci para inspecionar dispositivos PCI.
  duf
  # Alternativa moderna ao df para analisar uso de disco com saída colorida.
  ncdu
  # Analisador de uso de disco com interface interativa.

    # Multimídia e Controle

  playerctl
  # Controla players de mídia (e.g., Play/Pause no Spotify) via linha de comando.
  ffmpeg
  # Suite para processamento de áudio/vídeo (conversão, edição, streaming).
  mpv
  # Player de mídia altamente personalizável e baseado em linha de comando.
  pavucontrol
  # Interface gráfica para controlar o PulseAudio. Parte do LXQt como mixer PulseAudio em Qt4.
  imv
  # Visualizador de imagens minimalista para Wayland/X11.
  gimp
  # Editor de imagens avançado (equivalente open-source do Photoshop).

    # Desenvolvimento e Build

  pkg-config
  # Auxilia na configuração de dependências para compilar projetos.
  meson
  ninja
  # Sistema de build moderno (Meson) e executor de tarefas de alta velocidade (Ninja).
  docker-compose
  # Orquestra containers Docker usando arquivos YAML.
  socat
  # Ferramenta para transferência de dados entre redes, dispositivos ou arquivos.

    # Nix Ecosystem

  nh
  # CLI helper para NixOS com recursos avançados como visualização de diffs e limpeza automatizada. Integra-se via flakes ou configurações clássicas5.
  nixfmt-rfc-style
  # Formatter oficial de código Nix baseado no RFC 166. Padrão emergente para Nixpkgs, substituindo opções como nixpkgs-fmt178.
  appimage-run
  # Executa aplicativos AppImage no NixOS, resolvendo dependências automaticamente.

    # Virtualização

  libvirt
  # Kit de ferramentas para gerenciar máquinas virtuais (KVM/QEMU). No NixOS, requer configuração de grupos e módulos do kernel2911.
  virt-viewer
  # Cliente gráfico para acessar VMs via SPICE ou VNC.

    # Interface e Personalização

  lxqt.lxqt-policykit
  # Agente de autenticação do LXQt para operações privilegiadas (parte do ambiente desktop LXQt)4.
  brightnessctl
  # Ajusta o brilho da tela via linha de comando (útil para laptops).
  swaynotificationcenter
  # Centro de notificações para compositors Wayland (e.g., Sway/Hyprland).
  greetd.tuigreet
  # Interface TUI minimalista para o greetd (gerenciador de login).

    # Utilitários Gráficos

  cmatrix
  lolcat
  # Ferramentas de entretenimento: cmatrix simula o efeito Matrix no terminal; lolcat colore texto em arco-íris.
  slurp
  # Seleciona regiões da tela interativamente (combinado com grim para capturar áreas específicas).
  grim
  # Ferramenta para capturar telas/screenshots em ambientes Wayland (usado em combinação com slurp ou swappy).
  swappy
  # Editor de screenshots para Wayland (integra-se com grim/slurp).
  file-roller
  # Gerenciador de arquivos compactados (padrão do GNOME, mas compatível com outros ambientes).
  tree
  # Exibe estrutura de diretórios em formato de árvore.
  eza
  # Substituição moderna para ls com suporte a ícones e cores.

    # Rede e Hardware

  v4l-utils
  # Utilitários para dispositivos Video4Linux (webcams, captura de vídeo).
  ydotool
  # Controla teclado/mouse virtualmente (útil para automação).
  networkmanagerapplet
  # Ícone de bandeja para gerenciar conexões de rede (NetworkManager).

    # Outros

  unrar
  # Extrai arquivos RAR.
  libnotify
  # Envia notificações desktop via notify-send.
  cowsay
  # Gera mensagens com vacas ASCII (clássico do UNIX).
  neovide
  # GUI moderna para o Neovim com suporte a animações e GPU.
  hyprpicker
  # Seletor de cores para o compositor Hyprland.

  ];

  fonts.packages = with pkgs; [
    # Add individual font packages
    ubuntu_font_family

    # Add any other specific fonts you want
    noto-fonts-cjk-sans
    nerd-fonts.jetbrains-mono
  ];

  # Styling Options
  stylix = {
    enable = true;
    image = ../../config/wallpapers/beautifulmountainscape.jpg;
    # base16Scheme = {
    #   base00 = "232136";
    #   base01 = "2a273f";
    #   base02 = "393552";
    #   base03 = "6e6a86";
    #   base04 = "908caa";
    #   base05 = "e0def4";
    #   base06 = "e0def4";
    #   base07 = "56526e";
    #   base08 = "eb6f92";
    #   base09 = "f6c177";
    #   base0A = "ea9a97";
    #   base0B = "3e8fb0";
    #   base0C = "9ccfd8";
    #   base0D = "c4a7e7";
    #   base0E = "f6c177";
    #   base0F = "56526e";
    # };
    polarity = "dark";
    opacity.terminal = 0.8;
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 24;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 11;
        popups = 12;
      };
    };
  };

 
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };


  # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };


  # Services to start
  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
      };
    };
    greetd = {
      enable = true;
      vt = 3;
      settings = {
        default_session = {
          # Wayland Desktop Manager is installed only for user ryan via home-manager!
          user = username;
          # .wayland-session is a script generated by home-manager, which links to the current wayland compositor(sway/hyprland or others).
          # with such a vendor-no-locking script, we can switch to another wayland compositor without modifying greetd's config here.
          # command = "$HOME/.wayland-session"; # start a wayland session directly without a login manager
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
        };
      };
    };
    smartd = {
      enable = false;
      autodetect = true;
    };
    libinput.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    openssh.enable = true;
    flatpak.enable = false;
    printing = {
      enable = true;
      drivers = [
        # pkgs.hplipWithPlugin
      ];
    };
    gnome.gnome-keyring.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = true;
    syncthing = {
      enable = false;
      user = "${username}";
      dataDir = "/home/${username}";
      configDir = "/home/${username}/.config/syncthing";
    };
    rpcbind.enable = false;
    nfs.server.enable = false;
  };

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
    disabledDefaultBackends = [ "escl" ];
  };

  # Extra Logitech Support
  hardware.logitech.wireless.enable = false;
  hardware.logitech.wireless.enableGraphical = false;

  # Bluetooth Support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Security / Polkit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };


  # Virtualization / Containers
  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;

  # OpenGL
  hardware.graphics = {
    enable = true;
  };

  # ---- FIM das configurações ----
  # todos os trechos que eu editei até o momento estão nesse bloco acima.

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

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
