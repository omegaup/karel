DESTDIR?=/

all: kcl karel

lib/x86_64-linux:
	mkdir -p lib/x86_64-linux

karel: CodecUtilsWin32.pas EncodingUtils.pas FastStringFuncs.pas FastStrings.pas karel.lpi karel.lpr karel.manifest karel.rc karel.res NativeXmlObjectStorage.pas NativeXmlOld.pas NativeXml.pas NativeXmlWin32Compat.pas sdDebug.pas sdSortedLists.pas sdStreams.pas sdStringTable.pas simdesign.inc UKEntorno.pas UKMundo.pas UKProgramaCompilado.pas lib/x86_64-linux
	/usr/bin/fpc -B  -Mobjfpc -Scghi -O1 -Tlinux -Px86_64 -g -gl -vewnhi -Filib/x86_64-linux -Fu. -FUlib/x86_64-linux/ -l karel.lpr

kcl: CodecUtilsWin32.pas EncodingUtils.pas kcl.lpi kcl.lpr kcl.manifest kcl.rc kcl.res NativeXmlObjectStorage.pas NativeXmlOld.pas NativeXml.pas NativeXmlWin32Compat.pas sdDebug.pas sdSortedLists.pas sdStreams.pas sdStringTable.pas simdesign.inc UCompilador_V3.pas UKProgramaCompilado.pas lib/x86_64-linux
	/usr/bin/fpc -B  -Mobjfpc -Scghi -O1 -Tlinux -Px86_64 -g -gl -vewnhi -Filib/x86_64-linux -Fu. -FUlib/x86_64-linux/ -l kcl.lpr

install: kcl karel libkarel.py
	install -d ${DESTDIR}/usr/bin && install -t ${DESTDIR}/usr/bin/ kcl karel
	install -d ${DESTDIR}/usr/lib/python2.7/ && install -t ${DESTDIR}/usr/lib/python2.7/ libkarel.py

clean:
	rm -rf lib
	rm -f kcl
	rm -f karel
