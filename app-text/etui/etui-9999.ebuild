# Copyright 2017-2022 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_BASE_URI="https://github.com/vtorri/etui"
E_BUILD="meson"
E_NO_COMMON="1"
E_SNAP="3a69e23fd13225dad5be3ad62f8e5a33f938d1c0"
E_TARBALL="tar.gz"

inherit e

DESCRIPTION="Multi-document rendering library using the EFL"
HOMEPAGE="${E_BASE_URI}"
LICENSE="LGPL-3 djvu? ( GPL-2 ) AGPL-3"
SLOT="0"
IUSE="cb djvu tiff"

DEPEND="
	dev-libs/efl
	cb? ( app-arch/libarchive )
	djvu? ( app-text/djvu )
	tiff? ( media-libs/tiff:* )
	app-text/mupdf:=
	media-libs/freetype
	media-libs/openjpeg:2
	sys-libs/zlib
"

RDEPEND="${DEPEND}"

src_configure() {
	local u E_ECONF=( )
	for u in ${IUSE}; do
		E_ECONF+=( -D${u/+/}=$(usex ${u/+/} true false) )
	done
	E_ECONF+=(
		-Dlicense=agplv3
		-Dmupdf=true
		-Dmupdf-static-third=mupdf
	)
	if use djvu; then
		E_ECONF+=( -Dlicense=gplv2 )
	fi

	e_src_configure
}
