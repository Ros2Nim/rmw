import types

##  Copyright 2020 Open Source Robotics Foundation, Inc.
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


proc rmw_qos_policy_kind_to_str*(kind: rmw_qos_policy_kind_t): cstring {.
    importc: "rmw_qos_policy_kind_to_str", header: "qos_string_conversions.h".}
  ##
                              ##  Return a string representing the policy kind.
                              ##
                              ##  Returns `NULL` when `kind` is `RMW_QOS_POLICY_INVALID` or an undefined kind.
                              ##
                              ##  The stringified version of the policy kind can be obtained doing the follwing conversion:
                              ##  RMW_QOS_POLICY_<POLICY_KIND> -> lower_case(<POLICY_KIND>)
                              ##
                              ##  For example, the stringified version of `RMW_QOS_POLICY_DURABILITY` is
                              ##  "durability" and `RMW_QOS_POLICY_DEADLINE` is "deadline".
                              ##
                              ##  <hr>
                              ##  Attribute          | Adherence
                              ##  ------------------ | -------------
                              ##  Allocates Memory   | No
                              ##  Thread-Safe        | Yes
                              ##  Uses Atomics       | No
                              ##  Lock-Free          | Yes
                              ##
                              ##  \param[in] kind qos policy kind to be stringified.
                              ##  \return a null terminated string representing the policy kind, or
                              ##  \return `NULL` if kind is `RMW_QOS_POLICY_INVALID` or an undefined kind.
                              ##

proc rmw_qos_durability_policy_to_str*(value: rmw_qos_durability_policy_t): cstring {.
    importc: "rmw_qos_durability_policy_to_str",
    header: "qos_string_conversions.h".}
  ##  Return a string representing the policy value.
                                        ##
                                        ##  Returns `NULL` when `value` is `RMW_QOS_POLICY_*_UNKNOWN` or an undefined enum value.
                                        ##
                                        ##  The stringified version of the policy value can be obtained doing the follwing conversion:
                                        ##  RMW_QOS_POLICY_<POLICY_KIND>_<POLICY_VALUE> -> lower_case(<POLICY_VALUE>)
                                        ##
                                        ##  For example, the stringified version of `RMW_QOS_POLICY_LIVELINESS_MANUAL_BY_TOPIC` is
                                        ##  "manual_by_topic" and `RMW_QOS_POLICY_RELIABILITY_BEST_EFFORT` is "best_effort".
                                        ##
                                        ##  <hr>
                                        ##  Attribute          | Adherence
                                        ##  ------------------ | -------------
                                        ##  Allocates Memory   | No
                                        ##  Thread-Safe        | Yes
                                        ##  Uses Atomics       | No
                                        ##  Lock-Free          | Yes
                                        ##
                                        ##  \param[in] value qos policy value to be stringified.
                                        ##  \return a null terminated string representing the policy value, or
                                        ##  \return `NULL` if value is `RMW_QOS_POLICY_*_UNKNOWN` or an undefined enum value.
                                        ##

proc rmw_qos_history_policy_to_str*(value: rmw_qos_history_policy_t): cstring {.
    importc: "rmw_qos_history_policy_to_str", header: "qos_string_conversions.h".}
  ##
                              ##  Return a string representing the policy value.
                              ##
                              ##  See \ref rmw_qos_durability_policy_to_str() for more details.
                              ##

proc rmw_qos_liveliness_policy_to_str*(value: rmw_qos_liveliness_policy_t): cstring {.
    importc: "rmw_qos_liveliness_policy_to_str",
    header: "qos_string_conversions.h".}
  ##  Return a string representing the policy value.
                                        ##
                                        ##  See \ref rmw_qos_durability_policy_to_str() for more details.
                                        ##

proc rmw_qos_reliability_policy_to_str*(value: rmw_qos_reliability_policy_t): cstring {.
    importc: "rmw_qos_reliability_policy_to_str",
    header: "qos_string_conversions.h".}
  ##  Return a string representing the policy value.
                                        ##
                                        ##  See \ref rmw_qos_durability_policy_to_str() for more details.
                                        ##

proc rmw_qos_policy_kind_from_str*(str: cstring): rmw_qos_policy_kind_t {.
    importc: "rmw_qos_policy_kind_from_str", header: "qos_string_conversions.h".}
  ##
                              ##  Return a policy kind based on the provided string.
                              ##
                              ##  Returns the policy kind represented by the provided string, or
                              ##  `RMW_QOS_POLICY_INVALID` when the provided string doesn't represent any policy kind.
                              ##
                              ##  How policy kinds are stringified is explained in \ref rmw_qos_policy_kind_to_str.
                              ##
                              ##  <hr>
                              ##  Attribute          | Adherence
                              ##  ------------------ | -------------
                              ##  Allocates Memory   | No
                              ##  Thread-Safe        | Yes
                              ##  Uses Atomics       | No
                              ##  Lock-Free          | Yes
                              ##
                              ##  \param[in] str string identifying a qos policy kind.
                              ##  \return the policy kind represented by the string, or
                              ##  \return `RMW_QOS_POLICY_INVALID` if the string doesn't represent any policy kind.
                              ##

proc rmw_qos_durability_policy_from_str*(str: cstring): rmw_qos_durability_policy_t {.
    importc: "rmw_qos_durability_policy_from_str",
    header: "qos_string_conversions.h".}
  ##  Return a enum value based on the provided string.
                                        ##
                                        ##  Returns the enum value based on the provided string, or
                                        ##  `RMW_QOS_POLICY_*_UNKNOWN` when the provided string is unexpected.
                                        ##
                                        ##  How policy values are stringified is explained in \ref rmw_qos_durability_policy_to_str.
                                        ##
                                        ##  <hr>
                                        ##  Attribute          | Adherence
                                        ##  ------------------ | -------------
                                        ##  Allocates Memory   | No
                                        ##  Thread-Safe        | Yes
                                        ##  Uses Atomics       | No
                                        ##  Lock-Free          | Yes
                                        ##
                                        ##  \param[in] str string identifying a qos policy value.
                                        ##  \return the policy value represented by the string, or
                                        ##  \return `RMW_QOS_POLICY_*_UNKNOWN` if the string doesn't represent any value.
                                        ##

proc rmw_qos_history_policy_from_str*(str: cstring): rmw_qos_history_policy_t {.
    importc: "rmw_qos_history_policy_from_str",
    header: "qos_string_conversions.h".}
  ##  Return a enum value based on the provided string.
                                        ##
                                        ##  See \ref rmw_qos_durability_policy_from_str() for more details.
                                        ##

proc rmw_qos_liveliness_policy_from_str*(str: cstring): rmw_qos_liveliness_policy_t {.
    importc: "rmw_qos_liveliness_policy_from_str",
    header: "qos_string_conversions.h".}
  ##  Return a enum value based on the provided string.
                                        ##
                                        ##  See \ref rmw_qos_durability_policy_from_str() for more details.
                                        ##

proc rmw_qos_reliability_policy_from_str*(str: cstring): rmw_qos_reliability_policy_t {.
    importc: "rmw_qos_reliability_policy_from_str",
    header: "qos_string_conversions.h".}
  ##  Return a enum value based on the provided string.
                                        ##
                                        ##  See \ref rmw_qos_durability_policy_from_str() for more details.
                                        ## 