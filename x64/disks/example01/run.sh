#!/usr/bin/bash

DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

touch "$DIR/user-data.yml" "$DIR/meta-data.yml"
cloud-localds "$DIR/seed.iso" "$DIR/user-data.yml" "$DIR/meta-data.yml"

# KVM 가속을 사용하는 x86-64 VM
qemu-system-x86_64 \
    -accel kvm \
    -machine q35 \
    -cpu host \
    -m 2G \
    -smp 2 \
    -drive file="$DIR/disk.qcow2",if=virtio,format=qcow2 \
    -cdrom $DIR/seed.iso \
    -netdev user,id=net0,hostfwd=tcp::2222-:22 \
    -device virtio-net-pci,netdev=net0 \
    -device '{"driver":"vfio-user-pci","socket":{"path":"/tmp/example01.sock","type":"unix"}}' \
    -nographic
