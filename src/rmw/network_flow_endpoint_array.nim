##  Copyright 2020 Ericsson AB
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
  rcutils/allocator, rcutils/macros, rcutils/types/rcutils_ret,
  rcutils/visibility_control_macros, ./network_flow_endpoint, ./types,
  rcutils/logging, rcutils/error_handling, rcutils/snprintf,
  rcutils/testing/fault_injection, rcutils/types/array_list,
  rcutils/types/char_array, rcutils/types/hash_map, rcutils/types/string_array,
  rcutils/qsort, rcutils/types/string_map, rcutils/types/uint8_array,
  ./events_statuses/events_statuses, ./events_statuses/incompatible_qos,
  ./qos_policy_kind, ./events_statuses/liveliness_changed,
  ./events_statuses/liveliness_lost, ./events_statuses/message_lost,
  ./events_statuses/offered_deadline_missed,
  ./events_statuses/requested_deadline_missed, ./init, ./init_options,
  ./domain_id, ./localhost, ./ret_types, ./security_options,
  ./serialized_message, ./subscription_content_filter_options, ./time


type

  rmw_network_flow_endpoint_array_t* {.importc: "rmw_network_flow_endpoint_array_t",
                                       header: "network_flow_endpoint_array.h",
                                       bycopy.} = object ##
                              ##  Structure to hold an arrary of network_flow_endpoint_t
    size* {.importc: "size".}: csize_t ##  Size of the array
    network_flow_endpoint* {.importc: "network_flow_endpoint".}: ptr rmw_network_flow_endpoint_t ##
                              ##  Array of rmw_network_flow_endpoint_t
    allocator* {.importc: "allocator".}: ptr rcutils_allocator_t ##
                              ##  Allocator




proc rmw_get_zero_initialized_network_flow_endpoint_array*(): rmw_network_flow_endpoint_array_t {.
    importc: "rmw_get_zero_initialized_network_flow_endpoint_array",
    header: "network_flow_endpoint_array.h".}
  ##  Return a rmw_network_flow_endpoint_array_t instance with zero-initialized members

proc rmw_network_flow_endpoint_array_check_zero*(
    network_flow_endpoint_array: ptr rmw_network_flow_endpoint_array_t): rmw_ret_t {.
    importc: "rmw_network_flow_endpoint_array_check_zero",
    header: "network_flow_endpoint_array.h".}
  ##  Check if network_flow_endpoint_array instance is zero-initialized
                                             ##
                                             ##  \param[in] network_flow_endpoint_array arrary to be checked
                                             ##  \returns `RMW_RET_OK` if array is zero-initialized, or
                                             ##  \returns `RMW_RET_INVALID_ARGUMENT` if `network_flow_endpoint_array` is NULL, or
                                             ##  \returns `RMW_RET_ERROR` if `network_flow_endpoint_array` is not zero-initialized.
                                             ##  \remark RMW error state is set on failure
                                             ##

proc rmw_network_flow_endpoint_array_init*(
    network_flow_endpoint_array: ptr rmw_network_flow_endpoint_array_t;
    size: csize_t; allocator: ptr rcutils_allocator_t): rmw_ret_t {.
    importc: "rmw_network_flow_endpoint_array_init",
    header: "network_flow_endpoint_array.h".}
  ##  Allocate a rmw_network_flow_endpoint_array_t instance
                                             ##
                                             ##  \param[inout] network_flow_endpoint_array array to be allocated
                                             ##  \param[in] size size of the array to be allocated
                                             ##  \param[in] allocator the allcator for allocating memory
                                             ##  \returns `RMW_RET_OK` on successfull initilization, or
                                             ##  \returns `RMW_RET_INVALID_ARGUMENT` if `network_flow_endpoint_array` or `allocator` is NULL, or
                                             ##  \returns `RMW_RET_BAD_ALLOC` if memory allocation fails, or
                                             ##  \returns `RMW_RET_ERROR` when an unspecified error occurs.
                                             ##  \remark RMW error state is set on failure
                                             ##

proc rmw_network_flow_endpoint_array_fini*(
    network_flow_endpoint_array: ptr rmw_network_flow_endpoint_array_t): rmw_ret_t {.
    importc: "rmw_network_flow_endpoint_array_fini",
    header: "network_flow_endpoint_array.h".}
  ##  Deallocate a rmw_network_flow_endpoint_array_t instance
                                             ##
                                             ##  \param[inout] network_flow_endpoint_array array to be deallocated
                                             ##  \returns `RMW_RET_OK` on successfully deallocation, or
                                             ##  \returns `RMW_RET_INVALID_ARGUMENT` if `network_flow_endpoint_array` or its allocator is NULL, or
                                             ##  \returns `RMW_RET_ERROR` when an unspecified error occurs.
                                             ##  \remark RMW error state is set on failure
                                             ## 