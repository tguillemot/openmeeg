# OpenMEEG
#
# Copyright (c) INRIA 2013-2016. All rights reserved.
# See LICENSE.txt for details.
# 
#  This software is distributed WITHOUT ANY WARRANTY; without even
#  the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
#  PURPOSE.

macro(flens_find_package)
#   Do nothing let OpenMEEG do the work.
endmacro()

function(flens_project)

    # Prepare the project and list dependencies

    EP_Initialisation(flens BUILD_SHARED_LIBS ON)
      
    # Define repository where get the sources

    if (NOT DEFINED ${ep}_SOURCE_DIR)
        set(location GIT_REPOSITORY "${GIT_PREFIX}github.com/michael-lehn/FLENS.git")
        message("${GIT_REPOSITORY}")
    endif()

    # set compilation flags

    set(cmake_args
        ${ep_common_cache_args}
        ${ep_optional_args}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    )

    # Check if patch has to be applied

    ep_GeneratePatchCommand(${ep} PATCH_COMMAND)

    # Add external-project

    set(tag public)
    ExternalProject_Add(${ep}
        ${ep_dirs}
        ${location}
        GIT_TAG ${tag}
        UPDATE_COMMAND ${GIT_BIN} pull
        ${PATCH_COMMAND}
        CMAKE_GENERATOR ${gen}
        CMAKE_ARGS ${cmake_args}
        DEPENDS ${${ep}_dependencies}
    )

    # Set variable to provide infos about the project

    ExternalProject_Get_Property(${ep} install_dir)
    set(${ep}_CMAKE_FLAGS -D${ep}_DIR:FILEPATH=${install_dir} PARENT_SCOPE)
    #set(${ep}_CXX_FLAGS "-I${install_dir}/include;-DWITH_GOTOBLAS" PARENT_SCOPE)

endfunction()
