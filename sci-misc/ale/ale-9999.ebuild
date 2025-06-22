# Copyright 2025 William L Thomson Jr
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

BASE_URI="https://github.com/Farama-Foundation/Arcade-Learning-Environment"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
else
	KEYWORDS="~amd64"
	SRC_URI="${BASE_URI}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
fi

CMAKE_MAKEFILE_GENERATOR="ninja"

inherit cmake ${ECLASS}

MY_P="Arcade-Learning-Environment-${PV}"

DESCRIPTION="Arcade Learning Environment (ALE)"
HOMEPAGE="https://ale.farama.org/"
LICENSE="GPL-2"
SLOT="0"
IUSE="debug +sdl +python"

S="${WORKDIR}/${MY_P}/"

DEPEND="
	sdl? ( media-libs/libsdl2 )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs mytype

	mytype="Release"
	use debug && mytype="Debug"
	mycmakeargs=(
		-DCMAKE_BUILD_TYPE=${mytype}
		-DCMAKE_INSTALL_PREFIX=/
		-DSDL_SUPPORT=$(usex sdl)
		-DBUILD_PYTHON_LIB=$(usex python)
	)
	cmake_src_configure
}
