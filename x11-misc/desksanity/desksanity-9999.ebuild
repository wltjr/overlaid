# Copyright 2018-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_BUILD="meson"
E_SNAP="${P}"
E_TARBALL="tar.gz"
E_TYPE="enlightenment/modules"

inherit e

if [[ ${PV} == 1.1.0 ]]; then
	SRC_URI="https://github.com/Obsidian-StudiosInc/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Insanity for your E desktop"
HOMEPAGE="${E_GIT_URI}/${E_TYPE}/${PN}.git"
LICENSE="BSD"

DEPEND="x11-wm/enlightenment:="
RDEPEND="${DEPEND}"
