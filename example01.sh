#!/usr/bin/env bash
set -e

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

wget -nc -P "$REPO_DIR/x64/base_images" \
	https://cloud-images.ubuntu.com/releases/26.04/release/ubuntu-26.04-server-cloudimg-amd64.img
if [ ! -f "$REPO_DIR/x64/disks/example01/disk.qcow2" ]; then
	qemu-img create \
		-f qcow2 -F qcow2 \
		-b "$REPO_DIR/x64/base_images/ubuntu-26.04-server-cloudimg-amd64.img" \
		"$REPO_DIR/x64/disks/example01/disk.qcow2"
	qemu-img resize "$REPO_DIR/x64/disks/example01/disk.qcow2" 20G
	qemu-img snapshot -c snap1 "$REPO_DIR/x64/disks/example01/disk.qcow2"
fi


wget -nc -P "$REPO_DIR/arm64/base_images" \
	https://cloud-images.ubuntu.com/releases/26.04/release/ubuntu-26.04-server-cloudimg-arm64.img
if [ ! -f "$REPO_DIR/arm64/disks/example01/disk.qcow2" ]; then
	qemu-img create \
		-f qcow2 -F qcow2 \
		-b "$REPO_DIR/arm64/base_images/ubuntu-26.04-server-cloudimg-arm64.img" \
		"$REPO_DIR/arm64/disks/example01/disk.qcow2"
	qemu-img resize "$REPO_DIR/arm64/disks/example01/disk.qcow2" 20G
	qemu-img snapshot -c snap1 "$REPO_DIR/arm64/disks/example01/disk.qcow2"
fi


wget -nc -P "$REPO_DIR/riscv64/base_images" \
	https://cloud-images.ubuntu.com/releases/26.04/release/ubuntu-26.04-server-cloudimg-riscv64.img
if [ ! -f "$REPO_DIR/riscv64/disks/example01/disk.qcow2" ]; then
qemu-img create \
	-f qcow2 -F qcow2 \
	-b "$REPO_DIR/riscv64/base_images/ubuntu-26.04-server-cloudimg-riscv64.img" \
	"$REPO_DIR/riscv64/disks/example01/disk.qcow2"
	qemu-img resize "$REPO_DIR/riscv64/disks/example01/disk.qcow2" 20G
qemu-img snapshot -c snap1 "$REPO_DIR/riscv64/disks/example01/disk.qcow2"
fi
