{ pkgs, ... }:
{
  # 1. Allow kubectl to read the config without sudo
  services.k3s.extraFlags = "--tls-san=192.168.88.253 --write-kubeconfig-mode 644";
  # 2. Set the KUBECONFIG variable system-wide
  environment.variables = {
    KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
  };

  # Enable the k3s service
  services.k3s.enable = true;
  services.k3s.role = "server";
  # Open necessary ports in the firewall
  networking.firewall.allowedTCPPorts = [ 6443 ];

  # Enable NVIDIA Container Toolkit for GPU support
  hardware.nvidia-container-toolkit.enable = true;

  # Add nvidia-container-toolkit to system packages (for manual testing)
  environment.systemPackages = with pkgs; [
    nvidia-container-toolkit
  ];
  # Create containerd config template to enable CDI
  # NOTE: We use plugins."io.containerd.cri.v1.runtime".cdi instead of redefining the parent table

  environment.etc."rancher/k3s/agent/etc/containerd/config-v3.toml.tmpl" = {
    text = ''
      {{ template "base" . }}
      # Enable CDI device support
      [plugins."io.containerd.cri.v1.runtime".cdi]
        enable = true
        spec_dirs = ["/var/run/cdi"]
      # Configure nvidia runtime with nvidia-container-toolkit
      [plugins."io.containerd.cri.v1.runtime".containerd.runtimes.nvidia]
        runtime_type = "io.containerd.runc.v2"
        
      [plugins."io.containerd.cri.v1.runtime".containerd.runtimes.nvidia.options]
        BinaryName = "/run/current-system/sw/bin/runc"
        SystemdCgroup = true
    '';
    mode = "0644";
  };
  # Ensure the containerd template directory exists and is writable by k3s
  systemd.tmpfiles.rules = [
    "d /var/lib/rancher/k3s/agent/etc/containerd 0755 root root -"
    "L+ /var/lib/rancher/k3s/agent/etc/containerd/config-v3.toml.tmpl - - - - /etc/rancher/k3s/agent/etc/containerd/config-v3.toml.tmpl"
  ];
}
