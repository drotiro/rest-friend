# Variables
VER=0.1.0
OBJS=rfhttp.o rfjson.o rfutils.o
HEADERS=rfhttp.h rfjson.h rfutils.h
FLAGS?=-fPIC -I. $(shell pkg-config ${PKGDEPS} --cflags)
LIBS?=$(shell pkg-config ${PKGDEPS} --libs)
ANAME=librest-friend.a
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
all: check $(ANAME) $(SONAME) $(PKGCONF)

$(SONAME): $(SONAME).$(VER)
	$(LN_SF) $(SONAME).$(VER) $(SONAME)
	
$(ANAME): $(OBJS)
	$(AR) rc $@ $+
	
# Dependencies
rfhttp.o: rfhttp.c rfhttp.h rfutils.h
rfjson.o: rfjson.c rfjson.h rfutils.h
rfutils.o: rfutils.c rfutils.h

$(SONAME).$(VER): $(OBJS)
	$(CC) -shared $(FLAGS) $(CFLAGS) -o $@ $(OBJS) $(LDFLAGS) $(LIBS)

.c.o:
	$(CC) $(FLAGS) $(CFLAGS) -c $< -o $@

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
	$(INSTALL_S) -t '$(LIBDIR)' $(ANAME)
	$(INSTALL_S) -t '$(LIBDIR)' $(SONAME).$(VER)
	$(LN_SF) $(SONAME).$(VER) '$(LIBDIR)'/$(SONAME)
	install -d '$(INCDIR)'
	install -m 644 -t '$(INCDIR)' $(HEADERS)
	install -d '$(PKGCONFIGDIR)'
	install -t '$(PKGCONFIGDIR)' $(PKGCONF)

check:
	$(shell pkg-config ${PKGDEPS} --exists --print-errors)