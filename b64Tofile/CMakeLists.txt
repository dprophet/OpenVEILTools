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


INCLUDE_DIRECTORIES(
    ${CMAKE_CURRENT_SOURCE_DIR} 
    )

IF(WIN32)
    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/b64Tofile.rc.in ${CMAKE_CURRENT_BINARY_DIR}/b64Tofile.rc)
    set_source_files_properties(${CMAKE_CURRENT_BINARY_DIR}/b64Tofile.rc PROPERTIES COMPILE_DEFINITIONS RC_COMPILED)
    set(CppSources ${CppSources} ${CMAKE_CURRENT_BINARY_DIR}/b64Tofile.rc b64Tofile.rc.in)
ENDIF(WIN32)

add_executable(b64Tofile 
	stdafx.cpp 
	stdafx.h
	b64Tofile.cpp 
	)
# add_precompiled_header(b64Tofile stdafx.h FORCEINCLUDE SOURCE_CXX stdafx.cpp)
# add_dependencies(b64Tofile toolsBase)
# SetCxxExeTargetProperties_sdk(b64Tofile)
set_target_properties(b64Tofile PROPERTIES FOLDER "GeneralTools")
set_source_files_properties(${CMAKE_CURRENT_BINARY_DIR}/b64Tofile.rc PROPERTIES COMPILE_DEFINITIONS RC_COMPILED)
TARGET_LINK_LIBRARIES(b64Tofile 
	ToolsCore
)

install(TARGETS b64Tofile ARCHIVE DESTINATION ${LIB_DIR} LIBRARY DESTINATION ${SHLIB_DIR} RUNTIME DESTINATION ${BIN_DIR})
