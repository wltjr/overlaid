# Copyright 2025 William L Thomson Jr
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

BASE_URI="https://github.com/USNavalResearchLaboratory/cxxplot"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
else
	KEYWORDS="~amd64"
	SRC_URI="${BASE_URI}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
fi

CMAKE_MAKEFILE_GENERATOR="ninja"

inherit cmake ${ECLASS}

DESCRIPTION="A simple to use C++ 2D plotting library."
HOMEPAGE="${BASE_URI}"
LICENSE="USNRL"
SLOT="0"
IUSE="debug +opengl"

DEPEND="
	dev-qt/qt5compat:6
	dev-qt/qtbase:6[concurrent,gui,widgets,xml]
	dev-qt/qtdeclarative:6
	dev-qt/qttools:6[widgets]
"

src_prepare() {
	sed -i -e '165,168d' \
		-e 's|cxxplot-${cxxplot_VERSION}|cxxplot|' \
		-e 's|LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/${CXXPLOT_DIR_WITH_VERSION}|LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}|' \
		-e 's|${CXXPLOT_DIR_WITH_VERSION}/cxxplot|${CXXPLOT_DIR_WITH_VERSION}/|' \
		${S}/CMakeLists.txt || die

	sed -i -e "1 i\#include <cstdint>" \
		"${S}"/include/cxxplot/utils.hpp || die

#	sed -i -e "s|cxxplot/||g" "${S}"/include/cxxplot/cxxplot || die
#	sed -i -e "s|cxxplot/||g" \
#		"${S}"/include/cxxplot/cxxplot/window.hpp || die

	cmake_src_prepare
}


src_configure() {
	local mycmakeargs mytype

	export CXXFLAGS="${CXXFLAGS} -std=c++2a"

#		-DCMAKE_C_FLAGS="-std=c++2a"
	mytype="Release"
	use debug && mytype="Debug"
	mycmakeargs=(
		-DCMAKE_BUILD_TYPE=${mytype}
		-DCMAKE_INSTALL_PREFIX=/
		-DCXXPLOT_COMPILE_WITH_OPENGL=$(usex opengl)
	)
	cmake_src_configure
}
