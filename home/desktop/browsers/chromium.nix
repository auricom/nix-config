{
  config,
  lib,
  ...
}: let
  cfg = config.my.home.browsers;
in {
  config = lib.mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      extensions = [
        "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
        "mdjildafknihdffpkfmmpnpoiajfjnjd" # consent-o-matic
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark-reader
        "lpcccgcdjibejkgiaeijbmkpbnbkglkb" # form-history-control
        "beakmhbijpdhipnjhnclmhgjlddhidpe" # linkding
        "acmacodkjbdgmoleebolmdjonilkdbch" # rabby-wallet
        "hlepfoohegkhhmjieoechaddaejaokhf" # refined-github
        "mnjggcdmjocbbbhaepdhchncahnbgone" # sponsorblock
        "clngdbkpkpeebahjckkjfobafhncgmne" # stylus
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      ];
    };
  };
}
