DESTDIR?=/

MACHINE := $(shell uname -m)

ifeq (x86_64,$(MACHINE))
	PLATFORM := x86_64
endif
ifneq (,$(findstring arm,$(MACHINE)))
	PLATFORM := arm
endif

LIBDIR := lib/${PLATFORM}-linux
CFLAGS := -P${PLATFORM} -Fi${LIBDIR} -Fu. -FU${LIBDIR}

all: kcl karel

${LIBDIR}:
	mkdir -p ${LIBDIR}

karel: CodecUtilsWin32.pas EncodingUtils.pas FastStringFuncs.pas FastStrings.pas karel.lpi karel.lpr karel.manifest karel.rc karel.res NativeXmlObjectStorage.pas NativeXmlOld.pas NativeXml.pas NativeXmlWin32Compat.pas sdDebug.pas sdSortedLists.pas sdStreams.pas sdStringTable.pas simdesign.inc UKEntorno.pas UKMundo.pas UKProgramaCompilado.pas ${LIBDIR}
	/usr/bin/fpc -B  -Mobjfpc -Scghi -O1 -Tlinux -g -gl -vewnhi ${CFLAGS} -l karel.lpr

kcl: CodecUtilsWin32.pas EncodingUtils.pas kcl.lpi kcl.lpr kcl.manifest kcl.rc kcl.res NativeXmlObjectStorage.pas NativeXmlOld.pas NativeXml.pas NativeXmlWin32Compat.pas sdDebug.pas sdSortedLists.pas sdStreams.pas sdStringTable.pas simdesign.inc UCompilador_V3.pas UKProgramaCompilado.pas ${LIBDIR}
	/usr/bin/fpc -B  -Mobjfpc -Scghi -O1 -Tlinux -g -gl -vewnhi ${CFLAGS} -l kcl.lpr

install: kcl karel libkarel.py
	install -d ${DESTDIR}/usr/bin && install -t ${DESTDIR}/usr/bin/ kcl karel
	install -d ${DESTDIR}/usr/lib/python2.7/ && install -t ${DESTDIR}/usr/lib/python2.7/ libkarel.py

clean:
	rm -rf lib
	rm -f kcl
	rm -f karel
