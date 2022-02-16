# Copyright 2017-2019 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_BASE_URI="https://github.com/vtorri/etui"
E_BUILD="meson"
E_SNAP="90910ba8aed6b3bdac1f54ae300457a7b98fd5cd"
E_TARBALL="tar.gz"

inherit e

DESCRIPTION="Multi-document rendering library using the EFL"
HOMEPAGE="${E_BASE_URI}"
LICENSE="LGPL-3 djvu? ( GPL-2 ) pdf? ( AGPL-3 )"
SLOT="0"
IUSE="cb djvu +pdf postscript tiff"

DEPEND="
	dev-libs/efl
	cb? ( app-arch/libarchive )
	djvu? ( app-text/djvu )
	pdf? (
		app-text/mupdf:=
		media-libs/freetype
		media-libs/openjpeg:2
		sys-libs/zlib
	)
	postscript? ( app-text/ghostscript-gpl )
	tiff? ( media-libs/tiff:* )
"
# Needed for postscript
#		app-text/xpost

RDEPEND="${DEPEND}"

src_configure() {
	local u E_ECONF=( )
	for u in ${IUSE}; do
#		if [[ "${u}" == "postscript" ]]; then
#			E_CONF+=( -D${u}=$(use_enable postscript ps) )
#		else
			E_ECONF+=( -D${u/+/}=$(usex ${u/+/} true false) )
#		fi
	done
	if use pdf; then
		E_ECONF+=(
			-Dlicense=agplv3
			-Dmupdf=true
			-Dmupdf-static-third=mupdf
		)
	elif use djvu; then
		E_ECONF+=( -Dlicense=gplv2 )
	fi

	e_src_configure
}
