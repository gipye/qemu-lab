#!/usr/bin/env bash
set -e

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
LIBVFIO_SRC="$REPO_DIR/libvfio-user"
QEMU_SRC="$REPO_DIR/qemu"
QEMU_VER="v11.1.1"

apt update
apt install -y \
	build-essential \
	python3-venv \
	pkg-config \
	flex \
	bison \
	libglib2.0-dev \
	libslirp-dev \
	libjson-c-dev \
	libcmocka-dev \
	cloud-image-utils

git -C "$REPO_DIR" submodule update --init --recursive

wget -qO- https://astral.sh/uv/install.sh | sh

export PATH="$HOME/.local/bin:$PATH"

uv tool install meson
uv tool install ninja

# libvfio-user source code build
{
	cd "$LIBVFIO_SRC"
	sed -i "s/^subdir('test')/# subdir('test')/" "$LIBVFIO_SRC/meson.build"
	make -j$(nproc)
	make install
}

# Qemu source code build
{
	cd "$QEMU_SRC"
	git -C "$QEMU_SRC" checkout "$QEMU_VER"
	"$QEMU_SRC/configure"
	make -j$(nproc)
	make install
}
