# Copyright 2017-2021 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="${PN}"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/libtom/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit ${ECLASS} flag-o-matic

DESCRIPTION="Fairly comprehensive, modular and portable cryptographic toolkit"
HOMEPAGE="https://www.libtom.com/"
LICENSE="CC-PD"
SLOT="0"

DEPEND="dev-libs/libtommath"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_S}"

src_compile() {
	# target all builds demos and test, should be under test USE flag
	append-flags -DUSE_LTM -DLTM_DESC -fPIC
	emake -f makefile.unix CFLAGS="${CFLAGS}" \
		EXTRALIBS="${EPREFFIX}/usr/lib/libtommath.a"
}

src_install() {
	emake -f makefile.unix PREFIX="${D}/usr" install
}
