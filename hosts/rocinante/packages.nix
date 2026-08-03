{
  pkgs,
  ...
}:

with pkgs;
[
  # Development
  vscode
  lazygit
  android-tools
  sourcegit
  jetbrains.datagrip
  jq
  jdk17
  nodejs_24
  ripgrep
  ruff
  meld 

  # Media
  scrcpy
  ffmpeg_7
  imagemagick
  leptonica
  tesseract4
  zxing
  kdePackages.kdenlive
  kdePackages.ktorrent
  inkscape
  obs-studio
  webcamoid
  mpv
  haruna
  cider-2
  onlyoffice-desktopeditors

  # Network
  eddie
  dmidecode
  astroterm
  networkmanager-sstp
  zap
  filezilla
  wget
  firefox

  # System
  eza
  czkawka
  ydotool
  sysstat
  exfatprogs
  fzf
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
  droidcam
  gruvbox-gtk-theme
  plasma-panel-spacer-extended
  nitch
  btop
  yazi
  nwg-look

  # KDE
  kdePackages.kamera
  kdePackages.kget
  kdePackages.kdesu
  kdePackages.qtmultimedia
  kdePackages.kweathercore
  kdePackages.kate
  kdePackages.partitionmanager
  kdePackages.dolphin
  kdePackages.plasma-browser-integration
  kdePackages.qt6ct
  libsForQt5.qt5ct
  libsForQt5.qtstyleplugins
  kdePackages.kpmcore
  kdePackages.qtbase
  kdePackages.qtdeclarative
  kdePackages.qt5compat
  qt6Packages.qt5compat
  darkly

  # Fun
  antigravity
  cowsay

]
