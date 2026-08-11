{
  pkgs,
  ...
}:

with pkgs;
[
  # Development
  nodejs_24
  ripgrep
  ruff
  jq
  lavat
  aalib
  lmstudio

  # Media
  ffmpeg
  obs-studio
  webcamoid
  mpv
  haruna

  # Audio
  cider-2

  # Network
  proton-vpn
  sstp
  networkmanager-sstp
  iproute2
  discord
  wget
  firefox

  # System
  fatresize
  gparted
  mediawriter
  pv
  dtc
  fastfetch
  bind
  busybox
  hunspell
  hunspellDicts.tr_TR
  hunspellDicts.en_US-large
  appimage-run
  socat
  tree
  wl-clipboard
  rar
  unzip
  gruvbox-gtk-theme
  btop
  yazi
  nwg-look
  libxcb-cursor
  veracrypt
  warp-terminal
  wezterm

  # KDE
  kdePackages.ktorrent
  kdePackages.merkuro
  kdePackages.kamoso
  kdePackages.kate
  kdePackages.partitionmanager
  kdePackages.dolphin
  kdePackages.plasma-browser-integration
  kdePackages.qt6ct
  libsForQt5.qt5ct
  libsForQt5.qtstyleplugins
  plasma-panel-spacer-extended
  qt6Packages.qt5compat
  kdePackages.kpmcore
  kdePackages.qtbase
  kdePackages.qtdeclarative
  kdePackages.qtwayland
  kdePackages.qt5compat

  # Fun
  cowsay

  # Torrent
]

