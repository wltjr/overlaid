# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DIST_AUTHOR="ARODLAND"
DIST_TEST="do"

inherit perl-module

DESCRIPTION="Unicode case-folding for case-insensitive lookups"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-perl/Module-Build"
