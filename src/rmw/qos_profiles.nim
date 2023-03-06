##  #pragma c2nim mangle "'rosidl_runtime_c__' {\\w+}" "$1"
##  #pragma c2nim mangle "'namespace_'" "namespace"
##  #pragma c2nim mangle "'rmw_time_s'" "rmw_time_t"

##  Copyright 2015 Open Source Robotics Foundation, Inc.
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
  rcutils/visibility_control_macros, rcutils/visibility_control_macros,
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

let rmw_qos_profile_sensor_data* {.importc: "rmw_qos_profile_sensor_data",
                                   header: "qos_profiles.h".}: rmw_qos_profile_t

let rmw_qos_profile_parameters* {.importc: "rmw_qos_profile_parameters",
                                  header: "qos_profiles.h".}: rmw_qos_profile_t

let rmw_qos_profile_default* {.importc: "rmw_qos_profile_default",
                               header: "qos_profiles.h".}: rmw_qos_profile_t

let rmw_qos_profile_services_default* {.importc: "rmw_qos_profile_services_default",
                                        header: "qos_profiles.h".}: rmw_qos_profile_t

let rmw_qos_profile_parameter_events* {.importc: "rmw_qos_profile_parameter_events",
                                        header: "qos_profiles.h".}: rmw_qos_profile_t

let rmw_qos_profile_system_default* {.importc: "rmw_qos_profile_system_default",
                                      header: "qos_profiles.h".}: rmw_qos_profile_t

##  Match majority of endpoints currently available while maintaining the highest level of service
##
##  Reliability, durability, deadline, liveliness, and liveliness lease duration policies will be
##  chosen at the time of creating a subscription or publisher.
##
##  The actual QoS policy can be retrieved after the endpoint is created with
##  `rmw_get_subscriptions_info_by_topic` or `rmw_get_publishers_info_by_topic`.
##
##  The middleware is not expected to update policies after creating a subscription or
##  publisher, even if one or more policies are incompatible with newly discovered endpoints.
##  Therefore, this profile should be used with care since non-deterministic behavior
##  can occur due to races with discovery.
##

let rmw_qos_profile_best_available* {.importc: "rmw_qos_profile_best_available",
                                      header: "qos_profiles.h".}: rmw_qos_profile_t

let rmw_qos_profile_unknown* {.importc: "rmw_qos_profile_unknown",
                               header: "qos_profiles.h".}: rmw_qos_profile_t


type                        ##  QoS policies are compatible

  rmw_qos_compatibility_type_t* {.size: sizeof(cint).} = enum
    RMW_QOS_COMPATIBILITY_OK = 0, ##  QoS policies may not be compatible
    RMW_QOS_COMPATIBILITY_WARNING, ##  QoS policies are not compatible
    RMW_QOS_COMPATIBILITY_ERROR


proc rmw_qos_profile_check_compatible*(publisher_profile: rmw_qos_profile_t;
                                       subscription_profile: rmw_qos_profile_t;
    compatibility: ptr rmw_qos_compatibility_type_t; reason: cstring;
                                       reason_size: csize_t): rmw_ret_t {.
    importc: "rmw_qos_profile_check_compatible", header: "qos_profiles.h".}
  ##
                              ##  Check if two QoS profiles are compatible.
                              ##
                              ##  Two QoS profiles are compatible if a publisher and subcription
                              ##  using the QoS policies can communicate with each other.
                              ##
                              ##  If any of the profile policies has the value "system default" or "unknown", then it may not be
                              ##  possible to determine the compatibilty.
                              ##  In this case, the output parameter `compatibility` is set to `RMW_QOS_COMPATIBILITY_WARNING`
                              ##  and `reason` is populated.
                              ##
                              ##  If there is a compatibility warning or error, and a buffer is provided for `reason`, then an
                              ##  explanation of all warnings and errors will be populated into the buffer, separated by
                              ##  semi-colons (`;`).
                              ##  Errors will appear before warnings in the string buffer.
                              ##  If the provided buffer is not large enough, this function will still write to the buffer, up to
                              ##  the `reason_size` number of characters.
                              ##  Therefore, it is possible that not all errors and warnings are communicated if the buffer size limit
                              ##  is reached.
                              ##  A buffer size of 2048 should be more than enough to capture all possible errors and warnings.
                              ##
                              ##  <hr>
                              ##  Attribute          | Adherence
                              ##  ------------------ | -------------
                              ##  Allocates Memory   | No
                              ##  Thread-Safe        | Yes
                              ##  Uses Atomics       | No
                              ##  Lock-Free          | Yes
                              ##
                              ##  \param[in] publisher_profile: The QoS profile used for a publisher.
                              ##  \param[in] subscription_profile: The QoS profile used for a subscription.
                              ##  \param[out] compatibility: `RMW_QOS_COMPATIBILITY_OK` if the QoS profiles are compatible, or
                              ##    `RMW_QOS_COMPATIBILITY_WARNING` if the QoS profiles might be compatible, or
                              ##    `RMW_QOS_COMPATIBILITY_ERROR` if the QoS profiles are not compatible.
                              ##  \param[out] reason: A detailed reason for a QoS incompatibility or potential incompatibility.
                              ##    Must be pre-allocated by the caller.
                              ##    This parameter is optional and may be set to `NULL` if the reason information is not
                              ##    desired.
                              ##  \param[in] reason_size: Size of the string buffer `reason`, if one is provided.
                              ##    If `reason` is `nullptr`, then this parameter must be zero.
                              ##  \return `RMW_RET_OK` if the check was successful, or
                              ##  \return `RMW_RET_INVALID_ARGUMENT` if `compatiblity` is `nullptr`, or
                              ##  \return `RMW_RET_INVALID_ARGUMENT` if `reason` is `NULL` and  `reason_size` is not zero, or
                              ##  \return `RMW_RET_ERROR` if there is an unexpected error.
                              ## 