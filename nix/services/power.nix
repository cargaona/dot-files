{ pkgs, ... }:
{
  services.upower = {
    enable = true;
    percentageCritical = 33;
    percentageAction = 33;
    criticalPowerAction = "Hibernate";
  }; 
}
