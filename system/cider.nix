{
  lib,
  config,
  pkgs,
  ...}: let
  cfg = config.modules.cider;
in {
  options.modules.cider = with lib; {
    enable = mkEnableOption ''enable cider module'';
    pkg = mkOption {
      type = types.enum ["cider" "cider-2"];
      default = "cider";
      description = ''
        Choose the cider package version
      '';
    };
  };

  config =
    let
      cider-2 = pkgs.appimageTools.wrapType2 rec {
        pname = "cider-2";
        version = "2.6.1";

        src = pkgs.fetchurl {
          name = "cider-linux-x64.AppImage";
          url = "https://cidercollective.itch.io/cider";
          sha256 = "18by764idifnjs5h2cydv4qjm7w95lzdlxjkscp289w3jdpbmd05";
        };

        nativeBuildInputs = [ pkgs.makeWrapper ];

        extraInstallCommands =
          let
            contents = pkgs.appimageTools.extract {
              inherit version src;
              
              pname = "Cider";
            };
          in
          ''
            wrapProgram $out/bin/${pname} \
               --add-flags "'${NIXOS_OZONE_WL:+\'${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true}}" \
               --add-flags "--no-sandbox --disable-gpu-sandbox" 

            install -m 444 -D ${contents}/Cider.desktop $out/share/applications/${pname}.desktop
            substituteInPlace $out/share/applications/${pname}.desktop \
              --replace-warn 'Exec=Cider' 'Exec=${pname}'
            install -Dm444 ${contents}/usr/share/icons/hicolor/256x256/cider-linux----arch-------version---.png \
                           $out/share/icons/hicolor/256x256/apps/cider.png
          '';

        meta = with lib; {
          description = "Cider music player";
          homepage = "https://cider.sh";
          license = licenses.unfree;
          mainProgram = "cider-2";
          maintainers = with maintainers; [ itsvic-dev ];
          platforms = platforms.linux;
        };
      };
    in
    lib.mkIf cfg.enable {
      environment.systemPackages =
        if cfg.pkg == "cider" then
          [ pkgs.cider ]
        else if cfg.pkg == "cider-2" then
          [ cider-2 ]
        else
          [ ];
    };
}