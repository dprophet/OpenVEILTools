#	Copyright (c) 2017, TecSec, Inc.
#
#	Redistribution and use in source and binary forms, with or without
#	modification, are permitted provided that the following conditions are met:
#	
#		* Redistributions of source code must retain the above copyright
#		  notice, this list of conditions and the following disclaimer.
#		* Redistributions in binary form must reproduce the above copyright
#		  notice, this list of conditions and the following disclaimer in the
#		  documentation and/or other materials provided with the distribution.
#		* Neither the name of TecSec nor the names of the contributors may be
#		  used to endorse or promote products derived from this software 
#		  without specific prior written permission.
#		 
#	ALTERNATIVELY, provided that this notice is retained in full, this product
#	may be distributed under the terms of the GNU General Public License (GPL),
#	in which case the provisions of the GPL apply INSTEAD OF those given above.
#		 
#	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
#	ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#	DISCLAIMED.  IN NO EVENT SHALL TECSEC BE LIABLE FOR ANY 
#	DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#	LOSS OF USE, DATA OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#	ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#	SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Written by Roger Butler

set(CMAKE_INSTALL_PREFIX ${TS_INSTALL_PREFIX})

set(EXE_DLL_POSTFIX ${CMAKE_${TS_CONFIG}_POSTFIX})

set(CMAKE_INSTALL_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include/TecSec/${TS_MODULE_INCLUDE})

if(APPLE)
	set(CMAKE_INSTALL_EXEC_PREFIX ${CMAKE_INSTALL_PREFIX})
	set(ALLBIN_DIR ${CMAKE_INSTALL_PREFIX}/bin)
	set(ALLSHLIB_DIR ${CMAKE_INSTALL_PREFIX}/lib)
elseif(UNIX)
		set(CMAKE_INSTALL_EXEC_PREFIX ${CMAKE_INSTALL_PREFIX})
	set(ALLBIN_DIR ${CMAKE_INSTALL_PREFIX}/bin)
	set(ALLSHLIB_DIR ${CMAKE_INSTALL_PREFIX}/lib)
elseif(WIN32)
	if (NOT ${TS_MODULE_BIN} STREQUAL "")
		set(CMAKE_INSTALL_EXEC_PREFIX ${CMAKE_INSTALL_PREFIX}/${TS_MODULE_BIN})
	else (NOT ${TS_MODULE_BIN} STREQUAL "")
		set(CMAKE_INSTALL_EXEC_PREFIX ${CMAKE_INSTALL_PREFIX})
	endif (NOT ${TS_MODULE_BIN} STREQUAL "")
	set(ALLBIN_DIR ${CMAKE_INSTALL_PREFIX}/bin${TS_LIB_DIR_SUFFIX}${EXE_DLL_POSTFIX})
	set(ALLSHLIB_DIR ${CMAKE_INSTALL_PREFIX}/bin${TS_LIB_DIR_SUFFIX}${EXE_DLL_POSTFIX})
endif(APPLE)


set(CMAKE_INSTALL_BINDIR ${CMAKE_INSTALL_EXEC_PREFIX}/bin)
set(CMAKE_INSTALL_DATADIR ${CMAKE_INSTALL_PREFIX}/share)
set(CMAKE_INSTALL_LIBDIR ${CMAKE_INSTALL_EXEC_PREFIX}/lib)
set(CMAKE_INSTALL_INFODIR ${CMAKE_INSTALL_DATADIR}/info)
set(CMAKE_INSTALL_MANDIR ${CMAKE_INSTALL_DATADIR}/man)


set(DATA_DIR ${CMAKE_INSTALL_DATADIR})
set(INCLUDE_DIR ${CMAKE_INSTALL_INCLUDEDIR})
if(WIN32)
	set(BIN_DIR ${CMAKE_INSTALL_BINDIR}${TS_LIB_DIR_SUFFIX}${EXE_DLL_POSTFIX})
	set(LIB_DIR ${CMAKE_INSTALL_LIBDIR}${TS_LIB_DIR_SUFFIX})
	set(SHLIB_DIR ${BIN_DIR})
	set(INSTALL_BIN_DIR ${CMAKE_INSTALL_EXEC_PREFIX}/installer/bin${TS_LIB_DIR_SUFFIX}${EXE_DLL_POSTFIX})
	set(INSTALL_SHLIB_DIR ${CMAKE_INSTALL_EXEC_PREFIX}/installer/bin${TS_LIB_DIR_SUFFIX}${EXE_DLL_POSTFIX})
	set(INSTALL_LIB_DIR ${CMAKE_INSTALL_EXEC_PREFIX}/installer/lib${TS_LIB_DIR_SUFFIX})
	set(INSTALL_OTHER_DIR ${CMAKE_INSTALL_EXEC_PREFIX}/installer)
elseif(APPLE)
	set(BIN_DIR ${CMAKE_INSTALL_BINDIR})
	set(LIB_DIR ${CMAKE_INSTALL_LIBDIR})
	set(SHLIB_DIR ${LIB_DIR})
	set(ALLSHLIB_DIR ${SHLIB_DIR})
	set(INSTALL_BIN_DIR ${BIN_DIR})
	set(INSTALL_SHLIB_DIR ${SHLIB_DIR})
	set(INSTALL_LIB_DIR ${LIB_DIR})
	set(INSTALL_OTHER_DIR ${CMAKE_INSTALL_EXEC_PREFIX})
elseif(UNIX)
	set(BIN_DIR ${CMAKE_INSTALL_BINDIR})
	set(LIB_DIR ${CMAKE_INSTALL_LIBDIR})
	set(SHLIB_DIR ${LIB_DIR})
	set(ALLSHLIB_DIR ${SHLIB_DIR})
	set(INSTALL_BIN_DIR ${BIN_DIR})
	set(INSTALL_SHLIB_DIR ${SHLIB_DIR})
	set(INSTALL_LIB_DIR ${LIB_DIR})
	set(INSTALL_OTHER_DIR ${CMAKE_INSTALL_EXEC_PREFIX})
endif(WIN32)
set(DOC_DIR ${CMAKE_INSTALL_DATADIR}/doc)
set(INFO_DIR ${CMAKE_INSTALL_INFODIR})
set(MAN_DIR ${CMAKE_INSTALL_MANDIR})
set(BUILD_DIR ${CMAKE_BINARY_DIR})
set(SOURCE_DIR ${CMAKE_SOURCE_DIR})

if (WIN32 AND NOT TS_SUPPRESS_TOOLSET)
	set(BIN_DIR ${BIN_DIR}/${TS_TOOLSET})
	set(LIB_DIR ${LIB_DIR}/${TS_TOOLSET})
	set(SHLIB_DIR ${SHLIB_DIR}/${TS_TOOLSET})
	set(ALLSHLIB_DIR ${ALLSHLIB_DIR}/${TS_TOOLSET})
	set(INSTALL_BIN_DIR ${INSTALL_BIN_DIR}/${TS_TOOLSET})
	set(INSTALL_SHLIB_DIR ${INSTALL_SHLIB_DIR}/${TS_TOOLSET})
	set(INSTALL_LIB_DIR ${INSTALL_LIB_DIR}/${TS_TOOLSET})
endif(WIN32 AND NOT TS_SUPPRESS_TOOLSET)
