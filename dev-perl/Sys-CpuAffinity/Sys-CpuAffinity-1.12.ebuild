# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DIST_AUTHOR="MOB"
DIST_TEST="do"

inherit perl-module

DESCRIPTION="Set CPU affinity for processes"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-perl/Module-Build"

src_prepare() {
	default
	rm -v contrib/freebsd_cpuset.xs \
		contrib/irix_sysmp.xs \
		contrib/solaris_processor_*.xs \
		|| die
}
