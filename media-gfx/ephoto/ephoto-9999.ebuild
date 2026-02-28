# Copyright 2017-2026 William L Thomson Jr
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

E_BASE_URI="https://github.com/wltjr/${PN}"
E_BUILD="meson"
E_DISTFILE="v${PV}"
E_NO_COMMON="1"
E_PV="${PV}"
E_SRC_URI="${E_BASE_URI}/archive"
E_TARBALL="tar.gz"

inherit e

DESCRIPTION="Enlightenment image viewer built on the EFL."
HOMEPAGE="${E_BASE_URI}/"
LICENSE="MIT"
