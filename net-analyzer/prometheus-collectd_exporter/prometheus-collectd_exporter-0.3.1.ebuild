# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-vcs-snapshot systemd user

COMMIT_HASH="3abb95c"
EGO_PN="github.com/${PN/-//}"
DESCRIPTION="A server that accepts collectd stats for Prometheus consumption"
HOMEPAGE="https://prometheus.io"
SRC_URI="https://${EGO_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror strip"

DOCS=( {NOTICE,{CHANGELOG,README}.md} )

G="${WORKDIR}/${P}"
S="${G}/src/${EGO_PN}"

pkg_setup() {
	enewgroup collectd_exporter
	enewuser collectd_exporter -1 -1 -1 collectd_exporter
}

src_compile() {
	export GOPATH="${G}"
	local GOLDFLAGS="-s -w \
		-X ${EGO_PN}/vendor/${EGO_PN%/*}/common/version.Version=${PV} \
		-X ${EGO_PN}/vendor/${EGO_PN%/*}/common/version.Revision=${COMMIT_HASH} \
		-X ${EGO_PN}/vendor/${EGO_PN%/*}/common/version.BuildUser=$(id -un)@$(hostname -f) \
		-X ${EGO_PN}/vendor/${EGO_PN%/*}/common/version.Branch=non-git \
		-X ${EGO_PN}/vendor/${EGO_PN%/*}/common/version.BuildDate=$(date -u '+%Y%m%d-%I:%M:%S')"

	go build -v -ldflags \
		"${GOLDFLAGS}" || die
}

src_test() {
	go test -v ./... || die
}

src_install() {
	dobin collectd_exporter
	einstalldocs

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	systemd_dounit "${FILESDIR}"/${PN}.service

	diropts -o collectd_exporter -g collectd_exporter -m 0750
	dodir /var/log/collectd_exporter
}
