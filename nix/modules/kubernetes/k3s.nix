{ pkgs, ... }:
{
  virtualisation.containerd = {
    enable = true;
    settings = {
      # Use version 2 for modern CDI support
      version = 2;
      plugins."io.containerd.grpc.v1.cri" = {
        cni = {
          bin_dir = "/opt/cni/bin";
          conf_dir = "/var/lib/rancher/k3s/agent/etc/cni/net.d";
        };
        # Enable CDI (Container Device Interface)
        containerd.runtimes.nvidia = {
          runtime_type = "io.containerd.runc.v2";
          privileged_without_host_devices = false;
          options = {
            # Point to the stable system path wrapper
            BinaryName = "/run/current-system/sw/bin/nvidia-ctk";
            SystemdCgroup = true;
          };
        };
      };
    };
  };
  # 1. Allow kubectl to read the config without sudo
  services.k3s.extraFlags = [
    "--tls-san=192.168.88.253"
    "--write-kubeconfig-mode 644"
    "--container-runtime-endpoint unix:///run/containerd/containerd.sock"
    "--disable servicelb"
  ];
  systemd.services.k3s.after = [ "containerd.service" ];

  services.k3s.autoDeployCharts.metallb = {
    name = "metallb";
    repo = "https://metallb.github.io/metallb";
    version = "0.15.3";
    hash = "sha256-J9t2HFrSUl/RMMkv4vLUUA+IcOQC/v48nLjTTYpxpww=";
    targetNamespace = "metallb-system";
    createNamespace = true;

    extraDeploy = [
      {
        apiVersion = "metallb.io/v1beta1";
        kind = "IPAddressPool";
        metadata = {
          name = "k3s-pool";
          namespace = "metallb-system";
        };
        spec = {
          addresses = [ "192.168.200.100-192.168.200.101" ];
        };
      }
      {
        apiVersion = "metallb.io/v1beta1";
        kind = "BGPAdvertisement";
        metadata = {
          name = "k3s-bgp-advertisment";
          namespace = "metallb-system";
        };
        spec = {
          ipAddressPools = [ "k3s-pool" ];
        };
      }
      {
        apiVersion = "metallb.io/v1beta1";
        kind = "BGPPeer";
        metadata = {
          name = "k3s-bgp-peer";
          namespace = "metallb-system";
        };
        spec = {
          peerAddress = "192.168.88.1";
          peerASN = 64513;
          myASN = 64514;
        };
      }
    ];
  };

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
  hardware.nvidia-container-toolkit.mount-nvidia-executables = true;

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
        privileged_without_host_devices = false
        runtime_engine = ""
        runtime_root = ""
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
