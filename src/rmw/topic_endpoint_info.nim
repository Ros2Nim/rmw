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
  rcutils/allocator, rcutils/allocator, rcutils/allocator, rcutils/macros,
  rcutils/macros, rcutils/macros, rcutils/macros, rcutils/macros,
  rcutils/allocator, rcutils/types/rcutils_ret, rcutils/allocator,
  rcutils/visibility_control, rcutils/visibility_control_macros,
  rcutils/visibility_control_macros, rcutils/visibility_control,
  rcutils/allocator, ./types, ./types, ./types, rcutils/logging,
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
  ./subscription_content_filter_options, ./types, ./time, ./time, ./types

type

  rmw_topic_endpoint_info_t* {.importc: "rmw_topic_endpoint_info_t",
                               header: "topic_endpoint_info.h", bycopy.} = object ##
                              ##  A data structure that encapsulates the node name, node namespace,
                              ##  topic_type, gid, and qos_profile of publishers and subscriptions
                              ##  for a topic.
    node_name* {.importc: "node_name".}: cstring ##  Name of the node
    node_namespace* {.importc: "node_namespace".}: cstring ##
                              ##  Namespace of the node
    topic_type* {.importc: "topic_type".}: cstring ##
                              ##  The associated topic type
    endpoint_type* {.importc: "endpoint_type".}: rmw_endpoint_type_t ##
                              ##  The endpoint type
    endpoint_gid* {.importc: "endpoint_gid".}: array[16'u, uint8] ##
                              ##  The GID of the endpoint
    qos_profile* {.importc: "qos_profile".}: rmw_qos_profile_t ##
                              ##  QoS profile of the endpoint



proc rmw_get_zero_initialized_topic_endpoint_info*(): rmw_topic_endpoint_info_t {.
    importc: "rmw_get_zero_initialized_topic_endpoint_info",
    header: "topic_endpoint_info.h".}
  ##  Return zero initialized topic endpoint info data structure.
                                     ##
                                     ##  Endpoint type will be invalid.
                                     ##  Endpoint QoS profile will be the system default.
                                     ##

proc rmw_topic_endpoint_info_fini*(topic_endpoint_info: ptr rmw_topic_endpoint_info_t;
                                   allocator: ptr rcutils_allocator_t): rmw_ret_t {.
    importc: "rmw_topic_endpoint_info_fini", header: "topic_endpoint_info.h".}
  ##
                              ##  Finalize a topic endpoint info data structure.
                              ##
                              ##  This function deallocates all allocated members of the given data structure,
                              ##  and then zero initializes it.
                              ##  If a logical error, such as `RMW_RET_INVALID_ARGUMENT`, ensues, this function
                              ##  will return early, leaving the given data structure unchanged.
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
                              ##    Finalization is a reentrant procedure, but:
                              ##    - Access to the topic endpoint info data structure is not synchronized.
                              ##      It is not safe to read or write `topic_endpoint` during finalization.
                              ##    - The default allocators are thread-safe objects, but any custom `allocator` may not be.
                              ##      Check your allocator documentation for further reference.
                              ##
                              ##  \param[inout] topic_endpoint_info Data structure to be finalized.
                              ##  \param[in] allocator Allocator used to populate the given `topic_endpoint_info`.
                              ##  \returns `RMW_RET_OK` if successful, or
                              ##  \returns `RMW_RET_INVALID_ARGUMENT` if `topic_endpoint_info` is NULL, or
                              ##  \returns `RMW_RET_INVALID_ARGUMENT` if `allocator` is invalid,
                              ##    by rcutils_allocator_is_valid() definition, or
                              ##  \returns `RMW_RET_ERROR` when an unspecified error occurs.
                              ##  \remark This function sets the RMW error state on failure.
                              ##

proc rmw_topic_endpoint_info_set_topic_type*(
    topic_endpoint_info: ptr rmw_topic_endpoint_info_t; topic_type: cstring;
    allocator: ptr rcutils_allocator_t): rmw_ret_t {.
    importc: "rmw_topic_endpoint_info_set_topic_type",
    header: "topic_endpoint_info.h".}
  ##  Set the topic type in the given topic endpoint info data structure.
                                     ##
                                     ##  This functions allocates memory and copies the value of the `topic_type`
                                     ##  argument to set the data structure `topic_type` member.
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
                                     ##    Setting a member is a reentrant procedure, but:
                                     ##    - Access to the topic endpoint info data structure is not synchronized.
                                     ##      It is not safe to read or write the `topic_type` member of the given `topic_endpoint`
                                     ##      while setting it.
                                     ##    - Access to C-style string arguments is read-only but it is not synchronized.
                                     ##      Concurrent `topic_type` reads are safe, but concurrent reads and writes are not.
                                     ##    - The default allocators are thread-safe objects, but any custom `allocator` may not be.
                                     ##      Check your allocator documentation for further reference.
                                     ##
                                     ##  \pre Given `topic_type` is a valid C-style string i.e. NULL terminated.
                                     ##
                                     ##  \param[inout] topic_endpoint_info Data structure to be populated.
                                     ##  \param[in] topic_type Type name to be set.
                                     ##  \param[in] allocator Allocator to be used.
                                     ##  \returns `RMW_RET_OK` if successful, or
                                     ##  \returns `RMW_RET_INVALID_ARGUMENT` if `topic_endpoint_info` is NULL, or
                                     ##  \returns `RMW_RET_INVALID_ARGUMENT` if `topic_type` is NULL, or
                                     ##  \returns `RMW_RET_BAD_ALLOC` if memory allocation fails, or
                                     ##  \returns `RMW_RET_ERROR` when an unspecified error occurs.
                                     ##  \remark This function sets the RMW error state on failure.
                                     ##

proc rmw_topic_endpoint_info_set_node_name*(
    topic_endpoint_info: ptr rmw_topic_endpoint_info_t; node_name: cstring;
    allocator: ptr rcutils_allocator_t): rmw_ret_t {.
    importc: "rmw_topic_endpoint_info_set_node_name",
    header: "topic_endpoint_info.h".}
  ##  Set the node name in the given topic endpoint info data structure.
                                     ##
                                     ##  This functions allocates memory and copies the value of the `node_name`
                                     ##  argument to set the data structure `node_name` member.
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
                                     ##    Setting a member is a reentrant procedure, but:
                                     ##    - Access to the topic endpoint info data structure is not synchronized.
                                     ##      It is not safe to read or write the `node_name` member of the given `topic_endpoint`
                                     ##      while setting it.
                                     ##    - Access to C-style string arguments is read-only but it is not synchronized.
                                     ##      Concurrent `node_name` reads are safe, but concurrent reads and writes are not.
                                     ##    - The default allocators are thread-safe objects, but any custom `allocator` may not be.
                                     ##      Check your allocator documentation for further reference.
                                     ##
                                     ##  \pre Given `node_name` is a valid C-style string i.e. NULL terminated.
                                     ##
                                     ##  \param[inout] topic_endpoint_info Data structure to be populated.
                                     ##  \param[in] node_name Node name to be set.
                                     ##  \param[in] allocator Allocator to be used.
                                     ##  \returns `RMW_RET_OK` if successful, or
                                     ##  \returns `RMW_RET_INVALID_ARGUMENT` if `topic_endpoint_info` is NULL, or
                                     ##  \returns `RMW_RET_INVALID_ARGUMENT` if `node_name` is NULL, or
                                     ##  \returns `RMW_RET_BAD_ALLOC` if memory allocation fails, or
                                     ##  \returns `RMW_RET_ERROR` when an unspecified error occurs.
                                     ##  \remark This function sets the RMW error state on failure.
                                     ##

proc rmw_topic_endpoint_info_set_node_namespace*(
    topic_endpoint_info: ptr rmw_topic_endpoint_info_t; node_namespace: cstring;
    allocator: ptr rcutils_allocator_t): rmw_ret_t {.
    importc: "rmw_topic_endpoint_info_set_node_namespace",
    header: "topic_endpoint_info.h".}
  ##  Set the node namespace in the given topic endpoint info data structure.
                                     ##
                                     ##  This functions allocates memory and copies the value of the `node_namespace`
                                     ##  argument to set the data structure `node_namespace` member.
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
                                     ##    Setting a member is a reentrant procedure, but:
                                     ##    - Access to the topic endpoint info data structure is not synchronized.
                                     ##      It is not safe to read or write the `node_namespace` member of the given `topic_endpoint`
                                     ##      while setting it.
                                     ##    - Access to C-style string arguments is read-only but it is not synchronized.
                                     ##      Concurrent `node_namespace` reads are safe, but concurrent reads and writes are not.
                                     ##    - The default allocators are thread-safe objects, but any custom `allocator` may not be.
                                     ##      Check your allocator documentation for further reference.
                                     ##
                                     ##  \pre Given `node_namespace` is a valid C-style string i.e. NULL terminated.
                                     ##
                                     ##  \param[inout] topic_endpoint_info Data structure to be populated.
                                     ##  \param[in] node_namespace Node namespace to be set.
                                     ##  \param[in] allocator Allocator to be used.
                                     ##  \returns `RMW_RET_OK` if successful, or
                                     ##  \returns `RMW_RET_INVALID_ARGUMENT` if `topic_endpoint_info` is NULL, or
                                     ##  \returns `RMW_RET_INVALID_ARGUMENT` if `node_namespace` is NULL, or
                                     ##  \returns `RMW_RET_BAD_ALLOC` if memory allocation fails, or
                                     ##  \returns `RMW_RET_ERROR` when an unspecified error occurs.
                                     ##  \remark This function sets the RMW error state on failure.
                                     ##

proc rmw_topic_endpoint_info_set_endpoint_type*(
    topic_endpoint_info: ptr rmw_topic_endpoint_info_t;
    `type`: rmw_endpoint_type_t): rmw_ret_t {.
    importc: "rmw_topic_endpoint_info_set_endpoint_type",
    header: "topic_endpoint_info.h".}
  ##  Set the endpoint type in the given topic endpoint info data structure.
                                     ##
                                     ##  This functions assigns the value of the `type` argument to the data structure
                                     ##  `endpoint_type` member.
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
                                     ##    Setting a member is a reentrant procedure, but access to the
                                     ##    topic endpoint info data structure is not synchronized.
                                     ##    It is not safe to read or write the `endpoint_type` member of the
                                     ##    given `topic_endpoint` while setting it.
                                     ##
                                     ##  \param[inout] topic_endpoint_info Data structure to be populated.
                                     ##  \param[in] type Endpoint type to be set.
                                     ##  \returns `RMW_RET_OK` if successful, or
                                     ##  \returns `RMW_RET_INVALID_ARGUMENT` if `topic_endpoint_info` is NULL, or
                                     ##  \returns `RMW_RET_ERROR` when an unspecified error occurs.
                                     ##  \remark This function sets the RMW error state on failure.
                                     ##

proc rmw_topic_endpoint_info_set_gid*(topic_endpoint_info: ptr rmw_topic_endpoint_info_t;
                                      gid: ptr uint8; size: csize_t): rmw_ret_t {.
    importc: "rmw_topic_endpoint_info_set_gid", header: "topic_endpoint_info.h".}
  ##
                              ##  Set the endpoint gid in the given topic endpoint info data structure.
                              ##
                              ##  This functions copies the value of the `gid` argument to the data structure
                              ##  `endpoint_gid` member.
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
                              ##    Setting a member is a reentrant procedure, but access to the
                              ##    topic endpoint info data structure is not synchronized.
                              ##    It is not safe to read or write the `gid` member of the
                              ##    given `topic_endpoint` while setting it.
                              ##
                              ##  \param[inout] topic_endpoint_info Data structure to be populated.
                              ##  \param[in] gid Endpoint gid to be set.
                              ##  \param[in] size Size of the given `gid`.
                              ##  \returns `RMW_RET_OK` if successful, or
                              ##  \returns `RMW_RET_INVALID_ARGUMENT` if `topic_endpoint_info` is NULL, or
                              ##  \returns `RMW_RET_INVALID_ARGUMENT` if `gid` is NULL, or
                              ##  \returns `RMW_RET_INVALID_ARGUMENT` if `size` is greater than RMW_GID_STORAGE_SIZE, or
                              ##  \returns `RMW_RET_ERROR` when an unspecified error occurs.
                              ##  \remark This function sets the RMW error state on failure.
                              ##

proc rmw_topic_endpoint_info_set_qos_profile*(
    topic_endpoint_info: ptr rmw_topic_endpoint_info_t;
    qos_profile: ptr rmw_qos_profile_t): rmw_ret_t {.
    importc: "rmw_topic_endpoint_info_set_qos_profile",
    header: "topic_endpoint_info.h".}
  ##  Set the endpoint QoS profile in the given topic endpoint info data structure.
                                     ##
                                     ##  This functions assigns the value of the `qos_profile` argument to the data structure
                                     ##  `qos_profile` member.
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
                                     ##    Setting a member is a reentrant procedure, but access to the
                                     ##    topic endpoint info data structure is not synchronized.
                                     ##    It is not safe to read or write the `qos_profile` member of the
                                     ##    given `topic_endpoint` while setting it.
                                     ##
                                     ##  \param[inout] topic_endpoint_info Data structure to be populated.
                                     ##  \param[in] qos_profile QoS profile to be set.
                                     ##  \returns `RMW_RET_OK` if successful, or
                                     ##  \returns `RMW_RET_INVALID_ARGUMENT` if `topic_endpoint_info` is NULL, or
                                     ##  \returns `RMW_RET_INVALID_ARGUMENT` if `qos_profile` is NULL, or
                                     ##  \returns `RMW_RET_ERROR` when an unspecified error occurs.
                                     ##  \remark This function sets the RMW error state on failure.
                                     ## 