{ pkgs, ... }:

{
  # Enable PulseAudio and PipeWire
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable Bluetooth and Blueman
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
}
