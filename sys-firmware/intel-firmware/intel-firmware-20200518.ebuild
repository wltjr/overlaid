# Copyright 2020 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="${PN/-firmware/}"
MY_P="${MY_PN}-${PV}"

BASE_PN="linux-firmware"
BASE_URI="git.kernel.org/pub/scm/linux/kernel/git/firmware/${BASE_PN}.git"

if [[ ${PV} == 9999* ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="git://${BASE_URI}"
	MY_S="${MY_PN}"
else
	GIT_COMMIT="401bd6defb64ebbaf3b020f30f2ac3735d3a0c0f"
	SRC_URI="https://${BASE_URI}/snapshot/${GIT_COMMIT}.tar.gz -> ${BASE_PN}-${PV}.tar.gz"
	MY_S="${GIT_COMMIT}"
fi

inherit linux-info

DESCRIPTION="IRQ microcode for Intel Bluetooth and DSP"
HOMEPAGE="https://${BASE_URI}"
LICENSE="intel-ucode"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="!sys-kernel/linux-firmware[-savedconfig]"

S="${WORKDIR}/${MY_S}"

src_install() {
	insinto /lib/firmware
	doins -r ${MY_PN}
	FILES=( ${MY_PN}/* )
}
