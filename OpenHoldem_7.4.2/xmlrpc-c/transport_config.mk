# -*-makefile-*-    <-- an Emacs control


# The make variables herein come from config.mk, which is included
# by the make file that includes us.

transport_config.h: $(BLDDIR)/config.mk
	rm -f $@
	echo '/* This file was generated by a make rule */' >>$@
ifeq ($(MUST_BUILD_WININET_CLIENT),yes)
	echo '#define MUST_BUILD_WININET_CLIENT 1' >>$@
else
	echo '#define MUST_BUILD_WININET_CLIENT 0' >>$@
endif
ifeq ($(MUST_BUILD_CURL_CLIENT),yes)
	echo '#define MUST_BUILD_CURL_CLIENT 1' >>$@
else
	echo '#define MUST_BUILD_CURL_CLIENT 0' >>$@
endif
ifeq ($(MUST_BUILD_LIBWWW_CLIENT),yes)
	echo '#define MUST_BUILD_LIBWWW_CLIENT 1' >>$@
else
	echo '#define MUST_BUILD_LIBWWW_CLIENT 0' >>$@
endif
	echo "static const char * const XMLRPC_DEFAULT_TRANSPORT =" >>$@
ifeq ($(MUST_BUILD_LIBWWW_CLIENT),yes)
	echo '"libwww";' >>$@
else
  ifeq ($(MUST_BUILD_CURL_CLIENT),yes)
	echo '"curl";' >>$@
  else
    ifeq ($(MUST_BUILD_WININET_CLIENT),yes)
	echo '"wininet";' >>$@
    else
	@echo 'ERROR: no client XML transport configured'; rm $@; false
    endif
  endif
endif

