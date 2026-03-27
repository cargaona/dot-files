{ pkgs }:

pkgs.writeShellApplication {
  name = "sandbox";

  runtimeInputs = with pkgs; [
    qemu
    cloud-utils
    curl
    gawk
    coreutils
  ];

  text = ''
    DATA_DIR="''${HOME}/.local/share/sandbox-vm"
    DISK="''${DATA_DIR}/arch.qcow2"
    CIDATA="''${DATA_DIR}/cidata.iso"
    ARCH_IMAGE_URL="https://geo.mirror.pkgbuild.com/images/latest/Arch-Linux-x86_64-cloudimg.qcow2"

    SSH_PUBKEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCiytR0RDJVFPwlPA+yBKUc6KhukzlPHCZ3ckaEZz5f5cXHp3g5dKZyOd7Kju7fEWa0apb37W9QZPa1PvreeJu6wpBs7FSNC6NpyjwnRjfpfbU1XC8WEVLzzgke+dV/7Ap98K2qpUoYAFIbYlAdGJAzMOc9BYKrb6l2ARIA26Fc2Zd7fUkdr8jcMQFv5qnFju1e82iPggeymNHKd7RNkuAg4nAfkTwNKxzcoF3rTBCc0iG0TE61uUbVOx6CVS/17Xj7g+YKS2jMuDE3nWi3Fl1PUx5J07DVFF4TzyxM2Srn8V39QSoCQDevyN1PZJcRW34GtgG2y1EEfJNVR1sP+GHak037L78JSyLfaDTB3uJzICOTdifFrc88SuauU+KMyyMnrP3h2YuWWurtOAZMGpPZlocFt8ILpC9j43fRtNbLwVe3dPTJDlDJJTZMjEVNrT1S6Xi6r7bYpq5jZgWNvPqByHnySrMsSwIGbuFfPoawVzbye6uliK8REiQV1azlMn0Lmv+YRwTURnpyiDmyAR3OxrB0CN9a0B8MLzp+IY1ZrLBxMCC/yRIWih2dOiLTri45qrt4Sul2NZYYPM9I2iwA8xezvp/Dr27gUKkixQVsCprRT8+J6fYVcVDOnzkDej/Hyem6oJqsGeSkjCmGCebBqJvxd5ZODD74A5HZzkLcrQ== cardno:15_206_941"

    mkdir -p "''${DATA_DIR}"

    # Download and prepare disk image on first run
    if [ ! -f "''${DISK}" ]; then
      echo ">>> First run: downloading Arch Linux cloud image..."
      curl -L -o "''${DISK}.base" "''${ARCH_IMAGE_URL}"
      echo ">>> Creating working disk (20GB)..."
      qemu-img create -f qcow2 -b "''${DISK}.base" -F qcow2 "''${DISK}" 20G
      echo ">>> Disk image ready."
    fi

    # Generate cloud-init ISO if missing
    if [ ! -f "''${CIDATA}" ]; then
      echo ">>> Generating cloud-init data..."

      CI_TMPDIR="$(mktemp -d)"
      trap 'rm -rf "''${CI_TMPDIR}"' EXIT

      printf '%s\n' \
        "#cloud-config" \
        "hostname: sandbox" \
        "users:" \
        "  - name: sandbox" \
        "    sudo: ALL=(ALL) NOPASSWD:ALL" \
        "    shell: /bin/bash" \
        "    lock_passwd: false" \
        "    ssh_authorized_keys:" \
        "      - ''${SSH_PUBKEY}" \
        > "''${CI_TMPDIR}/user-data"

      printf '%s\n' \
        "instance-id: sandbox-vm-001" \
        "local-hostname: sandbox" \
        > "''${CI_TMPDIR}/meta-data"

      cloud-localds "''${CIDATA}" "''${CI_TMPDIR}/user-data" "''${CI_TMPDIR}/meta-data"
      echo ">>> Cloud-init ISO ready."
    fi

    echo ">>> Starting sandbox VM..."
    echo ">>> SSH: ssh sandbox@localhost -p 10022"
    echo ">>> Ports forwarded: 10022->22, 18789->18789"
    echo ">>> Press Ctrl-A X to exit QEMU"
    echo ""

    qemu-system-x86_64 \
      -enable-kvm \
      -m 4G \
      -smp 2 \
      -cpu host \
      -drive file="''${DISK}",format=qcow2,if=virtio \
      -drive file="''${CIDATA}",format=raw,if=virtio \
      -netdev user,id=net0,hostfwd=tcp::10022-:22,hostfwd=tcp::18789-:18789 \
      -device virtio-net-pci,netdev=net0 \
      -nographic
  '';
}
