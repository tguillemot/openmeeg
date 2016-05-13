# Find the matio headers and library.
#
#  flens_INCLUDE_DIRS - where to find matio.h, etc.
#  flens_FOUND        - True if matio found.

#   We provide a module in case matio has not been found in config mode.

if (NOT flens_INCLUDE_DIRS)

    #find_package(HDF5 REQUIRED)

    # Look for the header file.

    find_path(flens_INCLUDE_DIR NAMES flens/flens.cxx PATHS ${flens_DIR}/include)
    mark_as_advanced(flens_INCLUDE_DIR)

    # handle the QUIETLY and REQUIRED arguments and set matio_FOUND to TRUE if 
    # all listed variables are TRUE

    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(flens DEFAULT_MSG "" flens_INCLUDE_DIR)
    
    if (FLENS_FOUND)
        set(flens_FOUND TRUE)
        set(flens_INCLUDE_DIRS ${flens_INCLUDE_DIR})
    else()
        set(flens_LIBRARIES)
        set(flens_INCLUDE_DIRS)
    endif()

    #include(flensVersion)
endif()
