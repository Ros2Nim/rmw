##  #pragma c2nim mangle "'rosidl_runtime_c__' {\\w+}" "$1"
##  #pragma c2nim mangle "'namespace_'" "namespace"
##  #pragma c2nim mangle "'rmw_time_s'" "rmw_time_t"

##  Copyright 2014-2017 Open Source Robotics Foundation, Inc.
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

##  map rcutils specific log levels to rmw speicfic type

import
  rcutils/logging, rcutils/logging, rcutils/logging, rcutils/allocator,
  rcutils/allocator, rcutils/macros, rcutils/macros, rcutils/macros,
  rcutils/macros, rcutils/macros, rcutils/allocator, rcutils/types/rcutils_ret,
  rcutils/allocator, rcutils/visibility_control_macros,
  rcutils/visibility_control_macros, rcutils/allocator, rcutils/logging,
  rcutils/error_handling, rcutils/error_handling, rcutils/error_handling,
  rcutils/error_handling, rcutils/error_handling, rcutils/error_handling,
  rcutils/snprintf, rcutils/snprintf, rcutils/error_handling,
  rcutils/testing/fault_injection, rcutils/testing/fault_injection,
  rcutils/testing/fault_injection, rcutils/error_handling,
  rcutils/error_handling, rcutils/error_handling, rcutils/error_handling,
  rcutils/logging, rcutils/types/array_list, rcutils/types/array_list,
  rcutils/types/char_array, rcutils/types/char_array, rcutils/types/hash_map,
  rcutils/types/hash_map, rcutils/types/string_array,
  rcutils/types/string_array, rcutils/qsort, rcutils/qsort,
  rcutils/types/string_array, rcutils/types/string_map,
  rcutils/types/string_map, rcutils/types/uint8_array,
  rcutils/types/uint8_array, rcutils/logging, ./events_statuses/events_statuses,
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
  ./events_statuses/events_statuses, ./init, ./init_options, ./init_options,
  ./domain_id, ./init_options, ./localhost, ./init_options, ./init_options,
  ./ret_types, ./init_options, ./security_options, ./security_options,
  ./init_options, ./init, ./serialized_message,
  ./subscription_content_filter_options, ./subscription_content_filter_options,
  ./time, ./time

const
  RMW_GID_STORAGE_SIZE* = 16'u ##  We define the GID as 16 bytes (128 bits).  This should be enough to ensure
                               ##  uniqueness amongst all entities in the system.  It is up to the individual
                               ##  RMW implementations to fill that in, either from the underlying middleware
                               ##  or from the RMW layer itself.

type

  rmw_node_t* {.importc: "rmw_node_t", header: "types.h", bycopy.} = object
    implementation_identifier* {.importc: "implementation_identifier".}: cstring ##
                              ##  Name of the rmw implementation
    data* {.importc: "data".}: pointer ##  Type erased pointer to this node's data
    name* {.importc: "name".}: cstring ##  A concise name of this rmw node for identification
    namespace_* {.importc: "namespace_".}: cstring ##
                              ##  The namespace of this rmw node
    context* {.importc: "context".}: ptr rmw_context_t ##
                              ##  Context information about node's init specific information


  rmw_endpoint_type_t* {.size: sizeof(cint).} = enum
    RMW_ENDPOINT_INVALID = 0, ##  Creates and publishes messages to the ROS topic
    RMW_ENDPOINT_PUBLISHER, ##  Listens for and receives messages from a topic
    RMW_ENDPOINT_SUBSCRIPTION

  rmw_unique_network_flow_endpoints_requirement_t* {.size: sizeof(cint).} = enum
    RMW_UNIQUE_NETWORK_FLOW_ENDPOINTS_NOT_REQUIRED = 0, ##
                              ##  Unique network flow endpoins strictly required.
                              ##  Error if not provided by RMW implementation.
    RMW_UNIQUE_NETWORK_FLOW_ENDPOINTS_STRICTLY_REQUIRED, ##
                              ##  Unique network flow endpoints optionally required.
                              ##  No error if not provided RMW implementation.
    RMW_UNIQUE_NETWORK_FLOW_ENDPOINTS_OPTIONALLY_REQUIRED, ##
                              ##  Unique network flow endpoints requirement decided by system.
    RMW_UNIQUE_NETWORK_FLOW_ENDPOINTS_SYSTEM_DEFAULT

  rmw_publisher_options_t* {.importc: "rmw_publisher_options_t",
                             header: "types.h", bycopy.} = object
    rmw_specific_publisher_payload* {.importc: "rmw_specific_publisher_payload".}: pointer ##
                              ##  Used to pass rmw implementation specific resources during publisher creation.
                              ##
                              ##  This field is type erased (rather than forward declared) because it will
                              ##  usually be a non-owned reference to an language specific object, e.g.
                              ##  C++ it may be a polymorphic class that only the rmw implementation can use.
                              ##
                              ##  The resource pointed to here needs to outlive this options structure, and
                              ##  any rmw_publisher objects that are created using it, as they copy this
                              ##  structure and may use this payload throughout their lifetime.
                              ##
    ##  Require middleware to generate unique network flow endpoints.
    require_unique_network_flow_endpoints*
        {.importc: "require_unique_network_flow_endpoints".}: rmw_unique_network_flow_endpoints_requirement_t ##
                              ##
                              ##  Unique network flow endpoints are required to differentiate the QoS provided by
                              ##  networks for flows between publishers and subscribers in communicating
                              ##  nodes.
                              ##  Default value is RMW_UNIQUE_NETWORK_FLOW_ENDPOINTS_NOT_REQUIRED.
                              ##


  rmw_publisher_t* {.importc: "rmw_publisher_t", header: "types.h", bycopy.} = object
    implementation_identifier* {.importc: "implementation_identifier".}: cstring ##
                              ##  Name of the rmw implementation
    data* {.importc: "data".}: pointer ##  Type erased pointer to this publisher's data
    topic_name* {.importc: "topic_name".}: cstring ##
                              ##  The name of the ROS topic this publisher publishes to
    ##  Publisher options.
    options* {.importc: "options".}: rmw_publisher_options_t ##
                              ##
                              ##  The options structure passed to rmw_create_publisher() should be
                              ##  assigned to this field by the rmw implementation.
                              ##  The fields should not be modified after creation, but
                              ##  the contents of the options structure may or may not be const, i.e.
                              ##  shallow const-ness.
                              ##  This field is not marked const to avoid any const casting during setup.
                              ##
    can_loan_messages* {.importc: "can_loan_messages".}: bool ##
                              ##  Indicate whether this publisher supports loaning messages


  rmw_subscription_options_t* {.importc: "rmw_subscription_options_t",
                                header: "types.h", bycopy.} = object
    rmw_specific_subscription_payload* {.
        importc: "rmw_specific_subscription_payload".}: pointer ##
                              ##  Used to pass rmw implementation specific resources during subscription creation.
                              ##
                              ##  All the same details and restrictions of this field in
                              ##  rmw_publisher_options_t apply to this struct as well.
                              ##
                              ##  \sa rmw_publisher_options_t.rmw_specific_publisher_payload
                              ##
    ##  If true then the middleware should not deliver data from local publishers.
    ignore_local_publications* {.importc: "ignore_local_publications".}: bool ##
                              ##
                              ##  This setting is most often used when data should only be received from
                              ##  remote nodes, especially to avoid "double delivery" when both intra- and
                              ##  inter- process communication is taking place.
                              ##
                              ##  \todo(wjwwood): nail this down when participant mapping is sorted out.
                              ##    See: https://github.com/ros2/design/pull/250
                              ##
                              ##  The definition of local is somewhat vague at the moment.
                              ##  Right now it means local to the node, and that definition works best, but
                              ##  may become more complicated when/if participants map to a context instead.
                              ##
    ##  Require middleware to generate unique network flow endpoints.
    require_unique_network_flow_endpoints*
        {.importc: "require_unique_network_flow_endpoints".}: rmw_unique_network_flow_endpoints_requirement_t ##
                              ##
                              ##  Unique network flow endpoints are required to differentiate the QoS provided by
                              ##  networks for flows between publishers and subscribers in communicating
                              ##  nodes.
                              ##  Default value is RMW_UNIQUE_NETWORK_FLOW_ENDPOINTS_NOT_REQUIRED.
                              ##
    content_filter_options* {.importc: "content_filter_options".}: ptr rmw_subscription_content_filter_options_t ##
                              ##  Used to create a content filter options during subscription creation.


  rmw_subscription_t* {.importc: "rmw_subscription_t", header: "types.h", bycopy.} = object
    implementation_identifier* {.importc: "implementation_identifier".}: cstring ##
                              ##  Name of the rmw implementation
    data* {.importc: "data".}: pointer ##  Type erased pointer to this subscription
    topic_name* {.importc: "topic_name".}: cstring ##
                              ##  Name of the ros topic this subscription listens to
    ##  Subscription options.
    options* {.importc: "options".}: rmw_subscription_options_t ##
                              ##
                              ##  The options structure passed to rmw_create_subscription() should be
                              ##  assigned to this field by the rmw implementation.
                              ##  The fields should not be modified after creation, but
                              ##  the contents of the options structure may or may not be const, i.e.
                              ##  shallow const-ness.
                              ##  This field is not marked const to avoid any const casting during setup.
                              ##
    can_loan_messages* {.importc: "can_loan_messages".}: bool ##
                              ##  Indicates whether this subscription can loan messages
    is_cft_enabled* {.importc: "is_cft_enabled".}: bool ##
                              ##  Indicates whether content filtered topic of this subscription is enabled


  rmw_service_t* {.importc: "rmw_service_t", header: "types.h", bycopy.} = object
    implementation_identifier* {.importc: "implementation_identifier".}: cstring ##
                              ##  The name of the rmw implementation
    data* {.importc: "data".}: pointer ##  Type erased pointer to this service
    service_name* {.importc: "service_name".}: cstring ##
                              ##  The name of this service as exposed to the ros graph


  rmw_client_t* {.importc: "rmw_client_t", header: "types.h", bycopy.} = object
    implementation_identifier* {.importc: "implementation_identifier".}: cstring ##
                              ##  The name of the rmw implementation
    data* {.importc: "data".}: pointer ##  Type erased pointer to this service client
    service_name* {.importc: "service_name".}: cstring ##
                              ##  The name of this service as exposed to the ros graph


  rmw_guard_condition_t* {.importc: "rmw_guard_condition_t", header: "types.h",
                           bycopy.} = object
    implementation_identifier* {.importc: "implementation_identifier".}: cstring ##
                              ##  The name of the rmw implementation
    data* {.importc: "data".}: pointer ##  Type erased pointer to this guard condition
    context* {.importc: "context".}: ptr rmw_context_t ##
                              ##  rmw context associated with this guard condition


  rmw_publisher_allocation_t* {.importc: "rmw_publisher_allocation_t",
                                header: "types.h", bycopy.} = object
    implementation_identifier* {.importc: "implementation_identifier".}: cstring ##
                              ##  The name of the rmw implementation
    data* {.importc: "data".}: pointer ##  Type erased pointer to this allocation


  rmw_subscription_allocation_t* {.importc: "rmw_subscription_allocation_t",
                                   header: "types.h", bycopy.} = object
    implementation_identifier* {.importc: "implementation_identifier".}: cstring ##
                              ##  The name of the rmw implementation
    data* {.importc: "data".}: pointer ##  Type erased pointer to this allocation


  rmw_subscriptions_t* {.importc: "rmw_subscriptions_t", header: "types.h",
                         bycopy.} = object
    subscriber_count* {.importc: "subscriber_count".}: csize_t ##
                              ##  The number of subscribers represented by the array.
    subscribers* {.importc: "subscribers".}: ptr pointer ##
                              ##  Pointer to an array of void * pointers of subscriptions.


  rmw_services_t* {.importc: "rmw_services_t", header: "types.h", bycopy.} = object
    service_count* {.importc: "service_count".}: csize_t ##
                              ##  The number of services represented by the array.
    services* {.importc: "services".}: ptr pointer ##
                              ##  Pointer to an array of void * pointers of services.


  rmw_clients_t* {.importc: "rmw_clients_t", header: "types.h", bycopy.} = object
    client_count* {.importc: "client_count".}: csize_t ##
                              ##  The number of clients represented by the array.
    clients* {.importc: "clients".}: ptr pointer ##  Pointer to an array of void * pointers of clients.


  rmw_events_t* {.importc: "rmw_events_t", header: "types.h", bycopy.} = object
    event_count* {.importc: "event_count".}: csize_t ##
                              ##  The number of events represented by the array.
    events* {.importc: "events".}: ptr pointer ##  Pointer to an array of void * pointers of events.


  rmw_guard_conditions_t* {.importc: "rmw_guard_conditions_t",
                            header: "types.h", bycopy.} = object
    guard_condition_count* {.importc: "guard_condition_count".}: csize_t ##
                              ##  The number of guard conditions represented by the array.
    guard_conditions* {.importc: "guard_conditions".}: ptr pointer ##
                              ##  Pointer to an array of void * pointers of guard conditions.


  rmw_wait_set_t* {.importc: "rmw_wait_set_t", header: "types.h", bycopy.} = object
    implementation_identifier* {.importc: "implementation_identifier".}: cstring ##
                              ##  The name of the rmw implementation
    guard_conditions* {.importc: "guard_conditions".}: ptr rmw_guard_conditions_t ##
                              ##  The guard condition to be waited on
    data* {.importc: "data".}: pointer ##  Type erased pointer to this wait set's data


  rmw_request_id_t* {.importc: "rmw_request_id_t", header: "types.h", bycopy.} = object
    writer_guid* {.importc: "writer_guid".}: array[16'u, uint8] ##
                              ##  The guid of the writer associated with this request
    sequence_number* {.importc: "sequence_number".}: int64 ##
                              ##  Sequence number of this service


  rmw_service_info_t* {.importc: "rmw_service_info_t", header: "types.h", bycopy.} = object
    source_timestamp* {.importc: "source_timestamp".}: rmw_time_point_value_t
    received_timestamp* {.importc: "received_timestamp".}: rmw_time_point_value_t
    request_id* {.importc: "request_id".}: rmw_request_id_t


  rmw_qos_reliability_policy_t* {.size: sizeof(cint).} = enum
    RMW_QOS_POLICY_RELIABILITY_SYSTEM_DEFAULT, ##  Guarantee that samples are delivered, may retry multiple times.
    RMW_QOS_POLICY_RELIABILITY_RELIABLE, ##  Attempt to deliver samples, but some may be lost if the network is not robust
    RMW_QOS_POLICY_RELIABILITY_BEST_EFFORT, ##  Reliability policy has not yet been set
    RMW_QOS_POLICY_RELIABILITY_UNKNOWN, ##  Will match the majority of endpoints and use a reliable policy if possible
                                         ##
                                         ##  A policy will be chosen at the time of creating a subscription or publisher.
                                         ##  A reliable policy will by chosen if it matches with all discovered endpoints,
                                         ##  otherwise a best effort policy will be chosen.
                                         ##
                                         ##  The QoS policy reported by functions like `rmw_subscription_get_actual_qos` or
                                         ##  `rmw_publisher_get_actual_qos` may be best available, reliable, or best effort.
                                         ##
                                         ##  Services and clients are not supported and default to the reliability value in
                                         ##  `rmw_qos_profile_services_default`.
                                         ##
                                         ##  The middleware is not expected to update the policy after creating a subscription or
                                         ##  publisher, even if the chosen policy is incompatible with newly discovered endpoints.
                                         ##  Therefore, this policy should be used with care since non-deterministic behavior
                                         ##  can occur due to races with discovery.
                                         ##
    RMW_QOS_POLICY_RELIABILITY_BEST_AVAILABLE

  rmw_qos_history_policy_t* {.size: sizeof(cint).} = enum
    RMW_QOS_POLICY_HISTORY_SYSTEM_DEFAULT, ##  Only store up to a maximum number of samples, dropping oldest once max is exceeded
    RMW_QOS_POLICY_HISTORY_KEEP_LAST, ##  Store all samples, subject to resource limits
    RMW_QOS_POLICY_HISTORY_KEEP_ALL, ##  History policy has not yet been set
    RMW_QOS_POLICY_HISTORY_UNKNOWN

  rmw_qos_durability_policy_t* {.size: sizeof(cint).} = enum
    RMW_QOS_POLICY_DURABILITY_SYSTEM_DEFAULT, ##  The rmw publisher is responsible for persisting samples for “late-joining” subscribers
    RMW_QOS_POLICY_DURABILITY_TRANSIENT_LOCAL, ##  Samples are not persistent
    RMW_QOS_POLICY_DURABILITY_VOLATILE, ##  Durability policy has not yet been set
    RMW_QOS_POLICY_DURABILITY_UNKNOWN, ##  Will match the majority of endpoints and use a transient local policy if possible
                                        ##
                                        ##  A policy will be chosen at the time of creating a subscription or publisher.
                                        ##  A transient local policy will by chosen if it matches with all discovered endpoints,
                                        ##  otherwise a volatile policy will be chosen.
                                        ##
                                        ##  In the case that a volatile policy is chosen for a subscription, any messages sent before
                                        ##  the subscription was created by transient local publishers will not be received.
                                        ##
                                        ##  The QoS policy reported by functions like `rmw_subscription_get_actual_qos` or
                                        ##  `rmw_publisher_get_actual_qos` may be best available, transient local, or volatile.
                                        ##
                                        ##  Services and clients are not supported and default to the durability value in
                                        ##  `rmw_qos_profile_services_default`.
                                        ##
                                        ##  The middleware is not expected to update the policy after creating a subscription or
                                        ##  publisher, even if the chosen policy is incompatible with newly discovered endpoints.
                                        ##  Therefore, this policy should be used with care since non-deterministic behavior
                                        ##  can occur due to races with discovery.
                                        ##
    RMW_QOS_POLICY_DURABILITY_BEST_AVAILABLE

  rmw_qos_liveliness_policy_t* {.size: sizeof(cint).} = enum
    RMW_QOS_POLICY_LIVELINESS_SYSTEM_DEFAULT = 0, ##
                              ##  The signal that establishes a Topic is alive comes from the ROS rmw layer.
    RMW_QOS_POLICY_LIVELINESS_AUTOMATIC = 1, ##  Explicitly asserting node liveliness is required in this case.
                                              ##  This option is deprecated, use RMW_QOS_POLICY_LIVELINESS_MANUAL_BY_TOPIC if your application
                                              ##  requires to assert liveliness manually.
    RMW_QOS_POLICY_LIVELINESS_MANUAL_BY_NODE = 2, ##
                              ##  The signal that establishes a Topic is alive is at the Topic level. Only publishing a message
                              ##  on the Topic or an explicit signal from the application to assert liveliness on the Topic
                              ##  will mark the Topic as being alive.
                              ##  Using `3` for backwards compatibility.
    RMW_QOS_POLICY_LIVELINESS_MANUAL_BY_TOPIC = 3, ##
                              ##  Liveliness policy has not yet been set
    RMW_QOS_POLICY_LIVELINESS_UNKNOWN = 4, ##  Will match the majority of endpoints and use a manual by topic policy if possible
                                            ##
                                            ##  A policy will be chosen at the time of creating a subscription or publisher.
                                            ##  A manual by topic policy will by chosen if it matches with all discovered endpoints,
                                            ##  otherwise an automatic policy will be chosen.
                                            ##
                                            ##  The QoS policy reported by functions like `rmw_subscription_get_actual_qos` or
                                            ##  `rmw_publisher_get_actual_qos` may be best available, automatic, or manual by topic.
                                            ##
                                            ##  Services and clients are not supported and default to the liveliness value in
                                            ##  `rmw_qos_profile_services_default`.
                                            ##
                                            ##  The middleware is not expected to update the policy after creating a subscription or
                                            ##  publisher, even if the chosen policy is incompatible with newly discovered endpoints.
                                            ##  Therefore, this policy should be used with care since non-deterministic behavior
                                            ##  can occur due to races with discovery.
                                            ##
    RMW_QOS_POLICY_LIVELINESS_BEST_AVAILABLE = 5

  rmw_qos_profile_t* {.importc: "rmw_qos_profile_t", header: "types.h", bycopy.} = object
    history* {.importc: "history".}: rmw_qos_history_policy_t
    depth* {.importc: "depth".}: csize_t ##  Size of the message queue.
    reliability* {.importc: "reliability".}: rmw_qos_reliability_policy_t ##
                              ##  Reliabiilty QoS policy setting
    durability* {.importc: "durability".}: rmw_qos_durability_policy_t ##
                              ##  Durability QoS policy setting
    ##  The period at which messages are expected to be sent/received
    deadline* {.importc: "deadline".}: rmw_time_s ##
                                                  ##  RMW_DURATION_UNSPEFICIED will use the RMW implementation's default value,
                                                  ##    which may or may not be infinite.
                                                  ##  RMW_DURATION_INFINITE explicitly states that messages never miss a deadline expectation.
                                                  ##
    ##  The age at which messages are considered expired and no longer valid
    lifespan* {.importc: "lifespan".}: rmw_time_s ##
                                                  ##  RMW_DURATION_UNSPEFICIED will use the RMW implementation's default value,
                                                  ##    which may or may not be infinite.
                                                  ##  RMW_DURATION_INFINITE explicitly states that messages do not expire.
                                                  ##
    liveliness* {.importc: "liveliness".}: rmw_qos_liveliness_policy_t ##
                              ##  Liveliness QoS policy setting
    ##  The time within which the RMW node or publisher must show that it is alive
    liveliness_lease_duration* {.importc: "liveliness_lease_duration".}: rmw_time_s ##
                              ##
                              ##  RMW_DURATION_UNSPEFICIED will use the RMW implementation's default value,
                              ##    which may or may not be infinite.
                              ##  RMW_DURATION_INFINITE explicitly states that liveliness is not enforced.
                              ##
    ##  If true, any ROS specific namespacing conventions will be circumvented.
    avoid_ros_namespace_conventions* {.importc: "avoid_ros_namespace_conventions".}: bool ##
                              ##
                              ##  In the case of DDS and topics, for example, this means the typical
                              ##  ROS specific prefix of `rt` would not be applied as described here:
                              ##
                              ##
                              ## http://design.ros2.org/articles/topic_and_service_names.html#ros-specific-namespace-prefix
                              ##
                              ##  This might be useful when trying to directly connect a native DDS topic
                              ##  with a ROS 2 topic.
                              ##


  rmw_gid_t* {.importc: "rmw_gid_t", header: "types.h", bycopy.} = object
    implementation_identifier* {.importc: "implementation_identifier".}: cstring ##
                              ##  Name of the rmw implementation
    data* {.importc: "data".}: array[16'u, uint8] ##  Byte data Gid value


  rmw_message_info_t* {.importc: "rmw_message_info_t", header: "types.h", bycopy.} = object
    source_timestamp* {.importc: "source_timestamp".}: rmw_time_point_value_t ##
                              ##  Time when the message was published by the publisher.
                              ##
                              ##  The exact point at which the timestamp is taken is not specified, but
                              ##  it should be taken consistently at the same point in the
                              ##  publishing process each time.
                              ##
    ##  Time when the message was received by the subscription.
    received_timestamp* {.importc: "received_timestamp".}: rmw_time_point_value_t ##
                              ##
                              ##  The exact point at which the timestamp is taken is not specified, but
                              ##  it should be taken consistently at the same point in the
                              ##  process of receiving a message each time.
                              ##
    ##  Sequence number of the received message set by the publisher.
    publication_sequence_number* {.importc: "publication_sequence_number".}: uint64 ##
                              ##
                              ##  This sequence number is set by the publisher and therefore uniquely identifies
                              ##  a message when combined with the publisher GID.
                              ##  For long running applications, the sequence number might wrap around at some point.
                              ##
                              ##  If the rmw implementation doesn't support sequence numbers, its value will be
                              ##  RMW_MESSAGE_INFO_SEQUENCE_NUMBER_UNSUPPORTED.
                              ##
                              ##  Requirements:
                              ##
                              ##  If `psn1` and `psn2` are the publication sequence numbers obtained by
                              ##  calls to `rmw_take*()`, where `psn1` was obtained in a call that happened before `psn2` and both
                              ##  sequence numbers are from the same publisher (i.e. also same publisher gid), then:
                              ##
                              ##  - psn2 > psn1 (except in the case of a wrap around)
                              ##  - `psn2 - psn1 - 1` is the number of messages the publisher sent in the middle of both
                              ##    received messages.
                              ##    Those might have already been taken by other `rmw_take*()` calls that happened in between or lost.
                              ##    `psn2 - psn1 - 1 = 0` if and only if the messages were sent by the publisher consecutively.
                              ##
    ##  Sequence number of the received message set by the subscription.
    reception_sequence_number* {.importc: "reception_sequence_number".}: uint64 ##
                              ##
                              ##  This sequence number is set by the subscription regardless of which
                              ##  publisher sent the message.
                              ##  For long running applications, the sequence number might wrap around at some point.
                              ##
                              ##  If the rmw implementation doesn't support sequence numbers, its value will be
                              ##  RMW_MESSAGE_INFO_SEQUENCE_NUMBER_UNSUPPORTED.
                              ##
                              ##  Requirements:
                              ##
                              ##  If `rsn1` and `rsn2` are the reception sequence numbers obtained by
                              ##  calls to `rmw_take*()`, where `rsn1` was obtained in a call that happened before `rsn2`, then:
                              ##
                              ##  - rsn2 > rsn1 (except in the case of a wrap around)
                              ##  - `rsn2 = rsn1 + 1` if and only if both `rmw_take*()` calls happened consecutively.
                              ##
    ##  Global unique identifier of the publisher that sent the message.
    publisher_gid* {.importc: "publisher_gid".}: rmw_gid_t ##
                              ##
                              ##  The identifier uniquely identifies the publisher for the local context, but
                              ##  it will not necessarily be the same identifier given in other contexts or processes
                              ##  for the same publisher.
                              ##  Therefore the identifier will uniquely identify the publisher within your application
                              ##  but may disagree about the identifier for that publisher when compared to another
                              ##  application.
                              ##  Even with this limitation, when combined with the publisher sequence number it can
                              ##  uniquely identify a message within your local context.
                              ##  Publisher GIDs generated by the rmw implementation could collide at some point, in which
                              ##  case it is not possible to distinguish which publisher sent the message.
                              ##  The details of how GIDs are generated are rmw implementation dependent.
                              ##
                              ##  It is possible the the rmw implementation needs to reuse a publisher GID,
                              ##  due to running out of unique identifiers or some other constraint, in which case
                              ##  the rmw implementation may document what happens in that case, but that
                              ##  behavior is not defined here.
                              ##  However, this should be avoided, if at all possible, by the rmw implementation,
                              ##  and should be unlikely to happen in practice.
                              ##
                              ##  \todo In the future we want this to uniquely identify the publisher globally across
                              ##    contexts, processes, and machines.
                              ##
    from_intra_process* {.importc: "from_intra_process".}: bool ##
                              ##  Whether this message is from intra_process communication or not


  rmw_log_severity_t* {.size: sizeof(cint).} = enum
    RMW_LOG_SEVERITY_DEBUG = RCUTILS_LOG_SEVERITY_DEBUG, ##
                              ##  Informational log severity, for reporting expected but not overwhelming information
    RMW_LOG_SEVERITY_INFO = RCUTILS_LOG_SEVERITY_INFO, ##
                              ##  Warning log severity, for reporting recoverable issues
    RMW_LOG_SEVERITY_WARN = RCUTILS_LOG_SEVERITY_WARN, ##
                              ##  Error log severity, for reporting uncoverable issues
    RMW_LOG_SEVERITY_ERROR = RCUTILS_LOG_SEVERITY_ERROR, ##
                              ##  Fatal log severity, for reporting issue causing imminent shutdown
    RMW_LOG_SEVERITY_FATAL = RCUTILS_LOG_SEVERITY_FATAL

##  Endpoint enumeration type

##  Unique network flow endpoints requirement enumeration

##  Options that can be used to configure the creation of a publisher in rmw.

##  Structure which encapsulates an rmw publisher

##  Options that can be used to configure the creation of a subscription in rmw.

##  A handle to an rmw service

##  A handle to an rmw service client

##  Handle for an rmw guard condition

##  Allocation of memory for an rmw publisher

##  Allocation of memory for an rmw subscription

##  Array of subscriber handles.
##
##  An array of void * pointers representing type-erased middleware-specific subscriptions.
##  The number of non-null entries may be smaller than the allocated size of the array.
##  The number of subscriptions represented may be smaller than the allocated size of the array.
##  The creator of this struct is responsible for allocating and deallocating the array.
##

##  Array of service handles.
##
##  An array of void * pointers representing type-erased middleware-specific services.
##  The number of non-null entries may be smaller than the allocated size of the array.
##  The number of services represented may be smaller than the allocated size of the array.
##  The creator of this struct is responsible for allocating and deallocating the array.
##

##  Array of client handles.
##
##  An array of void * pointers representing type-erased middleware-specific clients.
##  The number of non-null entries may be smaller than the allocated size of the array.
##  The number of clients represented may be smaller than the allocated size of the array.
##  The creator of this struct is responsible for allocating and deallocating the array.
##

##  Array of guard condition handles.
##
##  An array of void * pointers representing type-erased middleware-specific guard conditions.
##  The number of non-null entries may be smaller than the allocated size of the array.
##  The number of guard conditions represented may be smaller than the allocated size of the array.
##  The creator of this struct is responsible for allocating and deallocating the array.
##

##  Container for guard conditions to be waited on

##  An rmw service request identifier

##  Meta-data for a service-related take.

##  QoS history enumerations describing how samples endure

##  QoS durability enumerations describing how samples persist

##  QoS liveliness enumerations that describe a publisher's reporting policy for its alive status.
##  For a subscriber, these are its requirements for its topic's publishers.
##  Suppress syntax errors, as cppcheck does not seem to handle enumerator attributes.
##  cppcheck-suppress syntaxError

##  QoS Deadline default.

##  Will match the majority of endpoints while maintaining as strict a policy as possible
##
##  Value is RMW_DURATION_INFINITE - 1.
##
##  A policy will be chosen at the time of creating a subscription or publisher.
##  For a subscription, the deadline will be the maximum value of all discovered publisher
##  deadlines.
##  For a publisher, the deadline will be the minimum value of all discovered subscription
##  deadlines.
##
##  The QoS policy reported by functions like `rmw_subscription_get_actual_qos` or
##  `rmw_publisher_get_actual_qos` may be best available or the actual deadline value.
##
##  Services and clients are not supported and default to the deadline value in
##  `rmw_qos_profile_services_default`.
##
##  The middleware is not expected to update the policy after creating a subscription or
##  publisher, even if the chosen policy is incompatible with newly discovered endpoints.
##  Therefore, this policy should be used with care since non-deterministic behavior
##  can occur due to races with discovery.
##

##  QoS Lifespan default.

##  QoS Liveliness lease duration default.

##  Will match the majority of endpoints while maintaining as strict a policy as possible
##
##  Value is RMW_DURATION_INFINITE - 1.
##
##  A policy will be chosen at the time of creating a subscription or publisher.
##  For a subscription, the lease duration will be the maximum value of all discovered publisher
##  lease durations.
##  For a publisher, the lease duration will be the minimum value of all discovered subscription
##  lease durations.
##
##  The QoS policy reported by functions like `rmw_subscription_get_actual_qos` or
##  `rmw_publisher_get_actual_qos` may be best available or the actual lease duration value.
##
##  Services and clients are not supported and default to the lease duration value in
##  `rmw_qos_profile_services_default`.
##
##  The middleware is not expected to update the policy after creating a subscription or
##  publisher, even if the chosen policy is incompatible with newly discovered endpoints.
##  Therefore, this policy should be used with care since non-deterministic behavior
##  can occur due to races with discovery.
##

##  ROS MiddleWare quality of service profile.

##  ROS graph ID of the topic

##  Information describing an rmw message


proc rmw_get_zero_initialized_message_info*(): rmw_message_info_t {.
    importc: "rmw_get_zero_initialized_message_info", header: "types.h".}
  ##
                              ##  Get zero initialized mesage info.
##  Default size of the rmw queue when history is set to RMW_QOS_POLICY_HISTORY_KEEP_LAST,
##  0 indicates it is currently not set

##  Type mapping of rcutils log severity types to rmw specific types.
