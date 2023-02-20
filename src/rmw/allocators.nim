##  Copyright 2014 Open Source Robotics Foundation, Inc.
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
  ./types, ./types, ./types, ./types, rcutils/logging, rcutils/logging,
  rcutils/logging, rcutils/allocator, rcutils/allocator, rcutils/macros,
  rcutils/macros, rcutils/macros, rcutils/macros, rcutils/macros,
  rcutils/allocator, rcutils/types/rcutils_ret, rcutils/allocator,
  rcutils/visibility_control, rcutils/visibility_control_macros,
  rcutils/visibility_control_macros, rcutils/visibility_control,
  rcutils/allocator, rcutils/logging, rcutils/error_handling,
  rcutils/error_handling, rcutils/error_handling, rcutils/error_handling,
  rcutils/error_handling, rcutils/error_handling, rcutils/snprintf,
  rcutils/snprintf, rcutils/error_handling, rcutils/testing/fault_injection,
  rcutils/testing/fault_injection, rcutils/testing/fault_injection,
  rcutils/error_handling, rcutils/error_handling, rcutils/error_handling,
  rcutils/error_handling, rcutils/logging, rcutils/types/array_list,
  rcutils/types/array_list, rcutils/types/char_array, rcutils/types/char_array,
  rcutils/types/hash_map, rcutils/types/hash_map, rcutils/types/string_array,
  rcutils/types/string_array, rcutils/qsort, rcutils/qsort,
  rcutils/types/string_array, rcutils/types/string_map,
  rcutils/types/string_map, rcutils/types/uint8_array,
  rcutils/types/uint8_array, rcutils/logging, ./types,
  ./events_statuses/events_statuses, ./events_statuses/incompatible_qos,
  ./qos_policy_kind, ./qos_policy_kind, ./events_statuses/incompatible_qos,
  ./events_statuses/events_statuses, ./events_statuses/liveliness_changed,
  ./events_statuses/liveliness_changed, ./events_statuses/events_statuses,
  ./events_statuses/liveliness_lost, ./events_statuses/liveliness_lost,
  ./events_statuses/events_statuses, ./events_statuses/message_lost,
  ./events_statuses/message_lost, ./events_statuses/events_statuses,
  ./events_statuses/offered_deadline_missed,
  ./events_statuses/offered_deadline_missed, ./events_statuses/events_statuses,
  ./events_statuses/requested_deadline_missed,
  ./events_statuses/requested_deadline_missed,
  ./events_statuses/events_statuses, ./types, ./init, ./init_options,
  ./init_options, ./domain_id, ./init_options, ./localhost, ./init_options,
  ./init_options, ./ret_types, ./init_options, ./security_options,
  ./security_options, ./init_options, ./init, ./types, ./serialized_message,
  ./types, ./subscription_content_filter_options,
  ./subscription_content_filter_options, ./types, ./time, ./time, ./types


proc rmw_allocate*(size: csize_t): pointer {.importc: "rmw_allocate",
    header: "allocators.h".}
  ##  Allocate memory of size in bytes using rcutils default allocator's allocate()
                            ##
                            ##  \param[in] size The number of bytes to allocate
                            ##  \return pointer to allocated memory
                            ##

proc rmw_free*(pointer: pointer) {.importc: "rmw_free", header: "allocators.h".}
  ##
                              ##  Free memory using rcutils default allocator's deallocate()
                              ##
                              ##  \param[in] pointer pointer to allocated memory
                              ##

proc rmw_node_allocate*(): ptr rmw_node_t {.importc: "rmw_node_allocate",
    header: "allocators.h".}
  ##  Allocate memory for an `rmw_node_t` using rcutils default allocator's allocate()
                            ##
                            ##  \return pointer to allocated memory
                            ##

proc rmw_node_free*(node: ptr rmw_node_t) {.importc: "rmw_node_free",
    header: "allocators.h".}
  ##  Free memory allocated to this node pointer using rcutils default allocator's deallocate()
                            ##
                            ##  \param[in] node pointer to allocated memory
                            ##

proc rmw_publisher_allocate*(): ptr rmw_publisher_t {.
    importc: "rmw_publisher_allocate", header: "allocators.h".}
  ##
                              ##  Allocate memory for an `rmw_publisher_t` using rcutils default allocator's allocate()
                              ##
                              ##  \return pointer to allocated memory
                              ##

proc rmw_publisher_free*(publisher: ptr rmw_publisher_t) {.
    importc: "rmw_publisher_free", header: "allocators.h".}
  ##
                              ##  Free memory using rcutils default allocator's deallocate()
                              ##
                              ##  \param[in] publisher pointer to allocated memory
                              ##

proc rmw_subscription_allocate*(): ptr rmw_subscription_t {.
    importc: "rmw_subscription_allocate", header: "allocators.h".}
  ##
                              ##  Allocate memory for an `rmw_subscription_t` using rcutils default allocator's allocate()
                              ##
                              ##  \return pointer to allocated memory
                              ##

proc rmw_subscription_free*(subscription: ptr rmw_subscription_t) {.
    importc: "rmw_subscription_free", header: "allocators.h".}
  ##
                              ##  Free memory using rcutils default allocator's deallocate()
                              ##
                              ##  \param[in] subscription pointer to allocated memory
                              ##

proc rmw_guard_condition_allocate*(): ptr rmw_guard_condition_t {.
    importc: "rmw_guard_condition_allocate", header: "allocators.h".}
  ##
                              ##  Allocate memory for an `rmw_guard_condition_t` using rcutils default allocator's allocate()
                              ##
                              ##  \return pointer to allocated memory
                              ##

proc rmw_guard_condition_free*(guard_condition: ptr rmw_guard_condition_t) {.
    importc: "rmw_guard_condition_free", header: "allocators.h".}
  ##
                              ##  Free memory using rcutils default allocator's deallocate()
                              ##
                              ##  \param[in] guard_condition pointer to allocated memory
                              ##

proc rmw_client_allocate*(): ptr rmw_client_t {.importc: "rmw_client_allocate",
    header: "allocators.h".}
  ##  Allocate memory for an `rmw_client_t` using rcutils default allocator's allocate()
                            ##
                            ##  \return pointer to allocated memory
                            ##

proc rmw_client_free*(client: ptr rmw_client_t) {.importc: "rmw_client_free",
    header: "allocators.h".}
  ##  Free memory using rcutils default allocator's deallocate()
                            ##
                            ##  \param[in] client pointer to allocated memory
                            ##

proc rmw_service_allocate*(): ptr rmw_service_t {.
    importc: "rmw_service_allocate", header: "allocators.h".}
  ##
                              ##  Allocate memory for an `rmw_service_t` using rcutils default allocator's allocate()
                              ##
                              ##  \return pointer to allocated memory
                              ##

proc rmw_service_free*(service: ptr rmw_service_t) {.
    importc: "rmw_service_free", header: "allocators.h".}
  ##
                              ##  Free memory using rcutils default allocator's deallocate()
                              ##
                              ##  \param[in] service pointer to allocated memory
                              ##

proc rmw_wait_set_allocate*(): ptr rmw_wait_set_t {.
    importc: "rmw_wait_set_allocate", header: "allocators.h".}
  ##
                              ##  Allocate memory for an `rmw_wait_set_t` using rcutils default allocator's allocate()
                              ##
                              ##  \return pointer to allocated memory
                              ##

proc rmw_wait_set_free*(wait_set: ptr rmw_wait_set_t) {.
    importc: "rmw_wait_set_free", header: "allocators.h".}
  ##
                              ##  Free memory using rcutils default allocator's deallocate()
                              ##
                              ##  \param[in] wait_set pointer to allocated memory
                              ## 