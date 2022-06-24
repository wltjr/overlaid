# Copyright 2016-2022 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DIST_AUTHOR="MLEHMANN"
DIST_VERSION="${PV}"
DIST_TEST="do"

inherit perl-module

DESCRIPTION="Convert between different representations of perl scalars"
KEYWORDS="~amd64"
IUSE="test"
SLOT="0"

RDEPEND="dev-perl/Canary-Stability"
DEPEND="${RDEPEND}"
