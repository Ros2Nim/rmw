##  Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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
  ./topic_endpoint_info_array, rcutils/allocator, rcutils/allocator,
  rcutils/allocator, rcutils/macros, rcutils/macros, rcutils/macros,
  rcutils/macros, rcutils/macros, rcutils/allocator, rcutils/types/rcutils_ret,
  rcutils/allocator, rcutils/visibility_control,
  rcutils/visibility_control_macros, rcutils/visibility_control_macros,
  rcutils/visibility_control, rcutils/allocator, ./topic_endpoint_info_array,
  ./topic_endpoint_info, ./types, ./types, ./types, rcutils/logging,
  rcutils/logging, rcutils/logging, rcutils/error_handling,
  rcutils/error_handling, rcutils/error_handling, rcutils/error_handling,
  rcutils/error_handling, rcutils/error_handling, rcutils/snprintf,
  rcutils/snprintf, rcutils/error_handling, rcutils/testing/fault_injection,
  rcutils/testing/fault_injection, rcutils/testing/fault_injection,
  rcutils/error_handling, rcutils/error_handling, rcutils/error_handling,
  rcutils/error_handling, rcutils/logging, rcutils/time, rcutils/time,
  rcutils/types, rcutils/types/array_list, rcutils/types/array_list,
  rcutils/types, rcutils/types/char_array, rcutils/types/char_array,
  rcutils/types, rcutils/types/hash_map, rcutils/types/hash_map, rcutils/types,
  rcutils/types/string_array, rcutils/types/string_array, rcutils/qsort,
  rcutils/qsort, rcutils/types/string_array, rcutils/types,
  rcutils/types/string_map, rcutils/types/string_map, rcutils/types,
  rcutils/types/uint8_array, rcutils/types/uint8_array, rcutils/types,
  rcutils/time, rcutils/logging, ./types, ./events_statuses/events_statuses,
  ./events_statuses/incompatible_qos, ./qos_policy_kind, ./visibility_control,
  ./visibility_control, ./qos_policy_kind, ./events_statuses/incompatible_qos,
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
  ./macros, ./init_options, ./ret_types, ./init_options, ./security_options,
  ./security_options, ./init_options, ./init, ./types, ./serialized_message,
  ./types, ./subscription_content_filter_options,
  ./subscription_content_filter_options, ./types, ./time, ./time, ./types,
  ./topic_endpoint_info, ./topic_endpoint_info_array


proc rmw_get_publishers_info_by_topic*(node: ptr rmw_node_t;
                                       allocator: ptr rcutils_allocator_t;
                                       topic_name: cstring; no_mangle: _Bool;
    publishers_info: ptr rmw_topic_endpoint_info_array_t): rmw_ret_t {.
    importc: "rmw_get_publishers_info_by_topic",
    header: "get_topic_endpoint_info.h".}
  ##  Retrieve endpoint information for each known publisher of a given topic.
                                         ##
                                         ##  This function returns an array of endpoint information for each publisher
                                         ##  of a given topic, as discovered so far by the given node.
                                         ##  Endpoint information includes the publisher's node name and namespace,
                                         ##  the associated topic type, the publisher's gid, and the publisher QoS profile.
                                         ##  Names of non-existent topics are allowed, in which case an empty array will be returned.
                                         ##
                                         ##  \par QoS that are correctly read
                                         ##  The QoS profiles returned might have some invalid fields.
                                         ##  The rmw implementation must set the invalid fields to `RMW_QOS_POLICY_*_UNKNOWN`.
                                         ##  For DDS based implementations, the only QoS policies that are guaranteed to be shared
                                         ##  during discovery are the ones that participate in endpoint matching.
                                         ##  From the current QoS settings available, the only ones not shared by DDS based
                                         ##  implementations are `history` and `history_depth`.
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
                                         ##    - Access to the array of topic endpoint information is not synchronized.
                                         ##      It is not safe to read or write `publishers_info`
                                         ##      while rmw_get_publishers_info_by_topic() uses it.
                                         ##    - Access to C-style string arguments is read-only but it is not synchronized.
                                         ##      Concurrent `topic_name` reads are safe, but concurrent reads and writes are not.
                                         ##    - The default allocators are thread-safe objects, but any custom `allocator` may not be.
                                         ##      Check your allocator documentation for further reference.
                                         ##
                                         ##  \pre Given `node` must be a valid node handle, as returned by rmw_create_node().
                                         ##  \pre Given `publishers_info` must be a zero-initialized array of endpoints' information,
                                         ##    as returned by rmw_get_zero_initialized_topic_endpoint_info_array().
                                         ##
                                         ##  \param[in] node Node to query the ROS graph.
                                         ##  \param[in] allocator Allocator to be used when populating the `publishers_info` array.
                                         ##  \param[in] topic_name Name of the topic for publisher lookup, often a fully qualified
                                         ##    topic name but not necessarily (see rmw_create_publisher()).
                                         ##  \param[in] no_mangle Whether to mangle the topic name before publisher lookup or not.
                                         ##  \param[out] publishers_info Array of publisher information, populated on success,
                                         ##    left unchanged on failure.
                                         ##    If populated, it is up to the caller to finalize this array later on,
                                         ##    using rmw_topic_endpoint_info_array_fini().
                                         ##    QoS Profiles in the info array will use RMW_DURATION_INFINITE for infinite durations,
                                         ##    avoiding exposing any implementation-specific values.
                                         ##  \return `RMW_RET_OK` if the query was successful, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `node` is NULL, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `allocator` is not valid,
                                         ##    by rcutils_allocator_is_valid() definition, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `topic_name` is NULL, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `publishers_info` is NULL, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `publishers_info` is not a
                                         ##    zero-initialized array, or
                                         ##  \return `RMW_RET_INCORRECT_RMW_IMPLEMENTATION` if the `node` implementation
                                         ##    identifier does not match this implementation, or
                                         ##  \return `RMW_RET_BAD_ALLOC` if memory allocation fails, or
                                         ##  \return `RMW_RET_ERROR` if an unspecified error occurs.
                                         ##

proc rmw_get_subscriptions_info_by_topic*(node: ptr rmw_node_t;
    allocator: ptr rcutils_allocator_t; topic_name: cstring; no_mangle: _Bool;
    subscriptions_info: ptr rmw_topic_endpoint_info_array_t): rmw_ret_t {.
    importc: "rmw_get_subscriptions_info_by_topic",
    header: "get_topic_endpoint_info.h".}
  ##  Retrieve endpoint information for each known subscription of a given topic.
                                         ##
                                         ##  This function returns an array of endpoint information for each subscription
                                         ##  of a given topic, as discovered so far by the given node.
                                         ##  Endpoint information includes the subscription's node name and namespace,
                                         ##  the associated topic type, the subscription's gid, and the subscription QoS profile.
                                         ##  Names of non-existent topics are allowed, in which case an empty array will be returned.
                                         ##
                                         ##  \par QoS that are correctly read
                                         ##  Not all QoS may be read correctly, \sa rmw_get_publishers_info_by_topic() for more details.
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
                                         ##    However, when querying subscriptions' information:
                                         ##    - Access to the array of topic endpoint information is not synchronized.
                                         ##      It is not safe to read or write `subscriptions_info`
                                         ##      while rmw_get_subscriptions_info_by_topic() uses it.
                                         ##    - The default allocators are thread-safe objects, but any custom `allocator` may not be.
                                         ##      Check your allocator documentation for further reference.
                                         ##
                                         ##  \pre Given `node` must be a valid node handle, as returned by rmw_create_node().
                                         ##  \pre Given `subscriptions_info` must be a zero-initialized array of endpoints' information,
                                         ##    as returned by rmw_get_zero_initialized_topic_endpoint_info_array().
                                         ##
                                         ##  \param[in] node Node to query the ROS graph.
                                         ##  \param[in] allocator Allocator to be used when populating the `subscriptions_info` array.
                                         ##  \param[in] topic_name Name of the topic for subscription lookup, often a fully qualified
                                         ##    topic name but not necessarily (see rmw_create_subscription()).
                                         ##  \param[in] no_mangle Whether to mangle the topic name before subscription lookup or not.
                                         ##  \param[out] subscriptions_info Array of subscription information, populated on success,
                                         ##    left unchanged on failure.
                                         ##    If populated, it is up to the caller to finalize this array later on,
                                         ##    using rmw_topic_endpoint_info_array_fini().
                                         ##    QoS Profiles in the info array will use RMW_DURATION_INFINITE for infinite durations,
                                         ##    avoiding exposing any implementation-specific values.
                                         ##  \return `RMW_RET_OK` if the query was successful, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `node` is NULL, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `allocator` is not valid,
                                         ##    by rcutils_allocator_is_valid() definition, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `topic_name` is NULL, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `subscriptions_info` is NULL, or
                                         ##  \return `RMW_RET_INVALID_ARGUMENT` if `subscriptions_info` is not a
                                         ##    zero-initialized array, or
                                         ##  \return `RMW_RET_INCORRECT_RMW_IMPLEMENTATION` if the `node` implementation
                                         ##    identifier does not match this implementation, or
                                         ##  \return `RMW_RET_BAD_ALLOC` if memory allocation fails, or
                                         ##  \return `RMW_RET_ERROR` if an unspecified error occurs.
                                         ## 