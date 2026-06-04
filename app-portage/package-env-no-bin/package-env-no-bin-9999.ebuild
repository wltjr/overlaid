# Copyright 2017-2022 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

if [[ ${PV} != 9999 ]]; then
        KEYWORDS="~amd64"
fi

DESCRIPTION="Install package env files in /etc/portage to prevent making bins"
HOMEPAGE="https://github.com/Obsidian-StudiosInc/os-xtoo/"
LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}"

CONF="no-binpkg.conf"
PKGS="no-binpkgs"

src_prepare() {
	local conf p pkgs

	default

	conf="no-binpkg.conf"
	echo 'FEATURES="-buildpkg"' > "${CONF}" \
		|| die "Failed to create ${CONF}"

	pkgs=(
		app-editors/vscode
		app-office/libreoffice-bin
		dev-lang/rust-bin
		dev-util/nvidia-cuda-toolkit
		net-im/discord
		net-im/element-desktop-bin
		net-im/zoom
		sys-kernel/gentoo-sources
		www-client/opera
	)
	for p in "${pkgs[@]}"; do
		echo "${p} ${CONF}" >> "${PKGS}" \
			|| die "Failed to create ${PKGS}"
	done
}

src_install() {
	dodir /etc/portage/{,package.}env

	insinto /etc/portage/env
	doins "${CONF}"

	insinto /etc/portage/package.env
	doins "${PKGS}"
}
