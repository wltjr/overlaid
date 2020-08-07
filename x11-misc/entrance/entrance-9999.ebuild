# Copyright 2017-2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_BASE_URI="https://github.com/Obsidian-StudiosInc/${PN}"
E_BUILD="meson"
E_DISTFILE="v${PV}"
E_PV="${PV}"
E_SRC_URI="${E_BASE_URI}/archive"
E_TARBALL="tar.gz"

inherit e

DESCRIPTION="EFL Display manager for the X Window System"
HOMEPAGE="${E_BASE_URI}"
LICENSE="GPL-3"
IUSE="logind pam"

DEPEND="
	x11-apps/xdm
	logind? (
		|| (
			sys-auth/elogind
			sys-apps/systemd
		)
	)
	pam? ( sys-libs/pam )
"

RDEPEND="${DEPEND}"
