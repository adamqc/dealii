#####
##
## Copyright (C) 2012 by the deal.II authors
##
## This file is part of the deal.II library.
##
## <TODO: Full License information>
## This file is dual licensed under QPL 1.0 and LGPL 2.1 or any later
## version of the LGPL license.
##
## Author: Matthias Maier <matthias.maier@iwr.uni-heidelberg.de>
##
#####

#
# Try to find the SuiteSparse_config package
#
# This is a helper module for FindUMFPACK.cmake
#
# This module exports
#
#   SUITESPARSECONFIG_LIBRARY
#   SUITESPARSECONFIG_INCLUDE_DIR
#

INCLUDE(FindPackageHandleStandardArgs)

SET_IF_EMPTY(UMFPACK_DIR "$ENV{UMFPACK_DIR}")
SET_IF_EMPTY(SUITESPARSE_DIR "$ENV{SUITESPARSECONFIG_DIR}")

FIND_PATH(SUITESPARSECONFIG_INCLUDE_DIR SuiteSparse_config.h
  HINTS
    ${SUITESPARSECONFIG_DIR}
    ${UMFPACK_DIR}
    ${UMFPACK_DIR}/../SuiteSparse_config
  PATH_SUFFIXES
    include SuiteSparse_config
)

FIND_LIBRARY(SUITESPARSECONFIG_LIBRARY
  NAMES suitesparseconfig
  HINTS
    ${SUITESPARSECONFIG_DIR}
    ${UMFPACK_DIR}
    ${UMFPACK_DIR}/../SuiteSparse_config
  PATH_SUFFIXES
    lib${LIB_SUFFIX} lib64 lib SuiteSparse_config
  )

FIND_PACKAGE_HANDLE_STANDARD_ARGS(SUITESPARSECONFIG DEFAULT_MSG
  SUITESPARSECONFIG_LIBRARY
  SUITESPARSECONFIG_INCLUDE_DIR
  )

IF(SUITESPARSECONFIG_FOUND)
  MARK_AS_ADVANCED(
    SUITESPARSECONFIG_LIBRARY
    SUITESPARSECONFIG_INCLUDE_DIR
    SUITESPARSECONFIG_DIR
  )
ELSE()
  SET(SUITESPARSECONFIG_DIR "" CACHE STRING
    "An optional hint to a SuiteSparse_config directory"
    )
ENDIF()

