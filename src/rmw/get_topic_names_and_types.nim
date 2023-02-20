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
  rcutils/macros, rcutils/macros, rcutils/macros, rcutils/macros,
  rcutils/macros, ./names_and_types, ./names_and_types, rcutils/allocator,
  rcutils/allocator, rcutils/allocator, rcutils/types/rcutils_ret,
  rcutils/allocator, rcutils/visibility_control,
  rcutils/visibility_control_macros, rcutils/visibility_control_macros,
  rcutils/visibility_control, rcutils/allocator, ./names_and_types,
  rcutils/types/array_list, rcutils/types/array_list, rcutils/types/char_array,
  rcutils/types/char_array, rcutils/types/hash_map, rcutils/types/hash_map,
  rcutils/types/string_array, rcutils/types/string_array,
  rcutils/error_handling, rcutils/error_handling, rcutils/error_handling,
  rcutils/error_handling, rcutils/error_handling, rcutils/error_handling,
  rcutils/error_handling, rcutils/snprintf, rcutils/snprintf,
  rcutils/error_handling, rcutils/testing/fault_injection,
  rcutils/testing/fault_injection, rcutils/testing/fault_injection,
  rcutils/error_handling, rcutils/error_handling, rcutils/error_handling,
  rcutils/error_handling, rcutils/types/string_array, rcutils/qsort,
  rcutils/qsort, rcutils/types/string_array, rcutils/types/string_map,
  rcutils/types/string_map, rcutils/types/uint8_array,
  rcutils/types/uint8_array, ./names_and_types, ./types, ./types,
  rcutils/logging, rcutils/logging, ./types, ./events_statuses/events_statuses,
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
  ./types, ./time, ./time, ./types, ./names_and_types


proc rmw_get_topic_names_and_types*(node: ptr rmw_node_t;
                                    allocator: ptr rcutils_allocator_t;
                                    no_demangle: bool; topic_names_and_types: ptr rmw_names_and_types_t): rmw_ret_t {.
    importc: "rmw_get_topic_names_and_types",
    header: "get_topic_names_and_types.h".}
  ##  Return all topic names and types in the ROS graph.
                                           ##
                                           ##  This function returns an array of all topic names and types in the ROS graph
                                           ##  i.e. for which a publisher and/or a subscription exists, as discovered so far
                                           ##  by the given local node.
                                           ##
                                           ##  Unless `no_demangle` is true, some demangling and filtering may take place when
                                           ##  listing topics as implemented by the middleware.
                                           ##  Whether demangling applies or not, and how it applies, depends on the underlying
                                           ##  implementation.
                                           ##  See http://design.ros2.org/articles/topic_and_service_names.html for an example
                                           ##  on how it is used in DDS and RTPS based implementations.
                                           ##
                                           ##  <hr>
                                           ##  Attribute          | Adherence
                                           ##  ------------------ | -------------
                                           ##  Allocates Memory   | Yes
                                           ##  Thread-Safe        | Yes
                                           ##  Uses Atomics       | Maybe [1]
                                           ##  Lock-Free          | Maybe [1]
                                           ##  <i>[1] rmw implementation defined, check the implementation documentation</i>
                                           ##
                                           ##  \par Runtime behavior
                                           ##    To query the ROS graph is a synchronous operation.
                                           ##    It is also non-blocking, but it is not guaranteed to be lock-free.
                                           ##    Generally speaking, implementations may synchronize access to internal resources using
                                           ##    locks but are not allowed to wait for events with no guaranteed time bound (barring
                                           ##    the effects of starvation due to OS scheduling).
                                           ##
                                           ##  \par Thread-safety
                                           ##    Nodes are thread-safe objects, and so are all operations on them except for finalization.
                                           ##    Therefore, it is safe to query the ROS graph using the same node concurrently.
                                           ##    However, when querying topic names and types:
                                           ##    - Access to the array of names and types is not synchronized.
                                           ##      It is not safe to read or write `topic_names_and_types`
                                           ##      while rmw_get_topic_names_and_types() uses it.
                                           ##    - The default allocators are thread-safe objects, but any custom `allocator` may not be.
                                           ##      Check your allocator documentation for further reference.
                                           ##
                                           ##  \pre Given `node` must be a valid node handle, as returned by rmw_create_node().
                                           ##  \pre Given `topic_names_and_types` must be a zero-initialized array of names and types,
                                           ##    as returned by rmw_get_zero_initialized_names_and_types().
                                           ##
                                           ##  \param[in] node Node to query the ROS graph.
                                           ##  \param[in] allocator Allocator to be used when populating the `topic_names_and_types` array.
                                           ##  \param[in] no_demangle Whether to demangle all topic names following ROS conventions or not.
                                           ##  \param[out] topic_names_and_types Array of topic names and their types,
                                           ##    populated on success but left unchanged on failure.
                                           ##    If populated, it is up to the caller to finalize this array later on
                                           ##    using rmw_names_and_types_fini().
                                           ##  \return `RMW_RET_OK` if the query was successful, or
                                           ##  \return `RMW_RET_INVALID_ARGUMENT` if `node` is NULL, or
                                           ##  \return `RMW_RET_INVALID_ARGUMENT` if `allocator` is not valid, by rcutils_allocator_is_valid()
                                           ##    definition, or
                                           ##  \return `RMW_RET_INVALID_ARGUMENT` if `topic_names_and_types` is NULL, or
                                           ##  \return `RMW_RET_INVALID_ARGUMENT` if `topic_names_and_types` is not a
                                           ##    zero-initialized array, or
                                           ##  \return `RMW_RET_INCORRECT_RMW_IMPLEMENTATION` if the `node` implementation
                                           ##    identifier does not match this implementation, or
                                           ##  \return `RMW_RET_BAD_ALLOC` if memory allocation fails, or
                                           ##  \return `RMW_RET_ERROR` if an unspecified error occurs.
                                           ## 