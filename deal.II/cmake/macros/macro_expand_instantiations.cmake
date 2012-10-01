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
# A macro for the inst.in file expansion
#
# Usage:
#     EXPAND_INSTANTATIONS(target inst_in_files)
#
# Options:
#
# target
#
#    where target.${build_type} will depend on the generation of all .inst
#    files, to ensure that all .inst files are generated prior to
#    compiling.
#
# inst_in_files
#
#    a list of inst.in files that will be expanded
#

MACRO(EXPAND_INSTANTIATIONS target inst_in_files)
  FOREACH (inst_in_file ${inst_in_files})
    STRING(REGEX REPLACE "\\.in$" "" inst_file "${inst_in_file}" )

    ADD_CUSTOM_COMMAND(
      OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${inst_file}
      DEPENDS expand_instantiations
              ${CMAKE_CURRENT_SOURCE_DIR}/${inst_in_file}
      COMMAND expand_instantiations
      ARGS ${CMAKE_BINARY_DIR}/config/template-arguments
           < ${CMAKE_CURRENT_SOURCE_DIR}/${inst_in_file}
           > ${CMAKE_CURRENT_BINARY_DIR}/${inst_file}
      )

    LIST(APPEND inst_targets ${CMAKE_CURRENT_BINARY_DIR}/${inst_file})
  ENDFOREACH()

  #
  # Define a custom target that depends on the generation of all inst.in
  # files.
  #
  ADD_CUSTOM_TARGET(${target}.inst ALL DEPENDS ${inst_targets})

  #
  # Add a dependency to all target.${build_type} so that target.inst is
  # fully generated before target will be processed.
  #
  FOREACH(build ${DEAL_II_BUILD_TYPES})
    STRING(TOLOWER ${build} build_lowercase)
    ADD_DEPENDENCIES(${target}.${build_lowercase} ${target}.inst)
  ENDFOREACH()

ENDMACRO()

