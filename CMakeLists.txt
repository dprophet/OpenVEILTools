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

IF(WIN32)
	cmake_minimum_required(VERSION 3.2)
	set_property(GLOBAL PROPERTY USE_FOLDERS On)
ELSE()
    cmake_minimum_required(VERSION 3.2)
ENDIF()

LIST(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmakemodules)
if(POLICY CMP0005)
    cmake_policy(SET CMP0005 NEW)
endif()
if(POLICY CMP0048)
    cmake_policy(SET CMP0048 NEW)
endif()
if(POLICY CMP0058)
    cmake_policy(SET CMP0058 NEW)
endif()

set(TS_VS_CONFIG ${CMAKE_BUILD_TYPE})
set (CMAKE_CONFIGURATION_TYPES ${CMAKE_BUILD_TYPE})
set (CMAKE_CONFIGURATION_TYPES "${CMAKE_CONFIGURATION_TYPES}" CACHE STRING "Reset the configurations" FORCE )
mark_as_advanced(CMAKE_CONFIGURATION_TYPES)

set(CMAKE_OSX_DEPLOYMENT_TARGET 10.11)
set(CMAKE_OSX_ARCHITECTURES "Universal")

set(DEBUG_TSALG ON)

set(SuperProject ON)
set(TS_SUPPRESS_TOOLSET ON)

#
# Set up the project name and look for the compiler configuration
#
# set(TS_MODULE_BIN OpenVEIL)
set(TS_MODULE_INCLUDE OpenVEILTools)
project(OpenVEILTools LANGUAGES C CXX)

#
# Include the TecSec macros and variables.  Look for the OpaqueVEIL, OpenVEIL and VEILCrypto
#
include(tecsec_configure_env)
include(tecsec_ConfigureTSALG)
set(SDK_FOLDER ${CRYPTO_INSTALL_BASE_DIR})
if(APPLE)
	set(TS_INSTALL_PREFIX /usr/local)
else()
	set(TS_INSTALL_PREFIX ${CRYPTO_INSTALL_PREFIX})
endif()

include(tecsec_packages)
IF(MSVC)
	# include(compiler_tecsec_msvc.noWarnings)
ENDIF(MSVC)
set(NO_PCH OFF)
if(MINGW)
    set(NO_PCH ON)
endif(MINGW)
include(precompiled.header)
include (tecsec_installdirs)

# Reconfigure for static RTE
if(MSVC)
	set(CMAKE_C_FLAGS_DEBUG         "${CMAKE_C_FLAGS_DEBUGSTATIC}")
	set(CMAKE_C_FLAGS_RELEASE       "${CMAKE_C_FLAGS_RELEASESTATIC}")
	set(CMAKE_CXX_FLAGS_DEBUG       "${CMAKE_CXX_FLAGS_DEBUGSTATIC}")
	set(CMAKE_CXX_FLAGS_RELEASE     "${CMAKE_CXX_FLAGS_RELEASESTATIC}")
endif(MSVC)

#
# Configure some of the Linux SO parameters
#
if(APPLE)
    SET(CMAKE_SKIP_BUILD_RPATH FALSE)
    SET(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
    SET(CMAKE_INSTALL_RPATH "$ORIGIN;${SHLIB_DIR};~/local")
    SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
elseif(UNIX)
    SET(CMAKE_SKIP_BUILD_RPATH FALSE)
    SET(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
    SET(CMAKE_INSTALL_RPATH "$ORIGIN;${SHLIB_DIR};~/local")
    SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH FALSE)
endif(APPLE)


#####################################################################
## Start Options
#####################################################################

set(VEILTOOLS_MAJOR_VERSION 7)
set(VEILTOOLS_MINOR_VERSION 0)
set(VEILTOOLS_REVISION_VERSION 56)
set(VEILTOOLS_BUILD_VERSION 0)
set(OSX_FRAMEWORK_VERSION A)

#####################################################################
## End Options
#####################################################################
set(VEIL_COPYRIGHT "Copyright (C) 2017 TecSec, Inc.  All Rights Reserved Worldwide.")

set(VEILTOOLS_VERSION "${VEILTOOLS_MAJOR_VERSION}.${VEILTOOLS_MINOR_VERSION}.${VEILTOOLS_REVISION_VERSION}")
set(VEILTOOLS_VERSION_COMMA "${VEILTOOLS_MAJOR_VERSION},${VEILTOOLS_MINOR_VERSION},${VEILTOOLS_REVISION_VERSION}")
set(VEILTOOLS_SO_VERSION "${VEILTOOLS_MAJOR_VERSION}")

set(VEILCORE_VERSION ${VEILTOOLS_VERSION})
set(VEILCORE_VERSION_COMMA ${VEILTOOLS_VERSION_COMMA})

set(ENABLE_NASM OFF)
ENABLE_LANGUAGE(ASM_NASM)
if(CMAKE_ASM_NASM_COMPILER_WORKS)
	set(ENABLE_NASM ON)
endif(CMAKE_ASM_NASM_COMPILER_WORKS)

# set(ENABLE_MASM OFF)
# ENABLE_LANGUAGE(ASM_MASM)
# if(CMAKE_ASM_MASM_COMPILER_WORKS)
# 	set(ENABLE_MASM ON)
# endif(CMAKE_ASM_MASM_COMPILER_WORKS)

IF(WIN32)
    set(GTEST_ROOT c:/GoogleTest/${TS_TOOLSET}_${TS_X_PLATFORM})
ENDIF(WIN32)

find_package(GTest)

if(GTEST_FOUND)
	# enable_testing()
endif()

include(summary)

#
# Place the output into these folders
#
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PUBLIC_BINARY_TOP_DIR}/lib")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PUBLIC_BINARY_TOP_DIR}/bin")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PUBLIC_BINARY_TOP_DIR}/bin")
set(CMAKE_PDB_OUTPUT_DIRECTORY "${PUBLIC_BINARY_TOP_DIR}/pdb")
set(OSX_FRAMEWORK_FOLDER "/Library/Frameworks")
set(OSX_SDK_DIR "{PUBLIC_BINARY_TOP_DIR}/sdk")

set(EXTRA_FILE_OUTPUT ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
if (MSVC_IDE)
	set(EXTRA_FILE_OUTPUT ${EXTRA_FILE_OUTPUT}/${CMAKE_BUILD_TYPE})
endif(MSVC_IDE)

# look for system header files needed

FOREACH(KEYWORD "__inline__" "__inline" "inline")
  IF(NOT DEFINED C_INLINE)
    TRY_COMPILE(C_HAS_${KEYWORD} "${CMAKE_CURRENT_BINARY_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}/SolutionItems/test_inline.c" COMPILE_DEFINITIONS "-Dinline=${KEYWORD}")
    IF(C_HAS_${KEYWORD})
      MESSAGE(STATUS "Inline found as ${KEYWORD}")
      SET(C_INLINE TRUE)
      SET(TS_INLINE ${KEYWORD})
    ENDIF()
  ENDIF()
ENDFOREACH(KEYWORD)
IF(NOT DEFINED C_INLINE)
  MESSAGE(STATUS "Inline not found")
  SET(TS_INLINE "")
ENDIF()

find_package(PCSC)

if (PCSC_FOUND AND NOT APPLE)
	get_property(_tmp TARGET pcsc PROPERTY INTERFACE_INCLUDE_DIRECTORIES)
	if(NOT ("${_tmp}" STREQUAL ""))
		include_directories(${_tmp})
		set(CMAKE_REQUIRED_INCLUDES ${CMAKE_REQUIRED_INCLUDES} ${_tmp})
	endif(NOT ("${_tmp}" STREQUAL ""))
	get_property(_tmp TARGET pcsc PROPERTY DLOPEN_SONAME)
	set(PCSC_SO_NAME, ${_tmp})
	message(STATUS 	"set(PCSC_SO_NAME, ${_tmp})")
endif()

INCLUDE(CheckIncludeFiles)
INCLUDE(CheckIncludeFileCXX)
INCLUDE(${CMAKE_ROOT}/Modules/CheckIncludeFile.cmake)
INCLUDE(${CMAKE_ROOT}/Modules/CheckTypeSize.cmake)
INCLUDE(${CMAKE_ROOT}/Modules/CheckFunctionExists.cmake)
INCLUDE(${CMAKE_ROOT}/Modules/CheckCXXSourceCompiles.cmake)
INCLUDE(${CMAKE_ROOT}/Modules/TestBigEndian.cmake)
INCLUDE(${CMAKE_ROOT}/Modules/CheckSymbolExists.cmake)

set(CMAKE_EXTRA_INCLUDE_FILES "${CMAKE_EXTRA_INCLUDE_FILES} stdlib.h")

CHECK_INCLUDE_FILES(stdio.h HAVE_STDIO_H)
CHECK_INCLUDE_FILES(string.h HAVE_STRING_H)
CHECK_INCLUDE_FILES(stdlib.h HAVE_STDLIB_H)
CHECK_INCLUDE_FILES(stdint.h HAVE_STDINT_H)
CHECK_INCLUDE_FILES(stdarg.h HAVE_STDARG_H)
CHECK_INCLUDE_FILES(stdint.h HAVE_STDINT_H)
CHECK_INCLUDE_FILES(stddef.h HAVE_STDDEF_H)
CHECK_INCLUDE_FILES(ctype.h HAVE_CTYPE_H)
CHECK_INCLUDE_FILES(errno.h HAVE_ERRNO_H)
CHECK_INCLUDE_FILES(limits.h HAVE_LIMITS_H)
# CHECK_INCLUDE_FILES(process.h HAVE_PROCESS_H)
# CHECK_INCLUDE_FILES(pthread.h HAVE_PTHREAD_H)
# CHECK_INCLUDE_FILES(math.h HAVE_MATH_H)
CHECK_INCLUDE_FILES(windows.h HAVE_WINDOWS_H)
# CHECK_INCLUDE_FILES(basetsd.h HAVE_BASETSD_H)
CHECK_INCLUDE_FILES(sys/types.h HAVE_SYS_TYPES_H)
CHECK_INCLUDE_FILES(sys/endian.h HAVE_SYS_ENDIAN_H)
CHECK_INCLUDE_FILES(sys/stat.h HAVE_SYS_STAT_H)
CHECK_INCLUDE_FILES(sys/time.h HAVE_SYS_TIME_H)
CHECK_INCLUDE_FILES(sys/timeb.h HAVE_SYS_TIMEB_H)
CHECK_INCLUDE_FILES(unistd.h HAVE_UNISTD_H)
# CHECK_INCLUDE_FILES(crtdbg.h HAVE_CRTDBG_H)
# CHECK_INCLUDE_FILES(wchar.h HAVE_WCHAR_H)
CHECK_INCLUDE_FILES(memory.h HAVE_MEMORY_H)
CHECK_INCLUDE_FILES(tchar.h HAVE_TCHAR_H)
CHECK_INCLUDE_FILES(time.h HAVE_TIME_H)
CHECK_INCLUDE_FILES(io.h HAVE_IO_H)
# CHECK_INCLUDE_FILES(pwd.h HAVE_PWD_H)
# CHECK_INCLUDE_FILES(cpuid.h HAVE_CPUID_H)
# #CHECK_INCLUDE_FILES(uuid/uuid.h HAVE_UUID_UUID_H)
# CHECK_INCLUDE_FILES(dlfcn.h HAVE_DLFCN_H)
# CHECK_INCLUDE_FILES(glob.h HAVE_GLOB_H)
# CHECK_INCLUDE_FILES(dirent.h HAVE_DIRENT_H)
# CHECK_INCLUDE_FILES(syslog.h HAVE_SYSLOG_H)
CHECK_INCLUDE_FILES(fcntl.h HAVE_FCNTL_H)
# CHECK_INCLUDE_FILES(sys/wait.h HAVE_SYS_WAIT_H)
# CHECK_INCLUDE_FILES(sys/ioctl.h HAVE_SYS_IOCTL_H)
# CHECK_INCLUDE_FILES(sys/resource.h HAVE_SYS_RESOURCE_H)
# CHECK_INCLUDE_FILES(sys/socket.h HAVE_SYS_SOCKET_H)
# CHECK_INCLUDE_FILES(netinet/in.h HAVE_NETINET_IN_H)
# CHECK_INCLUDE_FILES(netdb.h HAVE_NETDB_H)
# CHECK_INCLUDE_FILES(arpa/inet.h HAVE_ARPA_INET_H)
# CHECK_INCLUDE_FILES(gio/gio.h HAVE_GIO_GIO_H)
# CHECK_INCLUDE_FILES(magic.h HAVE_MAGIC_H)
# CHECK_INCLUDE_FILES(pcsclite.h HAVE_PCSCLITE_H)
# CHECK_INCLUDE_FILES(PCSC/pcsclite.h HAVE_PCSC_PCSCLITE_H)
# CHECK_INCLUDE_FILES(winscard.h HAVE_WINSCARD_H)
# CHECK_INCLUDE_FILES(PCSC/winscard.h HAVE_PCSC_WINSCARD_H)
# CHECK_INCLUDE_FILES(direct.h HAVE_DIRECT_H)
# CHECK_INCLUDE_FILES(wmmintrin.h HAVE_WMMINTRIN_H)
# CHECK_INCLUDE_FILES(smmintrin.h HAVE_SMMINTRIN_H)
# CHECK_INCLUDE_FILES(emmintrin.h HAVE_EMMINTRIN_H)
# CHECK_INCLUDE_FILES(tmmintrin.h HAVE_TMMINTRIN_H)
# CHECK_INCLUDE_FILES(xmmintrin.h HAVE_XMMINTRIN_H)
# CHECK_INCLUDE_FILES(intrin.h HAVE_INTRIN_H)
CHECK_INCLUDE_FILES(sal.h HAVE_SAL_H)
# if(NOT TS_INTERNAL_SD_DAEMON)
# CHECK_INCLUDE_FILES(systemd/sd-daemon.h HAVE_SD_DAEMON_H)
# endif(NOT TS_INTERNAL_SD_DAEMON)
CHECK_INCLUDE_FILE_CXX(string HAVE_CPP_STRING)
CHECK_INCLUDE_FILE_CXX(cstddef HAVE_CPP_CSTDDEF)
CHECK_INCLUDE_FILE_CXX(map HAVE_CPP_ALGORITHM)
CHECK_INCLUDE_FILE_CXX(map HAVE_CPP_MAP)
CHECK_INCLUDE_FILE_CXX(list HAVE_CPP_LIST)
# CHECK_INCLUDE_FILE_CXX(forward_list HAVE_CPP_FORWARD_LIST)
# CHECK_INCLUDE_FILE_CXX(deque HAVE_CPP_DEQUE)
CHECK_INCLUDE_FILE_CXX(vector HAVE_CPP_VECTOR)
CHECK_INCLUDE_FILE_CXX(memory HAVE_CPP_MEMORY)
CHECK_INCLUDE_FILE_CXX(functional HAVE_CPP_FUNCTIONAL)
CHECK_INCLUDE_FILE_CXX(iostream HAVE_CPP_IOSTREAM)
CHECK_INCLUDE_FILE_CXX(ostream HAVE_CPP_OSTREAM)
# CHECK_INCLUDE_FILE_CXX(regex HAVE_CPP_REGEX)
CHECK_INCLUDE_FILE_CXX(climits HAVE_CPP_CLIMITS)
# CHECK_INCLUDE_FILE_CXX(mutex HAVE_CPP_MUTEX)

if(HAVE_ERRNO_H)
CHECK_CXX_SOURCE_COMPILES("
    #include <errno.h>
	int main(void)
	{
	  errno_t h = 9;
	  return h;
	}
	" HAVE_ERRNO_T
	)
endif()

# #CHECK_TYPE_SIZE("nullptr_t" SIZEOF_NULLPTR_T BUILTIN_TYPES_ONLY LANGUAGE CXX)
# CHECK_CXX_SOURCE_COMPILES("
	# int main(void)
	# {
	  # byte* ch = 0;
	  # return *ch;
	# }
	# " HAVE_BYTE
	# )
CHECK_CXX_SOURCE_COMPILES("
	int main(void)
	{
	  char* ch = nullptr;
	  return *ch;
	}
	" HAVE_NULLPTR
	)
CHECK_CXX_SOURCE_COMPILES("
	int main(void)
	{
	  long long int ch = 0;
	  return (int)ch;
	}
	" HAVE_LONG_LONG_INT
	)
CHECK_CXX_SOURCE_COMPILES("
	int main(void)
	{
	  long long ch = 0;
	  return (int)ch;
	}
	" HAVE_LONG_LONG
	)
CHECK_CXX_SOURCE_COMPILES("
	int main(void)
	{
	  __int64 ch = 0;
	  return (int)ch;
	}
	" HAVE___INT64
	)
CHECK_CXX_SOURCE_COMPILES("
        int __cdecl test() { return 1; }
	int main(void)
	{
	  return test();
	}
	" HAVE___CDECL
	)
CHECK_CXX_SOURCE_COMPILES("
        int __stdcall test() { return 1; }
	int main(void)
	{
	  return test();
	}
	" HAVE___STDCALL
	)
CHECK_CXX_SOURCE_COMPILES("
        #include <stdio.h>
        #include <stdlib.h>
	int main(void)
	{
	  return (int)atoll(\"8\");
	}
	" HAVE_ATOLL
	)
CHECK_CXX_SOURCE_COMPILES("
        #include <stdio.h>
        #include <stdlib.h>
	int main(void)
	{
	  return (int)strtoll(\"8\", 0, 10);
	}
	" HAVE_STRTOLL
	)
CHECK_CXX_SOURCE_COMPILES("
        #include <stdio.h>
        #include <stdlib.h>
	int main(void)
	{
	  return (int)atoq(\"8\");
	}
	" HAVE_ATOQ
	)
CHECK_CXX_SOURCE_COMPILES("
        #include <stdio.h>
        #include <stdlib.h>
	int main(void)
	{
	  char buff[50];
	  return (int)_i64toa_s(4,buff,sizeof(buff)/sizeof(buff[0]),10);
	}
	" HAVE__I64TOA_S
	)
CHECK_CXX_SOURCE_COMPILES("
        #include <stdio.h>
        #include <stdlib.h>
	int main(void)
	{
	  return (int)_atoi64(\"99\");
	}
	" HAVE__ATOI64
	)
CHECK_FUNCTION_EXISTS(_atoi64, HAVE__ATOI64)


# if(HAVE_WINDOWS_H)
# CHECK_CXX_SOURCE_COMPILES("
    # #include <windows.h>
	# int main(void)
	# {
	  # IUnknown* ch = 0;
	  # return (int)ch;
	# }
	# " HAVE_IUNKNOWN
	# )
# CHECK_CXX_SOURCE_COMPILES("
        # #include <windows.h>
	# int main(void)
	# {
	  # return (int)IsBadReadPtr(\"8\", 1);
	# }
	# " HAVE_ISBADREADPTR
	# )
CHECK_CXX_SOURCE_COMPILES("
        #include <windows.h>
	int main(void)
	{
	LARGE_INTEGER li;
	  return (int)QueryPerformanceCounter(&li);
	}
	" HAVE_QUERYPERFORMANCECOUNTER
	)
CHECK_CXX_SOURCE_COMPILES("
        #include <windows.h>
	int main(void)
	{
	  long value = 0;
	  return InterlockedIncrement(&value);
	}
	" HAVE_INTERLOCKED_INCREMENT
	)
# CHECK_CXX_SOURCE_COMPILES("
        # #include <windows.h>
	# int main(void)
	# {
	  # BSTR value = 0;
	  # return *value;
	# }
	# " HAVE_BSTR
	# )
CHECK_CXX_SOURCE_COMPILES("
	#include <windows.h>
	int main(void)
	{
	  CRITICAL_SECTION ch;

	  return (&ch == 0) ? 1 : 0;
	}
	" HAVE_CRITICAL_SECTION
	)

# endif()

# look for system functions
include(CheckFunctionExists)
CHECK_FUNCTION_EXISTS(printf HAVE_PRINTF)
CHECK_FUNCTION_EXISTS(sprintf HAVE_SPRINTF)
CHECK_FUNCTION_EXISTS(vsnprintf HAVE_VSNPRINTF)
CHECK_FUNCTION_EXISTS(sprintf_s HAVE_SPRINTF_S)
CHECK_FUNCTION_EXISTS(vsprintf_s HAVE_VSPRINTF_S)
CHECK_FUNCTION_EXISTS(_vsnprintf_s HAVE__VSNPRINTF_S)
CHECK_FUNCTION_EXISTS(_snprintf_s HAVE__SNPRINTF_S)
CHECK_FUNCTION_EXISTS(vsnprintf_s HAVE_VSNPRINTF_S)
CHECK_FUNCTION_EXISTS(_vsnwprintf_s HAVE__VSNWPRINTF_S)
CHECK_FUNCTION_EXISTS(_snprintf HAVE__SNPRINTF)
CHECK_FUNCTION_EXISTS(snprintf HAVE_SNPRINTF)
CHECK_FUNCTION_EXISTS(sleep HAVE_sleep)
CHECK_FUNCTION_EXISTS(Sleep HAVE_Sleep)
CHECK_FUNCTION_EXISTS(_fseeki64 HAVE__FSEEKI64)
CHECK_FUNCTION_EXISTS(fseeko64 HAVE_FSEEKO64)
CHECK_FUNCTION_EXISTS(_getcwd HAVE__GETCWD)
CHECK_FUNCTION_EXISTS(getcwd HAVE_GETCWD)
CHECK_FUNCTION_EXISTS(_chdir HAVE__CHDIR)
CHECK_FUNCTION_EXISTS(chdir HAVE_CHDIR)
CHECK_FUNCTION_EXISTS(_unlink HAVE__UNLINK)
CHECK_FUNCTION_EXISTS(unlink HAVE_UNLINK)
# CHECK_FUNCTION_EXISTS(getpeereid HAVE_GETPEEREID)

CHECK_FUNCTION_EXISTS(strlen HAVE_STRLEN)
CHECK_FUNCTION_EXISTS(strnicmp HAVE_STRNICMP)
CHECK_FUNCTION_EXISTS(strncasecmp HAVE_STRNCASECMP)
CHECK_FUNCTION_EXISTS(_strncasecmp HAVE__STRNCASECMP)
CHECK_FUNCTION_EXISTS(_strnicmp HAVE__STRNICMP)
CHECK_FUNCTION_EXISTS(stricmp HAVE_STRICMP)
CHECK_FUNCTION_EXISTS(strcasecmp HAVE_STRCASECMP)
CHECK_FUNCTION_EXISTS(_strcasecmp HAVE__STRCASECMP)
CHECK_FUNCTION_EXISTS(_stricmp HAVE__STRICMP)
CHECK_FUNCTION_EXISTS(strtok HAVE_STRTOK)
CHECK_FUNCTION_EXISTS(strtok_s HAVE_STRTOK_S)
CHECK_FUNCTION_EXISTS(strtok_r HAVE_STRTOK_R)
CHECK_FUNCTION_EXISTS(strupr HAVE_STRUPR)
CHECK_FUNCTION_EXISTS(_strupr HAVE__STRUPR)
CHECK_FUNCTION_EXISTS(_strupr_s HAVE__STRUPR_S)
CHECK_FUNCTION_EXISTS(strstr HAVE_STRSTR)

CHECK_FUNCTION_EXISTS(strncpy_s HAVE_STRNCPY_S)
CHECK_FUNCTION_EXISTS(strncpy HAVE_STRNCPY)
CHECK_FUNCTION_EXISTS(strcpy_s HAVE_STRCPY_S)
CHECK_FUNCTION_EXISTS(strcpy HAVE_STRCPY)
CHECK_FUNCTION_EXISTS(strcat_s HAVE_STRCAT_S)
CHECK_FUNCTION_EXISTS(strcat HAVE_STRCAT)
CHECK_FUNCTION_EXISTS(gettimeofday HAVE_GETTIMEOFDAY)

CHECK_FUNCTION_EXISTS(fopen HAVE_FOPEN)
CHECK_FUNCTION_EXISTS(fopen_s HAVE_FOPEN_S)
CHECK_FUNCTION_EXISTS(fclose HAVE_FCLOSE)
CHECK_FUNCTION_EXISTS(feof HAVE_FEOF)
CHECK_FUNCTION_EXISTS(fgets HAVE_FGETS)
CHECK_FUNCTION_EXISTS(gets_s HAVE_GETS_S)
CHECK_FUNCTION_EXISTS(gets HAVE_GETS)
CHECK_FUNCTION_EXISTS(fread HAVE_FREAD)
CHECK_FUNCTION_EXISTS(fwrite HAVE_FWRITE)
CHECK_FUNCTION_EXISTS(_ftelli64 HAVE__FTELLI64)
CHECK_FUNCTION_EXISTS(ftello64 HAVE_FTELLO64)
CHECK_FUNCTION_EXISTS(ftell HAVE_FTELL)
CHECK_FUNCTION_EXISTS(htonl HAVE_HTONL)
# CHECK_FUNCTION_EXISTS(getpwnam HAVE_GETPWNAM)
# CHECK_FUNCTION_EXISTS(getpwnam_r HAVE_GETPWNAM_R)

if(HAVE_WINDOWS_H)
    set(HAVE_INT_PTR 1)
else()
    # TODO:  Need a good test for INT_PTR here
endif()

set(symheaders "stdio.h")
if(HAVE_LIMITS_H)
set(symheaders "${symheaders};limits.h")
endif()
if(HAVE_MATH_H)
set(symheaders "${symheaders};math.h")
endif()
if(HAVE_WINDOWS_H)
set(symheaders "${symheaders};windows.h")
endif()

CHECK_SYMBOL_EXISTS(INT_MAX "${symheaders}" HAVE_SYM_INT_MAX)
CHECK_SYMBOL_EXISTS(MAXINT "${symheaders}" HAVE_SYM_MAXINT)
CHECK_SYMBOL_EXISTS(INT_MIN "${symheaders}" HAVE_SYM_INT_MIN)
CHECK_SYMBOL_EXISTS(UNREFERENCED_PARAMETER "${symheaders}" HAVE_SYM_UNREFERENCED_PARAMETER)
CHECK_SYMBOL_EXISTS(FALSE "${symheaders}" HAVE_SYM_FALSE)
CHECK_SYMBOL_EXISTS(MAX_PATH "${symheaders}" HAVE_SYM_MAX_PATH)

if(CMAKE_COMPILER_IS_GNUCC)
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra -Wdeclaration-after-statement -Wstrict-prototypes")
endif()

if(${CMAKE_BUILD_TYPE} STREQUAL "Debug")
    set(PROJECT_POSTFIX _d)
else()
    set(PROJECT_POSTFIX )
endif()

set(HAVE_SMARTCARD 0)
if(HAVE_WINDOWS_H)
    set(HAVE_SMARTCARD 1)
elseif(TARGET pcsc)
    set(HAVE_SMARTCARD 1)
elseif(APPLE)
    set(HAVE_SMARTCARD 1)
endif(HAVE_WINDOWS_H)

CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/SolutionItems/compilerconfig.h.in ${CMAKE_CURRENT_BINARY_DIR}/core/compilerconfig.h)
# CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/SolutionItems/compilerconfig_c.h.in ${CMAKE_CURRENT_BINARY_DIR}/core/compilerconfig_c.h)

include_directories(
	${CMAKE_CURRENT_BINARY_DIR} 
	${CMAKE_CURRENT_SOURCE_DIR}/include 
	${CMAKE_CURRENT_SOURCE_DIR}/SolutionItems
	)

IF(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/ThirdParty/bzip2")
	include_directories(${CMAKE_CURRENT_SOURCE_DIR}/ThirdParty/bzip2)
ENDIF(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/ThirdParty/bzip2")
if(NOT ANDROID)
	IF(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/ThirdParty/zlib")
		include_directories(${CMAKE_CURRENT_SOURCE_DIR}/ThirdParty/zlib)
		include_directories(${CMAKE_CURRENT_BINARY_DIR}/ThirdParty/zlib)
	ENDIF(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/ThirdParty/zlib")
ELSE()
	set(CMAKE_INSTALL_DO_STRIP ON)
ENDIF()

add_subdirectory(core)
add_subdirectory(xml2Asn1CodeGen)
add_subdirectory(tsschemagen)
add_subdirectory(file2hex)
add_subdirectory(fileTob64)
add_subdirectory(hex2file)
add_subdirectory(OID2Hex)
add_subdirectory(b64Tofile)
IF(WIN32)
    add_subdirectory(Com2H)
ENDIF(WIN32)
add_subdirectory(Utf16ToUtf8)

summary()
add_uninstall()

# DumpAllVariables()
