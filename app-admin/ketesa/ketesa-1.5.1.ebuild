# Copyright 2026 William L Thomson Jr
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

BASE_URI="https://github.com/etkecc/${PN}"

if [[ ${PV} == 9999* ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
else
	SRC_URI="${BASE_URI}/releases/download/v${PV}/${PN}.tar.gz -> ${P}.tar.gz"
	MY_S="${GIT_COMMIT}"
fi

inherit ${ECLASS}

DESCRIPTION="Admin UI for Matrix servers"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="net-im/synapse"

S="${WORKDIR}"

src_install() {
	insinto /var/www/localhost/htdocs/
	doins -r ${PN}
}
