macro(PARSE_ARGUMENTS LIST_VARS BOOLEAN_VARS DEFAULT_VAR)
    set(CURRENT_VAR ${DEFAULT_VAR})
    foreach (arg ${ARGN})
        set(skip_this_arg FALSE)
        foreach(var ${LIST_VARS})
            if (${arg} STREQUAL ${var})
                set(CURRENT_VAR ${var})
                set(skip_this_arg TRUE)
                break()
            endif()
        endforeach ()
        if (NOT skip_this_arg)
            set(skip_this_arg FALSE)
            foreach(var ${BOOLEAN_VARS})
                if (${arg} STREQUAL ${var})
                    set(${var} TRUE)
                    set(skip_this_arg TRUE)
                    break()
                endif()
            endforeach()
            if (NOT skip_this_arg)
                set(${CURRENT_VAR} ${${CURRENT_VAR}} ${arg})
            endif()
        endif()
    endforeach ()
endmacro()

function(NEW_EXECUTABLE EXECUTABLE)
    set(EXCLUDE_FROM_ALL)
    set(SOURCES)
    set(LIBRARIES)
    set(DEFAULT)
    PARSE_ARGUMENTS("SOURCES;LIBRARIES" "EXCLUDE_FROM_ALL" "DEFAULT" ${ARGN})
    set(SOURCES ${DEFAULT} ${SOURCES})
    if (EXCLUDE_FROM_ALL)
        set(EXCLUDE_FROM_ALL EXCLUDE_FROM_ALL)
    endif()
    add_executable(${EXECUTABLE} ${EXCLUDE_FROM_ALL} ${SOURCES})
    target_link_libraries(${EXECUTABLE} ${LIBRARIES})
endfunction()

macro(OPENMEEG_EXECUTABLE EXECUTABLE)
    NEW_EXECUTABLE(${EXECUTABLE} ${ARGN} LIBRARIES OpenMEEG ${LAPACK_LIBRARIES} ${VTK_LIBRARIES})
endmacro()

OPENMEEG_EXECUTABLE(om_minverser minverser.cpp)
OPENMEEG_EXECUTABLE(om_gain gain.cpp)
OPENMEEG_EXECUTABLE(om_forward forward.cpp)
OPENMEEG_EXECUTABLE(om_assemble assemble.cpp)

# ================
# = INSTALLATION =
# ================

install(TARGETS om_assemble om_forward om_gain om_minverser
        RUNTIME DESTINATION ${INSTALL_BIN_DIR}
        LIBRARY DESTINATION ${INSTALL_LIB_DIR}
        ARCHIVE DESTINATION ${INSTALL_LIB_DIR})

# ===========
# = TESTING =
# ===========

if (BUILD_TESTING)
    include(TestHead.txt)

    # those models should give same results !
    #TESTHEAD(0)
    #TESTHEAD(NNa0)
    TESTHEAD(1)
    TESTHEAD(NNa1)
    TESTHEAD(NNb1)
    TESTHEAD(NNc1)

    TESTHEAD(2)
    if (USE_VTK)
        TESTHEAD(NNa2)
        TESTHEAD(NNb2)
        TESTHEAD(NNc2)
    endif()

    option(TEST_HEAD3 "Run tests on Head 3" OFF)

    if (TEST_HEAD3)
        TESTHEAD(3)
        if (USE_VTK)
            TESTHEAD(NNa3)
            TESTHEAD(NNb3)
            TESTHEAD(NNc3)
        endif()
    endif()

    # multiple nonconductive tests
    TESTHEAD(MN1)
    TESTHEAD(MN2)
    TESTHEAD(MN3)
endif()
