# Frabjous!

[![Build Status](https://travis-ci.org/csmk/frabjous.svg?branch=master)](https://travis-ci.org/csmk/frabjous)

Yet another personal [Gentoo](https://gentoo.org/) overlay. This overlay contain only ebuilds for packages that I'm interested in. It also include support for the upcoming `libressl` USE flag. So, for now I recommend to use this overlay in conjunction with the [libressl](https://github.com/gentoo/libressl) repository.

**DISCLAIMER:** This repository contains experimental ebuilds with extra added features. Use at your own risk! However, I've been using these packages in a production environment without any problems.

## How to install the overlay
You must have both `dev-vcs/git` and `app-portage/layman` installed on your system for this to work: `layman -a frabjous`

## Repository tree
```
    .
    ├── app-misc
    │   └── c_rehash
    ├── dev-lua
    │   └── luasec
    ├── mail-filter
    │   └── imapfilter
    ├── net-dns
    │   ├── nsd
    │   └── unbound
    ├── net-libs
    │   ├── ldns
    │   └── wslay
    ├── net-p2p
    │   ├── bitcoinxtd
    │   └── bitcoinxt-qt
    └── www-servers
        ├── nginx
        └── h2o

```

## Tip Jar
Bitcoin donations are welcome: **1L5CYEMhnSCe8LusB7r6TGtXurUBWjFXjA**

## Contributing
Contributions are welcome. Fork and create a pull request. Bugs to versions in the main gentoo tree should always be filed in the [Gentoo Bugzilla](https://bugs.gentoo.org/).

##Issues
Report bugs on the [github issues site](https://github.com/csmk/frabjous/issues)
