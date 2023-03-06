##  #pragma c2nim mangle "'rosidl_runtime_c__' {\\w+}" "$1"
##  #pragma c2nim mangle "'namespace_'" "namespace"
##  #pragma c2nim mangle "'rmw_time_s'" "rmw_time_t"

##  Copyright 2014-2018 Open Source Robotics Foundation, Inc.
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
  ./init_options, rcutils/allocator, rcutils/allocator, rcutils/allocator,
  rcutils/macros, rcutils/macros, rcutils/macros, rcutils/macros,
  rcutils/macros, rcutils/allocator, rcutils/types/rcutils_ret,
  rcutils/allocator, rcutils/visibility_control_macros,
  rcutils/visibility_control_macros, rcutils/allocator, ./init_options,
  ./domain_id, ./init_options, ./localhost, ./localhost, ./init_options,
  ./init_options, ./ret_types, ./init_options, ./security_options,
  ./security_options, ./init_options

type

  rmw_context_impl_t* {.importc: "rmw_context_impl_t", header: "init.h", bycopy.} = object ##
                              ##  Implementation defined context structure returned by rmw_init().
                              ##
                              ##  This should be defined by the rmw implementation.
                              ##


  rmw_context_t* {.importc: "rmw_context_t", header: "init.h", bycopy.} = object
    instance_id* {.importc: "instance_id".}: uint64 ##
                              ##  Locally (process local) unique ID that represents this init/shutdown cycle.
    implementation_identifier* {.importc: "implementation_identifier".}: cstring ##
                              ##  Implementation identifier, used to ensure two different implementations are not being mixed.
    options* {.importc: "options".}: rmw_init_options_t ##
                              ##  Options used to initialize the context.
    actual_domain_id* {.importc: "actual_domain_id".}: csize_t ##
                              ##  Domain id that is being used.
    ##  Implementation defined context information.
    impl* {.importc: "impl".}: ptr rmw_context_impl_t ##
                              ##  May be NULL if there is no implementation defined context information.


##  Initialization context structure which is used to store init specific information.


proc rmw_get_zero_initialized_context*(): rmw_context_t {.
    importc: "rmw_get_zero_initialized_context", header: "init.h".}
  ##
                              ##  Return a zero initialized context structure.

proc rmw_init*(options: ptr rmw_init_options_t; context: ptr rmw_context_t): rmw_ret_t {.
    importc: "rmw_init", header: "init.h".}
  ##  Initialize the middleware with the given options, and yielding an context.
                                           ##
                                           ##  Context is filled with middleware specific data upon success of this function.
                                           ##  The context is used when initializing some entities like nodes and
                                           ##  guard conditions, and is also required to properly call `rmw_shutdown()`.
                                           ##
                                           ##  \pre The given options must have been initialized
                                           ##    i.e. `rmw_init_options_init()` called on it and
                                           ##    an enclave set.
                                           ##  \pre The given context must be zero initialized.
                                           ##
                                           ##  \post If initialization fails, context will remain zero initialized.
                                           ##  \post `context->actual_domain_id` will be set with the domain id the rmw implementation is using.
                                           ##   This matches `options->domain_id` if it is not RMW_DEFAULT_DOMAIN_ID.
                                           ##   In other case, the value is rmw implementation dependent.
                                           ##
                                           ##  \remarks If options are zero-initialized, then `RMW_RET_INVALID_ARGUMENT` is returned.
                                           ##    If options are initialized but no enclave is provided, then `RMW_RET_INVALID_ARGUMENT`
                                           ##    is returned.
                                           ##    If context has been already initialized (`rmw_init()` was called on it), then
                                           ##    `RMW_RET_INVALID_ARGUMENT` is returned.
                                           ##
                                           ##  <hr>
                                           ##  Attribute          | Adherence
                                           ##  ------------------ | -------------
                                           ##  Allocates Memory   | Yes
                                           ##  Thread-Safe        | No
                                           ##  Uses Atomics       | No
                                           ##  Lock-Free          | Yes
                                           ##
                                           ##  This should be defined by the rmw implementation.
                                           ##
                                           ##  \param[in] options initialization options to be used during initialization
                                           ##  \param[out] context resulting context struct
                                           ##  \return `RMW_RET_OK` if successful, or
                                           ##  \return `RMW_RET_INVALID_ARGUMENT` if any arguments are invalid, or
                                           ##  \return `RMW_RET_INCORRECT_RMW_IMPLEMENTATION` if the implementation
                                           ##    identifier does not match, or
                                           ##  \return `RMW_RET_ERROR` if an unexpected error occurs.
                                           ##

proc rmw_shutdown*(context: ptr rmw_context_t): rmw_ret_t {.
    importc: "rmw_shutdown", header: "init.h".}
  ##  Shutdown the middleware for a given context.
                                               ##
                                               ##  \pre The given context must be a valid context which has been initialized with `rmw_init()`.
                                               ##
                                               ##  \remarks If context is zero initialized, then `RMW_RET_INVALID_ARGUMENT` is returned.
                                               ##    If context has been already invalidated (`rmw_shutdown()` was called on it), then
                                               ##    this function is a no-op and `RMW_RET_OK` is returned.
                                               ##
                                               ##  <hr>
                                               ##  Attribute          | Adherence
                                               ##  ------------------ | -------------
                                               ##  Allocates Memory   | Yes
                                               ##  Thread-Safe        | No
                                               ##  Uses Atomics       | No
                                               ##  Lock-Free          | Yes
                                               ##
                                               ##  This should be defined by the rmw implementation.
                                               ##
                                               ##  \param[in] context resulting context struct
                                               ##  \return `RMW_RET_OK` if successful, or
                                               ##  \return `RMW_RET_INVALID_ARGUMENT` if any argument are invalid, or
                                               ##  \return `RMW_RET_INCORRECT_RMW_IMPLEMENTATION` if the implementation
                                               ##    identifier does not match, or
                                               ##  \return `RMW_RET_ERROR` if an unexpected error occurs.
                                               ##

proc rmw_context_fini*(context: ptr rmw_context_t): rmw_ret_t {.
    importc: "rmw_context_fini", header: "init.h".}
  ##
                              ##  Finalize a context.
                              ##
                              ##  This function will return early if a logical error, such as `RMW_RET_INVALID_ARGUMENT`
                              ##  or `RMW_RET_INCORRECT_RMW_IMPLEMENTATION`, ensues, leaving the given context unchanged.
                              ##  Otherwise, it will proceed despite errors, freeing as much resources as it can and zero
                              ##  initializing the given context.
                              ##
                              ##  \pre The context to be finalized must have been previously initialized with
                              ##    `rmw_init()`, and then later invalidated with `rmw_shutdown()`.
                              ##
                              ##  \remarks If context is zero initialized, then `RMW_RET_INVALID_ARGUMENT` is returned.
                              ##    If context is initialized and valid (`rmw_shutdown()` was not called on it), then
                              ##    `RMW_RET_INVALID_ARGUMENT` is returned.
                              ##
                              ##  <hr>
                              ##  Attribute          | Adherence
                              ##  ------------------ | -------------
                              ##  Allocates Memory   | Yes
                              ##  Thread-Safe        | No
                              ##  Uses Atomics       | Yes
                              ##  Lock-Free          | Yes [1]
                              ##  <i>[1] if `atomic_is_lock_free()` returns true for `atomic_uint_least64_t`</i>
                              ##
                              ##  This should be defined by the rmw implementation.
                              ##
                              ##  \return `RMW_RET_OK` if successful, or
                              ##  \return `RMW_RET_INVALID_ARGUMENT` if any arguments are invalid, or
                              ##  \return `RMW_RET_INCORRECT_RMW_IMPLEMENTATION` if the implementation
                              ##    identifier does not match, or
                              ##  \return `RMW_RET_ERROR` if an unspecified error occur.
                              ## 