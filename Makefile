ifeq ($(DEB_HOST_MULTIARCH),)
  DEB_HOST_MULTIARCH      ?= $(shell gcc -print-multiarch)
endif

PREFIX                  ?= /usr
INCLUDE_DIR             = ${PREFIX}/include
LIBRARY_DIR             = ${PREFIX}/lib/${DEB_HOST_MULTIARCH}/
export LIBRARY_NAME		= amqpcpp
export SONAME			= 4.3
export VERSION			= 4.3.9

all:
		$(MAKE) -C src all

pure:
		$(MAKE) -C src pure

release:
		$(MAKE) -C src release

static:
		$(MAKE) -C src static

shared:
		$(MAKE) -C src shared

clean:
		$(MAKE) -C src clean

install:
		mkdir -p ${DESTDIR}${INCLUDE_DIR}/$(LIBRARY_NAME)
		mkdir -p ${DESTDIR}${INCLUDE_DIR}/$(LIBRARY_NAME)/linux_tcp
		mkdir -p ${DESTDIR}${LIBRARY_DIR}
		cp -f include/$(LIBRARY_NAME).h ${DESTDIR}${INCLUDE_DIR}
		cp -f include/amqpcpp/*.h ${DESTDIR}${INCLUDE_DIR}/$(LIBRARY_NAME)
		cp -f include/amqpcpp/linux_tcp/*.h ${DESTDIR}${INCLUDE_DIR}/$(LIBRARY_NAME)/linux_tcp
		-cp -f src/lib$(LIBRARY_NAME).so.$(VERSION) ${DESTDIR}${LIBRARY_DIR}
		-cp -f src/lib$(LIBRARY_NAME).a.$(VERSION) ${DESTDIR}${LIBRARY_DIR}
		ln -s -f $(LIBRARY_DIR)/lib$(LIBRARY_NAME).so.$(VERSION) ${DESTDIR}$(LIBRARY_DIR)/lib$(LIBRARY_NAME).so.$(SONAME)
		ln -s -f $(LIBRARY_DIR)/lib$(LIBRARY_NAME).so.$(VERSION) ${DESTDIR}$(LIBRARY_DIR)/lib$(LIBRARY_NAME).so
		ln -s -f $(LIBRARY_DIR)/lib$(LIBRARY_NAME).a.$(VERSION) ${DESTDIR}$(LIBRARY_DIR)/lib$(LIBRARY_NAME).a
