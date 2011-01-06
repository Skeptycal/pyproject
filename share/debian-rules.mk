#! /usr/bin/make -f

### Variables:
# set this to a non-empty string if you want to use the install-nodoc target
# INSTALL_NODOC

# Uncomment this to turn on verbose mode.
#export DH_VERBOSE=1

progname=$(shell awk '/^Source/ {print $$2}' debian/control)
prefix=debian/$(progname)/usr

export INSTALL_NODOC

build:
	mkdir -p $(prefix)
	dh_clean -k
	if [ -d docs ]; then dh_installdocs docs/; fi
	$(MAKE) install prefix=$(prefix)

clean:
	$(MAKE) clean
	dh_clean

binary-indep: build

binary-arch: build
	dh_testdir
	dh_testroot
	dh_installdeb -a
	dh_gencontrol -a
	dh_md5sums -a
	dh_builddeb -a

binary: binary-indep binary-arch

.PHONY: build clean binary-indep binary-arch binary
