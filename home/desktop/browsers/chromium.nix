{ config, pkgs, lib, ... }:
let
  cfg = config.my.home.browsers;
  secrets = config.age.secrets;
in
{
  config = lib.mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      # TODO defaultSearchProviderEnabled = true;
      # TODO defaultSearchProviderSearchURL = builtins.readFile secrets."browsers/search".path;
      extensions = [
        "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
        "mdjildafknihdffpkfmmpnpoiajfjnjd" # consent-o-matic
        "lpcccgcdjibejkgiaeijbmkpbnbkglkb" # form-history-control
        "beakmhbijpdhipnjhnclmhgjlddhidpe" # linkding
        "acmacodkjbdgmoleebolmdjonilkdbch" # rabby-wallet
        "hlepfoohegkhhmjieoechaddaejaokhf" # refined-github
        "mnjggcdmjocbbbhaepdhchncahnbgone" # sponsorblock
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      ];
      # TODO extraOpts = {
      # TODO   "BrowserSignin" = 0;
      # TODO   "SyncDisabled" = true;
      # TODO   "PasswordManagerEnabled" = false;
      # TODO   "SpellcheckEnabled" = false;
      # TODO };
      # TODO homepageLocation = builtins.readFile secrets."browsers/search".path;
    };
  };
}