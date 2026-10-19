# Copyright 2017-2026 William L Thomson Jr
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

E_BASE_URI="https://github.com/wltjr/${PN}"
E_BUILD="meson"
E_DISTFILE="v${PV}"
E_NO_COMMON="1"
E_PV="${PV}"
E_SRC_URI="${E_BASE_URI}/archive"
E_TARBALL="tar.gz"

inherit e

DESCRIPTION="EFL Display manager for the X Window System"
HOMEPAGE="${E_BASE_URI}"
LICENSE="GPL-3"
IUSE="debug logind pam"

DEPEND="
	logind? (
		|| (
			sys-auth/elogind
			sys-apps/systemd
		)
	)
	pam? ( sys-libs/pam )
"

RDEPEND="${DEPEND}
	gui-libs/display-manager-init
	x11-base/xorg-server
	x11-drivers/xf86-input-libinput
	x11-libs/libxcb
"

src_configure() {
	if use debug; then
		EMESON_BUILDTYPE=debug
	fi
        meson_src_configure
}
