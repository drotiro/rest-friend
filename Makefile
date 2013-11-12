# Variables
VER=0.1.0
OBJS=rfhttp.o rfjson.o rfutils.o
HEADERS=rfhttp.h rfjson.h rfutils.h
MY_CFLAGS=-fPIC -I. $(shell pkg-config ${PKGDEPS} --cflags)
MY_LDFLAGS=$(shell pkg-config ${PKGDEPS} --libs)
SONAME=librest-friend.so
# Paths
PREFIX ?= /usr/local
INCDIR=$(PREFIX)/include/$(PKGNAME)
LIBDIR=$(PREFIX)/lib
PKGCONFIGDIR=$(LIBDIR)/pkgconfig
# Pkg-config stuff
PKGNAME=rest-friend
PKGCONF=$(PKGNAME).pc
PKGDEPS=libapp libjson libcurl
# Install commands
INSTALL_S = install -s
LN_SF = ln -sf

# Main target
all: $(SONAME) $(PKGCONF)

$(SONAME): $(SONAME).$(VER)
	$(LN_SF) $(SONAME).$(VER) $(SONAME)

# Dependencies
rfhttp.o: rfhttp.c rfhttp.h rfutils.h
rfjson.o: rfjson.c rfjson.h rfutils.h
rfutils.o: rfutils.c rfutils.h

$(SONAME).$(VER): $(OBJS)
	$(CC) -shared $(MY_CFLAGS) $(CFLAGS) -Wl,-soname=$(SONAME) -o $@ $(OBJS) $(LDFLAGS) $(MY_LDFLAGS)

.c.o:
	$(CC) $(MY_CFLAGS) $(CFLAGS) -c $< -o $@

$(PKGCONF): $(PKGCONF).in
	sed \
		-e 's:@PREFIX@:$(PREFIX):g' \
		-e 's:@LIBDIR@:$(LIBDIR):g' \
		-e 's:@INCLUDEDIR@:$(INCDIR):g' \
		-e 's:@PACKAGE_NAME@:$(PKGNAME):g' \
		-e 's:@PACKAGE_VERSION@:$(VER):g' \
		$< > $@

clean:
	rm -f $(SONAME)* *.o *.o *.pc

install: $(SONAME) $(PKGCONF)
	install -d '$(LIBDIR)'
	$(INSTALL_S) -t '$(LIBDIR)' $(SONAME).$(VER)
	$(LN_SF) $(SONAME).$(VER) '$(LIBDIR)'/$(SONAME)
	install -d '$(INCDIR)'
	install -m 644 -t '$(INCDIR)' $(HEADERS)
	install -d '$(PKGCONFIGDIR)'
	install -t '$(PKGCONFIGDIR)' $(PKGCONF)
