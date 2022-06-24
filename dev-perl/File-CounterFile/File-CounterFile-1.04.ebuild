# Copyright 2017-2022 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DIST_AUTHOR="GAAS"
DIST_TEST="do"

inherit perl-module

DESCRIPTION="Persistent counter class"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-perl/Module-Build"
