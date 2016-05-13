# install headers

set(OPENMEEGMATHS_HEADERS 
    DLLDefinesOpenMEEGMaths.h fast_sparse_matrix.h linop.h OpenMEEGMathsConfig.h 
    matrix.h symmatrix.h sparse_matrix.h vector.h
    AsciiIO.H BrainVisaTextureIO.H MathsIO.H MatlabIO.H TrivialBinIO.H
    #   These files are imported from another repository.
    #   Please do not update them in this repository.
    Exceptions.H IOUtils.H)

install(FILES ${OPENMEEGMATHS_HEADERS}
        DESTINATION ${OPENMEEG_HEADER_INSTALLDIR} COMPONENT Development)
