# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DIST_AUTHOR="AMBS"
DIST_SECTION="Lingua"
DIST_VERSION="0.56"
DIST_TEST="do"

inherit perl-module

DESCRIPTION="Language identification"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-perl/Class-Factory-Util
	dev-perl/Text-Affixes
	dev-perl/Text-Ngram"
DEPEND="${RDEPEND}"
