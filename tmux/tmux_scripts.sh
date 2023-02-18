#!/bin/bash

_barrier() {
  echo $USER
  barriers -f --no-tray  --disable-crypto --disable-client-cert-checking -c $HOME/.barrier.conf --address :24820 --restart
}
