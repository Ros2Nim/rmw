##  #pragma c2nim mangle "'rosidl_runtime_c__' {\\w+}" "$1"
##  #pragma c2nim mangle "'namespace_'" "namespace"
##  #pragma c2nim mangle "'rmw_time_s'" "rmw_time_t"

##  Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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
  rcutils/allocator, rcutils/visibility_control_macros,
  rcutils/visibility_control_macros, rcutils/allocator, ./names_and_types,
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


proc rmw_get_subscriber_names_and_types_by_node*(node: ptr rmw_node_t;
    allocator: ptr rcutils_allocator_t; node_name: cstring;
    node_namespace: cstring; no_demangle: bool;
    topic_names_and_types: ptr rmw_names_and_types_t): rmw_ret_t {.
    importc: "rmw_get_subscriber_names_and_types_by_node",
    header: "get_node_info_and_types.h".}
  ##  Return all topic names and types for which a given remote node has subscriptions.
                                         ##
                                         ##  This function returns an array of topic names and types for which a given remote
                                         ##  node has subscriptions, as discovered so far by the given local node.
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
                                         ##    However, when querying subscribed topic names and types:
                                         ##    - Access to the array of names and types is not synchronized.
                                         ##      It is not safe to read or write `topic_names_and_types`
                                         ##      while rmw_get_subscriber_names_and_types_by_node() uses it.
                                         ##    - Access to node name and namespace is read-only but it is not synchronized.
                                         ##      Concurrent `node_name` and `node_namespace` reads are safe, but concurrent reads and
                                         ##      writes are not.
                                         ##    - The default allocators are thread-safe objects, but any custom `allocator` may not be.
                                         ##      Check your allocator documentation for further reference.
                                         ##
                                         ##  \pre Given `node` must be a valid node handle, as returned by rmw_create_node().
                                         ##  \pre Given `topic_names_and_types` must be a zero-initialized array of names and types,
                                         ##    as returned by rmw_get_zero_initialized_names_and_types().
                                         ##
                                         ##  \param[in] node Local node to query the ROS graph.
                                         ##  \param[in] allocator Allocator to be used when populating the `topic_names_and_types` array.
                                         ##  \param[in] node_name Name of the remote node to get information for.
                                         ##  \param[in] node_namespace Namespace of the remote node to get information for.
                                         ##  \param[in] no_demangle Whether to demangle all topic names following ROS conventions or not.
                                         ##  \param[out] topic_names_and_types Array of topic names and types the remote node has created
                                         ##    a subscription for, populated on success but left unchanged on failure.
                                         ##    If populated, it is up to the caller to finalize this array later on
                                         ##    using rmw_names_and_types_fini().
                                         ##  \return `RMW_RET_OK` if the query was successful, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `node` is NULL, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `allocator` is not valid,
                                         ##    by rcutils_allocator_is_valid() definition, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `node_name` is not valid,
                                         ##    by rmw_validate_node_name() definition, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `node_namespace` is not valid,
                                         ##    by rmw_validate_namespace() definition, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `topic_names_and_types` is NULL, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `topic_names_and_types` is not a
                                         ##    zero-initialized array, or
                                         ##  \return `RMW_RET_INCORRECT_RMW_IMPLEMENTATION` if the `node` implementation
                                         ##    identifier does not match this implementation, or
                                         ##  \return `RMW_RET_NODE_NAME_NON_EXISTENT` if the node name wasn't found, or
                                         ##  \return `RMW_RET_BAD_ALLOC` if memory allocation fails, or
                                         ##  \return `RMW_RET_ERROR` if an unspecified error occurs.
                                         ##

proc rmw_get_publisher_names_and_types_by_node*(node: ptr rmw_node_t;
    allocator: ptr rcutils_allocator_t; node_name: cstring;
    node_namespace: cstring; no_demangle: bool;
    topic_names_and_types: ptr rmw_names_and_types_t): rmw_ret_t {.
    importc: "rmw_get_publisher_names_and_types_by_node",
    header: "get_node_info_and_types.h".}
  ##  Return all topic names and types for which a given remote node has publishers.
                                         ##
                                         ##  This function returns an array of topic names and types for which a given remote
                                         ##  node has created publishers, as discovered so far by the given local node.
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
                                         ##    However, when querying published topic names and types:
                                         ##    - Access to the array of names and types is not synchronized.
                                         ##      It is not safe to read or write `topic_names_and_types`
                                         ##      while rmw_get_publisher_names_and_types_by_node() uses it.
                                         ##    - Access to node name and namespace is read-only but it is not synchronized.
                                         ##      Concurrent `node_name` and `node_namespace` reads are safe, but concurrent reads and
                                         ##      writes are not.
                                         ##    - The default allocators are thread-safe objects, but any custom `allocator` may not be.
                                         ##      Check your allocator documentation for further reference.
                                         ##
                                         ##  \pre Given `node` must be a valid node handle, as returned by rmw_create_node().
                                         ##  \pre Given `topic_names_and_types` must be a zero-initialized array of names and types,
                                         ##    as returned by rmw_get_zero_initialized_names_and_types().
                                         ##
                                         ##  \param[in] node Local node to query the ROS graph.
                                         ##  \param[in] allocator Allocator to be used when populating the `topic_names_and_types` array.
                                         ##  \param[in] node_name Name of the remote node to get information for.
                                         ##  \param[in] node_namespace Namespace of the remote node to get information for.
                                         ##  \param[in] no_demangle Whether to demangle all topic names following ROS conventions or not.
                                         ##  \param[out] topic_names_and_types Array of topic names and types the remote node has created
                                         ##    a publisher for, populated on success but left unchanged on failure.
                                         ##    If populated, it is up to the caller to finalize this array later on
                                         ##    using rmw_names_and_types_fini().
                                         ##  \return `RMW_RET_OK` if the query was successful, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `node` is NULL, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `allocator` is not valid,
                                         ##    by rcutils_allocator_is_valid() definition, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `node_name` is not valid,
                                         ##    by rmw_validate_node_name() definition, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `node_namespace` is not valid,
                                         ##    by rmw_validate_namespace() definition, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `topic_names_and_types` is NULL, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `topic_names_and_types` is not a
                                         ##    zero-initialized array, or
                                         ##  \return `RMW_RET_INCORRECT_RMW_IMPLEMENTATION` if the `node` implementation
                                         ##    identifier does not match this implementation, or
                                         ##  \return `RMW_RET_NODE_NAME_NON_EXISTENT` if the node name wasn't found, or
                                         ##  \return `RMW_RET_BAD_ALLOC` if memory allocation fails, or
                                         ##  \return `RMW_RET_ERROR` if an unspecified error occurs.
                                         ##

proc rmw_get_service_names_and_types_by_node*(node: ptr rmw_node_t;
    allocator: ptr rcutils_allocator_t; node_name: cstring;
    node_namespace: cstring; service_names_and_types: ptr rmw_names_and_types_t): rmw_ret_t {.
    importc: "rmw_get_service_names_and_types_by_node",
    header: "get_node_info_and_types.h".}
  ##  Return all service names and types for which a given remote node has servers.
                                         ##
                                         ##  This function returns an array of service names and types for which a given remote
                                         ##  node has servers, as discovered so far by the given local node.
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
                                         ##    However, when querying served service names and types:
                                         ##    - Access to the array of names and types is not synchronized.
                                         ##      It is not safe to read or write `service_names_and_types`
                                         ##      while rmw_get_service_names_and_types_by_node() uses it.
                                         ##    - Access to node name and namespace is read-only but it is not synchronized.
                                         ##      Concurrent `node_name` and `node_namespace` reads are safe, but concurrent reads and
                                         ##      writes are not.
                                         ##    - The default allocators are thread-safe objects, but any custom `allocator` may not be.
                                         ##      Check your allocator documentation for further reference.
                                         ##
                                         ##  \param[in] node Local node to query the ROS graph.
                                         ##  \param[in] allocator Allocator to be used when populating the `service_names_and_types` array.
                                         ##  \param[in] node_name Name of the remote node to get information for.
                                         ##  \param[in] node_namespace Namespace of the remote node to get information for.
                                         ##  \param[out] service_names_and_types Array of service names and types the remote node has
                                         ##    created a service server for, populated on success but left unchanged on failure.
                                         ##    If populated, it is up to the caller to finalize this array later on
                                         ##    using rmw_names_and_types_fini().
                                         ##  \return `RMW_RET_OK` if the query was successful, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `node` is NULL, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `allocator` is not valid,
                                         ##    by rcutils_allocator_is_valid() definition, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `node_name` is not valid,
                                         ##    by rmw_validate_node_name() definition, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `node_namespace` is not valid,
                                         ##    by rmw_validate_namespace() definition, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `service_names_and_types` is NULL, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `service_names_and_types` is not a
                                         ##    zero-initialized array, or
                                         ##  \return `RMW_RET_INCORRECT_RMW_IMPLEMENTATION` if the `node` implementation
                                         ##    identifier does not match this implementation, or
                                         ##  \return `RMW_RET_NODE_NAME_NON_EXISTENT` if the node name wasn't found, or
                                         ##  \return `RMW_RET_BAD_ALLOC` if memory allocation fails, or
                                         ##  \return `RMW_RET_ERROR` if an unspecified error occurs.
                                         ##

proc rmw_get_client_names_and_types_by_node*(node: ptr rmw_node_t;
    allocator: ptr rcutils_allocator_t; node_name: cstring;
    node_namespace: cstring; service_names_and_types: ptr rmw_names_and_types_t): rmw_ret_t {.
    importc: "rmw_get_client_names_and_types_by_node",
    header: "get_node_info_and_types.h".}
  ##  Return all service names and types for which a given remote node has clients.
                                         ##
                                         ##  This function returns an array of service names and types for which a given remote
                                         ##  node has clients, as discovered so far by the given local node.
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
                                         ##    However, when querying served service names and types:
                                         ##    - Access to the array of names and types is not synchronized.
                                         ##      It is not safe to read or write `service_names_and_types`
                                         ##      while rmw_get_client_names_and_types_by_node() uses it.
                                         ##    - Access to C-style string arguments is read-only but it is not synchronized.
                                         ##      Concurrent `node_name` and `node_namespace` reads are safe, but concurrent reads and
                                         ##      writes are not.
                                         ##    - The default allocators are thread-safe objects, but any custom `allocator` may not be.
                                         ##      Check your allocator documentation for further reference.
                                         ##
                                         ##  \param[in] node Local node to query the ROS graph.
                                         ##  \param[in] allocator Allocator to be used when populating the `service_names_and_types` array.
                                         ##  \param[in] node_name Name of the remote node to get information for.
                                         ##  \param[in] node_namespace Namespace of the remote node to get information for.
                                         ##  \param[out] service_names_and_types Array of service names and types the remote node has
                                         ##    created a service client for, populated on success but left unchanged on failure.
                                         ##    If populated, it is up to the caller to finalize this array later on
                                         ##    using rmw_names_and_types_fini().
                                         ##  \return `RMW_RET_OK` if the query was successful, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `node` is NULL, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `allocator` is not valid,
                                         ##    by rcutils_allocator_is_valid() definition, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `node_name` is not valid,
                                         ##    by rmw_validate_node_name() definition, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `node_namespace` is not valid,
                                         ##    by rmw_validate_namespace() definition, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `service_names_and_types` is NULL, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `service_names_and_types` is not a
                                         ##    zero-initialized array, or
                                         ##  \return `RMW_RET_INCORRECT_RMW_IMPLEMENTATION` if the `node` implementation
                                         ##    identifier does not match this implementation, or
                                         ##  \return `RMW_RET_NODE_NAME_NON_EXISTENT` if the node name wasn't found, or
                                         ##  \return `RMW_RET_BAD_ALLOC` if memory allocation fails, or
                                         ##  \return `RMW_RET_ERROR` if an unspecified error occurs.
                                         ## 