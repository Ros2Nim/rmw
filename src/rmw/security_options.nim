##  Copyright 2020 Open Source Robotics Foundation, Inc.
##
##  Licensed under the Apache License, Version 2.0 (the "License");
##  you may not use this file except in compliance with the License.
##  You may obtain a copy of the License at
##
##      http://www.apache.org/licenses/LICENSE-2.0
##
##  Unless required by applicable law or agreed to in writing, software
##  distributed under the License is distributed on an "AS IS" BASIS,
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##  See the License for the specific language governing permissions and
##  limitations under the License.

import
  rcutils/allocator, rcutils/allocator, rcutils/macros, rcutils/macros,
  rcutils/macros, rcutils/macros, rcutils/macros, rcutils/allocator,
  rcutils/types/rcutils_ret, rcutils/allocator, rcutils/visibility_control,
  rcutils/visibility_control_macros, rcutils/visibility_control_macros,
  rcutils/visibility_control, rcutils/allocator, ./ret_types, ./ret_types,
  ./visibility_control, ./visibility_control

type

  rmw_security_enforcement_policy_t* {.size: sizeof(cint).} = enum
    RMW_SECURITY_ENFORCEMENT_PERMISSIVE, RMW_SECURITY_ENFORCEMENT_ENFORCE

  rmw_security_options_t* {.importc: "rmw_security_options_t",
                            header: "security_options.h", bycopy.} = object
    enforce_security* {.importc: "enforce_security".}: rmw_security_enforcement_policy_t
    security_root_path* {.importc: "security_root_path".}: cstring




proc rmw_get_zero_initialized_security_options*(): rmw_security_options_t {.
    importc: "rmw_get_zero_initialized_security_options",
    header: "security_options.h".}
  ##  Get zero initialized security options.

proc rmw_get_default_security_options*(): rmw_security_options_t {.
    importc: "rmw_get_default_security_options", header: "security_options.h".}
  ##
                              ##  Get default initialized security options.

proc rmw_security_options_copy*(src: ptr rmw_security_options_t;
                                allocator: ptr rcutils_allocator_t;
                                dst: ptr rmw_security_options_t): rmw_ret_t {.
    importc: "rmw_security_options_copy", header: "security_options.h".}
  ##
                              ##  Copy the given security options.
                              ##
                              ##  \param[in] src security options to be copied.
                              ##  \param[in] allocator allocator used when copying data to the new security options.
                              ##  \param[out] dst security options to be set.
                              ##  \returns RMW_RET_BAD_ALLOC, or
                              ##  \returns RMW_RET_OK
                              ##

proc rmw_security_options_set_root_path*(security_root_path: cstring;
    allocator: ptr rcutils_allocator_t;
    security_options: ptr rmw_security_options_t): rmw_ret_t {.
    importc: "rmw_security_options_set_root_path", header: "security_options.h".}
  ##
                              ##  Set the security root path for the given security options.
                              ##
                              ##  The provided `security_root_path` will be copied into allocated memory.
                              ##
                              ##  \param[in] security_root_path path to be set.
                              ##  \param[in] allocator allocator used to allocate the new path.
                              ##  \param[inout] security_options security options to be set.
                              ##  \returns RMW_RET_BAD_ALLOC, or
                              ##  \returns RMW_RET_OK
                              ##

proc rmw_security_options_fini*(security_options: ptr rmw_security_options_t;
                                allocator: ptr rcutils_allocator_t): rmw_ret_t {.
    importc: "rmw_security_options_fini", header: "security_options.h".}
  ##
                              ##  Finalize the given security_options.
                              ##
                              ##  \param[in] security_options security options to be finalized.
                              ##  \param[in] allocator allocator used to deallocate the root path.
                              ##  \returns RMW_RET_ERROR, or
                              ##  \returns RMW_RET_OK
                              ## 