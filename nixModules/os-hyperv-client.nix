{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.os-hyperv-client = {
    enable = lib.mkEnableOption "OS is a Hyper-V client";
  };

  config = lib.mkIf config.os-hyperv-client.enable {

    boot = {
      initrd.kernelModules = [
        "hv_balloon"
        "hv_netvsc"
        "hv_storvsc"
        "hv_utils"
        "hv_vmbus"
      ];
      initrd.availableKernelModules = [ "hyperv_keyboard" ];
    };

    systemd = {
      packages = [ config.boot.kernelPackages.hyperv-daemons.lib ];
      targets.hyperv-daemons = {
        wantedBy = [ "multi-user.target" ];
      };
    };

    boot.kernelPackages = pkgs.linuxPackages_latest;

    virtualisation.hypervGuest.enable = true;
    #virtualisation.hypervGuest = {
    #  enable = true;
    #  videoMode = "1920x1080";
    #};
    # boot.blacklistedKernalModules = [ "hyperv_fb" ];
    systemd.services.hv-fcopy.enable = true;
    systemd.services.hv-kvp.enable = true;
    systemd.services.hv-vss.enable = true;
    services.spice-vdagentd.enable = true;

    environment.systemPackages = with pkgs; [
      config.boot.kernelPackages.hyperv-daemons.bin
    ];

  };
}
