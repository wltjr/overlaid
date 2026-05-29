# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

GENQMAIL_PV=20191010
QMAIL_SPP_PV=0.42

QMAIL_TLS_PV=20200107
QMAIL_TLS_F=${PN}-${PV}-tls-${QMAIL_TLS_PV}.patch

QMAIL_BIGTODO_PV=103
QMAIL_BIGTODO_F=big-todo.${QMAIL_BIGTODO_PV}.patch

QMAIL_LARGE_DNS='qmail-103.patch'

QMAIL_SMTPUTF8='qmail-smtputf8.patch'

inherit qmail

DESCRIPTION="qmail -- a secure, reliable, efficient, simple message transfer agent"
HOMEPAGE="
	http://netqmail.org
	https://cr.yp.to/qmail.html
	http://qmail.org
"
SRC_URI="mirror://qmail/${P}.tar.gz
	https://github.com/DerDakon/genqmail/releases/download/genqmail-${GENQMAIL_PV}/${GENQMAIL_F}
	https://www.ckdhr.com/ckd/${QMAIL_LARGE_DNS}
	!vanilla? (
		highvolume? ( mirror://qmail/${QMAIL_BIGTODO_F} )
		qmail-spp? ( mirror://sourceforge/qmail-spp/${QMAIL_SPP_F} )
		ssl? (
			https://inoa.net/qmail-tls/${QMAIL_TLS_F}
			https://arnt.gulbrandsen.priv.no/qmail/qmail-smtputf8.patch
		)
	)
"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE="authcram gencertdaily highvolume ipv6 pop3 qmail-spp ssl vanilla"
REQUIRED_USE="vanilla? ( !ssl !qmail-spp !highvolume )"
RESTRICT="test"

DEPEND="
	acct-group/nofiles
	acct-group/qmail
	acct-user/alias
	acct-user/qmaild
	acct-user/qmaill
	acct-user/qmailp
	acct-user/qmailq
	acct-user/qmailr
	acct-user/qmails
	net-dns/libidn2
	net-mail/queue-repair
	ssl? ( >=dev-libs/openssl-1.1:0= )
	sys-apps/gentoo-functions
	sys-apps/groff
"
RDEPEND="${DEPEND}
	sys-apps/ucspi-tcp
	virtual/checkpassword
	virtual/daemontools
	authcram? ( >=net-mail/cmd5checkpw-0.30 )
	ssl? (
		pop3? ( sys-apps/ucspi-ssl )
	)
	sys-apps/ucspi-tcp[ipv6?]
	!mail-mta/courier
	!mail-mta/esmtp
	!mail-mta/exim
	!mail-mta/mini-qmail
	!mail-mta/msmtp[mta]
	!mail-mta/nullmailer
	!mail-mta/opensmtpd
	!mail-mta/postfix
	!mail-mta/qmail-ldap
	!mail-mta/sendmail
	!mail-mta/ssmtp[mta]
"

src_unpack() {
	genqmail_src_unpack
	use qmail-spp && qmail_spp_src_unpack

	unpack ${P}.tar.gz
}

PATCHES=(
	"${FILESDIR}/${PV}-exit.patch"
	"${FILESDIR}/${PV}-readwrite.patch"
	"${DISTDIR}/${QMAIL_LARGE_DNS}"
	"${FILESDIR}/${PV}-fbsd-utmpx.patch"
	"${FILESDIR}/${P}-ipme-multiple.patch"
	"${FILESDIR}/${P}-any-to-cname.patch"
	"${FILESDIR}/${P}-CVE-2005-1513.patch"
	"${FILESDIR}/${P}-CVE-2005-1514.patch"
	"${FILESDIR}/${P}-CVE-2005-1515.patch"
	"${FILESDIR}/${P}-overflows.patch"
)

src_prepare() {
	if ! use vanilla; then
		if use ssl; then
			# This patch contains relative paths and needs to be cleaned up.
			sed 's~^--- \.\./\.\./~--- ~g' \
				< "${DISTDIR}"/${QMAIL_TLS_F} \
				> "${T}"/${QMAIL_TLS_F} || die
			PATCHES+=(
				"${FILESDIR}/qmail-base64.patch"
				"${T}/${QMAIL_TLS_F}"
				"${FILESDIR}/qmail-smtpd-auth-0.5.10.patch"
				"${FILESDIR}/qmail-smtputf8.patch"
				"${FILESDIR}/qmail-smtputf8-crlf-fix.patch"
			)
		fi
		if use highvolume; then
			PATCHES+=( "${DISTDIR}/${QMAIL_BIGTODO_F}" )
		fi

		if use qmail-spp; then
			local SPP_PATCH
			if use ssl; then
				SPP_PATCH="${QMAIL_SPP_S}/qmail-spp-smtpauth-tls-20060105.diff"
			else
				SPP_PATCH="${QMAIL_SPP_S}/netqmail-spp.diff"
			fi
			# make the patch work with "-p1"
			sed -e 's#^--- \([Mq]\)#--- a/\1#' -e 's#^+++ \([Mq]\)#+++ b/\1#' \
				-i ${SPP_PATCH} || die
			PATCHES+=( "${SPP_PATCH}" )
		fi
		if use ipv6; then
			PATCHES+=( "${FILESDIR}"/${PV}-ipv6-p[1-3].patch )
		fi
	fi

	default

	qmail_src_postunpack

	# Fix bug #33818 but for netqmail (Bug 137015)
	if ! use authcram; then
		einfo "Disabled CRAM_MD5 support"
		sed -e 's,^#define CRAM_MD5$,/*&*/,' -i "${S}"/qmail-smtpd.c || die
	else
		einfo "Enabled CRAM_MD5 support"
	fi

	sed -e "1 i\#include \"sig.h\"" -i "${S}"/predate.c || die

	sed -e "1 i\#include <unistd.h>" -i "${S}"/cdb_seek.c || die
	sed -e "1 i\#include <unistd.h>" -i "${S}"/newfield.c || die
	sed -e "1 i\#include <unistd.h>" -i "${S}"/seek_cur.c || die
	sed -e "1 i\#include <unistd.h>" -i "${S}"/seek_end.c || die
	sed -e "1 i\#include <unistd.h>" -i "${S}"/seek_set.c || die
	sed -e "1 i\#include <unistd.h>" -i "${S}"/seek_trunc.c || die
	sed -e "1 i\#include <unistd.h>" -i "${S}"/fd_copy.c || die
	sed -e "1 i\#include <unistd.h>" -i "${S}"/fd_move.c || die
	sed -e "1 i\#include <unistd.h>" -i "${S}"/qmail-inject.c || die
	sed -e "1 i\#include <unistd.h>" -i "${S}"/qmail-rspawn.c || die
	sed -e "1 i\#include <unistd.h>" -i "${S}"/qmail-showctl.c || die
	sed -e "1 i\#include <unistd.h>" -i "${S}"/triggerpull.c || die

	sed -e "1 i\#include <unistd.h>" -e "1 i\#include <sys/stat.h>" \
		-i "${S}"/qmail-start.c || die
	sed -e "1 i\#include <unistd.h>"  -e "1 i\#include <sys/stat.h>" \
		-e "1 i\#include <stdio.h>" -e "1 i\#include \"byte.h\"" \
		-i "${S}"/qmail-newu.c || die

	sed -e "1 i\#include <unistd.h>" -e "1 i\#include <grp.h>" \
		-e "s|short|unsigned int|" -i "${S}"/chkshsgr.c || die

	sed -e "1 i\#include <utime.h>" -i "${S}"/qmail-send.c || die

	sed -e 's|int (\*op)|long (\*op)|' -i "${S}"/substdio.h || die
	sed -e 's|register int (\*op)|register long (\*op)|' -i "${S}"/substdio.c || die

	sed -e 's|int subfd|long subfd|g' -i "${S}"/subfd.h || die
	sed -e 's|int subfd|long subfd|' -i "${S}"/subfdin.c || die
	sed -e 's|int subfd|long subfd|' -i "${S}"/subfdins.c || die

	sed -e 's|int safe|long safe|g' -i "${S}"/qmail-remote.c || die

	sed -e "1 i\#include <stdio.h>" -e "s|char \*s|const char \*s|" \
		-e "s|void puts|int puts|" -i "${S}"/auto-str.c || die
	sed -e "1 i\#include <stdio.h>" -e "s|char \*s|const char \*s|" \
		-e "s|void puts|int puts|" -i "${S}"/auto-int8.c || die
	sed -e "1 i\#include <stdio.h>" -e "s|char \*s|const char \*s|" \
		-e "s|void puts|int puts|" -i "${S}"/auto-int.c || die
	sed -e "1 i\#include <stdio.h>" -e "s|void puts(s)|int puts(s) const|" \
		-i "${S}"/qmail-inject.c || die
	sed -e "1 i\#include <stdio.h>" -e "s|void puts(s)|int puts(s) const|" \
		-i "${S}"/qmail-pop3d.c || die
	sed -e "1 i\#include <stdio.h>" -e "s|void puts(s)|int puts(s) const|" \
		-i "${S}"/qmail-popup.c || die

	sed -e "s|main()|int main()|" -i qmail-qmqpc.c || die
	sed -e "s|main()|int main()|" -i qmail-qmqpd.c || die
	sed -e "s|main()|int main()|" -i qmail-qmtpd.c || die

	ht_fix_file Makefile*
}

src_compile() {
	qmail_src_compile
	use qmail-spp && qmail_spp_src_compile
}

src_install() {
	qmail_src_install
}

pkg_postinst() {
	qmail_queue_setup
	qmail_rootmail_fixup
	qmail_tcprules_build

	qmail_config_notice
	qmail_supervise_config_notice
	elog
	elog "If you are looking for documentation, check those links:"
	elog "https://wiki.gentoo.org/wiki/Virtual_mail_hosting_with_qmail"
	elog "  -- qmail/vpopmail Virtual Mail Hosting System Guide"
	elog "http://www.lifewithqmail.com/"
	elog "  -- Life with qmail"
	elog
}

pkg_preinst() {
	qmail_tcprules_fixup
}

pkg_config() {
	# avoid some weird locale problems
	export LC_ALL=C

	qmail_config_fast
	qmail_tcprules_config
	qmail_tcprules_build

	use ssl && qmail_ssl_generate
}
