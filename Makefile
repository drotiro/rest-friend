# Variables
VER=0.1.0
OBJS=rfhttp.o rfjson.o
HEADERS=rfhttp.h rfjson.h
MY_CFLAGS=-fPIC -I.
SONAME=librest-friend.so
PREFIX ?= /usr/local
INCDIR=$(PREFIX)/include
INCAPPDIR=$(PREFIX)/include/libapp
LIBDIR=$(PREFIX)/lib
PKGCONFIGDIR=$(LIBDIR)/pkgconfig
PKGCONF=librest-friend.pc
INSTALL_S = install -s
LN_SF = ln -sf

# Main target
all: $(SONAME) $(PKGCONF)

$(SONAME): $(SONAME).$(VER)
	$(LN_SF) $(SONAME).$(VER) $(SONAME)

# Dependencies

$(SONAME).$(VER):	$(OBJS)
	$(CC) $(MY_CFLAGS) $(CFLAGS) $(LDFLAGS) -Wl,-soname=$(SONAME) -shared  -o $@ $(OBJS)

.c.o:
	$(CC) $(MY_CFLAGS) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

$(PKGCONF): $(PKGCONF).in
	sed \
		-e 's:@PREFIX@:$(PREFIX):g' \
		-e 's:@LIBDIR@:$(LIBDIR):g' \
		-e 's:@INCLUDEDIR@:$(INCDIR):g' \
		-e 's:@PACKAGE_NAME@:libapp:g' \
		-e 's:@PACKAGE_VERSION@:$(VER):g' \
		$< > $@

clean:
	rm -f $(SONAME)* *.o *.o *.pc

install: $(SONAME) $(PKGCONF)
	install -d '$(LIBDIR)'
	$(INSTALL_S) -t '$(LIBDIR)' $(SONAME).$(VER)
	$(LN_SF) $(SONAME).$(VER) '$(LIBDIR)'/$(SONAME)
	install -d '$(INCAPPDIR)'
	install -m 644 -t '$(INCAPPDIR)' $(HEADERS)
	install -d '$(PKGCONFIGDIR)'
	install -t '$(PKGCONFIGDIR)' $(PKGCONF)
