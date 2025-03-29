{ pkgs, lib, unstable, ... }: {
  time.timeZone = "America/New_York";
  users.users.root.initialPassword = "root";
  users.users.tgunnoe = {
    isNormalUser = true;
    initialPassword = "tgunnoe";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDLJV7dVWtrSUOV/N3/2lgn3QIjIFVtKBCJE6bQjAWCB tgunnoe@gnu.lv"
    ];
    extraGroups = [
      "adbusers"
      "wheel"
      "input"
      "networkmanager"
      "libvirtd"
      "video"
      "taskd"
      "docker"
      "plugdev"
      "seat"
    ];
  };
  networking = {
    hostName = "jacurutu";
    useDHCP = false;
    interfaces = {
      wlan0.useDHCP = true;
      eth0.useDHCP = true;
    };
    networkmanager = {
      enable = true;
      #wifi.backend = "iwd";
    };
    nameservers =
      [ "1.1.1.1" "1.0.0.1" ];
    #wireless.enable = true;
  };
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    extra-substituters = [
      "https://nix-community.cachix.org"
  ];
  };
  raspberry-pi-nix = {
    board = "bcm2712";
    libcamera-overlay.enable = false;
  };
  hardware = {
    opengl.enable = true;
    bluetooth.enable = true;
    #opengl.driSupport = true;
    raspberry-pi = {
      config = {
        pi5 = {
          options = {
            arm_boost = {
              enable = true;
              value = true;
            };
          };
          dt-overlays = {
            vc4-kms-v3d = {
              enable = true;
              params = { cma-512 = { enable = true; }; };
            };
          };
        };
        all = {
          base-dt-params = {
            BOOT_UART = {
              value = 1;
              enable = true;
            };
            uart_2ndstage = {
              value = 1;
              enable = true;
            };
            krnbt = {
              enable = true;
              value = "on";
            };
            spi = {
              enable = true;
              value = "on";
            };

          };
          options = {
            arm_64bit = {
              enable = true;
              value = true;
            };
            camera_auto_detect = {
              enable = true;
              value = true;
            };
            display_auto_detect = {
              enable = true;
              value = true;
            };
            disable_overscan = {
              enable = true;
              value = true;
            };
          };
        };
      };
    };
  };
  security.rtkit.enable = true;
  services.openssh.enable = true;
  services.openssh.openFirewall = true;
  services.xserver.enable = true;
  #services.displayManager.sddm.wayland.enable = true;
  #services.desktopManager.plasma6.enable = true;
  #services.xserver.desktopManager.xfce.enable = true;
  #services.xserver.displayManager.sddm.enable = true;
  #services.displayManager.sddm.wayland.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;


  environment.systemPackages = with pkgs; [
    libretro.dosbox-pure
    git
    wget
    gzdoom
    leocad
    gcompris
    superTuxKart
    dosbox-x
    scummvm
    unstable.fex
    kdePackages.kturtle
    tuxtype
    tuxpaint
    superTux

    vcmi
    fheroes2
    openxcom
    devilutionx
    wargus
    ecwolf
    innoextract
    commandergenius
    #zeroad
    # zeroad-data

    thonny #Pythone IDE
    codeblocks
    easyrpg-player
  ];
  services.xserver.desktopManager.kodi = {
    enable = true;
    package = pkgs.kodi-gbm;
  };
  hardware.steam-hardware.enable = true;
  services.flatpak.enable = true;
  #programs.sway.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
