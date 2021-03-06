# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3

DESCRIPTION="A simple, lightweight C library for writing XMPP clients"
HOMEPAGE="http://strophe.im/libstrophe/"
EGIT_REPO_URI="https://github.com/strophe/libstrophe.git"

LICENSE="|| ( MIT GPL-3 )"
SLOT="0"
KEYWORDS=""
IUSE="doc examples libressl +ssl +xml"

RDEPEND="ssl? (
		!libressl? ( dev-libs/openssl:0= )
		libressl? ( dev-libs/libressl:0= )
	)
	xml? ( dev-libs/libxml2:2 )
	!xml? ( dev-libs/expat )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

PATCHES=( "${FILESDIR}"/${PN}-0.9.2-libressl.patch )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable ssl tls) \
		$(use_with xml libxml2) \
		|| die "econf failed"
}
src_compile() {
	default
	if use doc; then
		doxygen || die
		HTML_DOCS=( docs/html/* )
	fi
}

src_install() {
	default
	use examples && dodoc -r examples
}
