# Copyright 2018-2022 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

E_BASE_URI="https://github.com/wltjr/${PN}"
E_BUILD="meson"
E_DISTFILE="v${PV}"
E_SRC_URI="${E_BASE_URI}/archive"
E_TARBALL="tar.gz"
E_NO_COMMON=1

inherit e

DESCRIPTION="Insanity for your E desktop"
HOMEPAGE="${E_GIT_URI}/${E_TYPE}/${PN}.git"
LICENSE="BSD"

DEPEND="x11-wm/enlightenment:="
RDEPEND="${DEPEND}"
