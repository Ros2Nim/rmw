##  Copyright 2017 Open Source Robotics Foundation, Inc.
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
  rcutils/allocator, rcutils/allocator, rcutils/allocator, rcutils/macros,
  rcutils/macros, rcutils/macros, rcutils/macros, rcutils/macros,
  rcutils/allocator, rcutils/types/rcutils_ret, rcutils/allocator,
  rcutils/visibility_control, rcutils/visibility_control_macros,
  rcutils/visibility_control_macros, rcutils/visibility_control,
  rcutils/allocator, rcutils/types/array_list, rcutils/types/array_list,
  rcutils/types/char_array, rcutils/types/char_array, rcutils/types/hash_map,
  rcutils/types/hash_map, rcutils/types/string_array,
  rcutils/types/string_array, rcutils/error_handling, rcutils/error_handling,
  rcutils/error_handling, rcutils/error_handling, rcutils/error_handling,
  rcutils/error_handling, rcutils/error_handling, rcutils/snprintf,
  rcutils/snprintf, rcutils/error_handling, rcutils/testing/fault_injection,
  rcutils/testing/fault_injection, rcutils/testing/fault_injection,
  rcutils/error_handling, rcutils/error_handling, rcutils/error_handling,
  rcutils/error_handling, rcutils/types/string_array, rcutils/qsort,
  rcutils/qsort, rcutils/types/string_array, rcutils/types/string_map,
  rcutils/types/string_map, rcutils/types/uint8_array,
  rcutils/types/uint8_array, ./types, ./types, rcutils/logging, rcutils/logging,
  ./types, ./events_statuses/events_statuses,
  ./events_statuses/incompatible_qos, ./qos_policy_kind, ./qos_policy_kind,
  ./events_statuses/incompatible_qos, ./events_statuses/events_statuses,
  ./events_statuses/liveliness_changed, ./events_statuses/liveliness_changed,
  ./events_statuses/events_statuses, ./events_statuses/liveliness_lost,
  ./events_statuses/liveliness_lost, ./events_statuses/events_statuses,
  ./events_statuses/message_lost, ./events_statuses/message_lost,
  ./events_statuses/events_statuses, ./events_statuses/offered_deadline_missed,
  ./events_statuses/offered_deadline_missed, ./events_statuses/events_statuses,
  ./events_statuses/requested_deadline_missed,
  ./events_statuses/requested_deadline_missed,
  ./events_statuses/events_statuses, ./types, ./init, ./init_options,
  ./init_options, ./domain_id, ./init_options, ./localhost, ./init_options,
  ./ret_types, ./init_options, ./security_options, ./security_options,
  ./init_options, ./init, ./types, ./serialized_message, ./types,
  ./subscription_content_filter_options, ./subscription_content_filter_options,
  ./types, ./time, ./time, ./types

type

  rmw_names_and_types_t* {.importc: "rmw_names_and_types_t",
                           header: "names_and_types.h", bycopy.} = object ##
                              ##  Associative array of topic or service names and types.
    names* {.importc: "names".}: rcutils_string_array_t ##
                              ##  Array of names
    types* {.importc: "types".}: ptr rcutils_string_array_t ##
                              ##  Dynamic array of arrays of type names, with the same length as `names`



proc rmw_get_zero_initialized_names_and_types*(): rmw_names_and_types_t {.
    importc: "rmw_get_zero_initialized_names_and_types",
    header: "names_and_types.h".}
  ##  Return a zero initialized array of names and types.

proc rmw_names_and_types_check_zero*(names_and_types: ptr rmw_names_and_types_t): rmw_ret_t {.
    importc: "rmw_names_and_types_check_zero", header: "names_and_types.h".}
  ##
                              ##  Check that the given `names_and_types` array is zero initialized.
                              ##
                              ##  <hr>
                              ##  Attribute          | Adherence
                              ##  ------------------ | -------------
                              ##  Allocates Memory   | No
                              ##  Thread-Safe        | Yes
                              ##  Uses Atomics       | No
                              ##  Lock-Free          | Yes
                              ##
                              ##  \par Thread-safety
                              ##    Access to the array of names and types is read-only, but it is not synchronized.
                              ##    Concurrent `names_and_types` reads are safe, but concurrent reads and writes are not.
                              ##
                              ##  \param[in] names_and_types Array to be checked.
                              ##  \return RMW_RET_OK if array is zero initialized, RMW_RET_INVALID_ARGUMENT otherwise.
                              ##  \remark This function sets the RMW error state on failure.
                              ##

proc rmw_names_and_types_init*(names_and_types: ptr rmw_names_and_types_t;
                               size: csize_t; allocator: ptr rcutils_allocator_t): rmw_ret_t {.
    importc: "rmw_names_and_types_init", header: "names_and_types.h".}
  ##
                              ##  Initialize an array of names and types.
                              ##
                              ##  This function initializes the string array for the names and allocates space
                              ##  for all the string arrays for the types according to the given size, but
                              ##  it does not initialize the string array for each setup of types.
                              ##  However, the string arrays for each set of types is zero initialized.
                              ##
                              ##  <hr>
                              ##  Attribute          | Adherence
                              ##  ------------------ | -------------
                              ##  Allocates Memory   | Yes
                              ##  Thread-Safe        | No
                              ##  Uses Atomics       | No
                              ##  Lock-Free          | Yes
                              ##
                              ##  \par Thread-safety
                              ##    Initialization is a reentrant procedure, but:
                              ##    - Access to arrays of names and types is not synchronized.
                              ##      It is not safe to read or write `names_and_types` during initialization.
                              ##    - The default allocators are thread-safe objects, but any custom `allocator` may not be.
                              ##      Check your allocator documentation for further reference.
                              ##
                              ##  \param[inout] names_and_types Array to be initialized on success,
                              ##    but left unchanged on failure.
                              ##  \param[in] size Size of the array.
                              ##  \param[in] allocator Allocator to be used to populate `names_and_types`.
                              ##  \returns `RMW_RET_OK` if successful, or
                              ##  \returns `RMW_RET_INVALID_ARGUMENT` if `names_and_types` is NULL, or
                              ##  \returns `RMW_RET_INVALID_ARGUMENT` if `names_and_types` is not
                              ##    a zero initialized array, or
                              ##  \returns `RMW_RET_INVALID_ARGUMENT` if `allocator` is invalid,
                              ##    by rcutils_allocator_is_valid() definition, or
                              ##  \returns `RMW_BAD_ALLOC` if memory allocation fails, or
                              ##  \returns `RMW_RET_ERROR` when an unspecified error occurs.
                              ##  \remark This function sets the RMW error state on failure.
                              ##

proc rmw_names_and_types_fini*(names_and_types: ptr rmw_names_and_types_t): rmw_ret_t {.
    importc: "rmw_names_and_types_fini", header: "names_and_types.h".}
  ##
                              ##  Finalize an array of names and types.
                              ##
                              ##  This function deallocates the string array of names and the array of string arrays of types,
                              ##  and zero initializes the given array.
                              ##  If a logical error, such as `RMW_RET_INVALID_ARGUMENT`, ensues, this function will return
                              ##  early, leaving the given array unchanged.
                              ##  Otherwise, it will proceed despite errors.
                              ##
                              ##  <hr>
                              ##  Attribute          | Adherence
                              ##  ------------------ | -------------
                              ##  Allocates Memory   | No
                              ##  Thread-Safe        | No
                              ##  Uses Atomics       | No
                              ##  Lock-Free          | Yes
                              ##
                              ##  \par Thread-safety
                              ##    Finalization is a reentrant procedure, but access to arrays of names and types
                              ##    is not synchronized.
                              ##    It is not safe to read or write `names_and_types` during initialization.
                              ##
                              ##  \param[inout] names_and_types Array to be finalized.
                              ##  \returns `RMW_RET_OK` if successful, or
                              ##  \returns `RMW_RET_INVALID_ARGUMENT` if `names_and_types` is NULL, or
                              ##  \returns `RMW_RET_ERROR` when an unspecified error occurs.
                              ##  \remark This function sets the RMW error state on failure.
                              ## 