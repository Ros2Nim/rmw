##  #pragma c2nim mangle "'rosidl_runtime_c__' {\\w+}" "$1"
##  #pragma c2nim mangle "'namespace_'" "namespace"
##  #pragma c2nim mangle "'rmw_time_s'" "rmw_time_t"

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
  ./network_flow_endpoint_array, rcutils/allocator, rcutils/allocator,
  rcutils/allocator, rcutils/macros, rcutils/macros, rcutils/macros,
  rcutils/macros, rcutils/macros, rcutils/allocator, rcutils/types/rcutils_ret,
  rcutils/allocator, rcutils/visibility_control_macros,
  rcutils/visibility_control_macros, rcutils/allocator,
  ./network_flow_endpoint_array, ./network_flow_endpoint, ./types, ./types,
  ./types, rcutils/logging, rcutils/logging, rcutils/logging,
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
  ./subscription_content_filter_options, ./types, ./time, ./time, ./types,
  ./network_flow_endpoint, ./network_flow_endpoint_array


proc rmw_publisher_get_network_flow_endpoints*(publisher: ptr rmw_publisher_t;
    allocator: ptr rcutils_allocator_t;
    network_flow_endpoint_array: ptr rmw_network_flow_endpoint_array_t): rmw_ret_t {.
    importc: "rmw_publisher_get_network_flow_endpoints",
    header: "get_network_flow_endpoints.h".}
  ##  Get network flow endpoints of a publisher
                                            ##
                                            ##  Query the underlying middleware for a given publisher's network flow endpoints
                                            ##
                                            ##  \param[in] publisher the publisher instance to inspect
                                            ##  \param[in] allocator allocator to be used when allocating space for network_flow_endpoint_array_t
                                            ##  \param[out] network_flow_endpoint_array the network flow endpoints
                                            ##  \return `RMW_RET_OK` if successful, or
                                            ##  \return `RMW_RET_INVALID_ARGUMENT` if any argument is null,
                                            ##  \return `RMW_RET_BAD_ALLOC` if memory allocation fails, or
                                            ##  \return `RMW_RET_UNSUPPORTED` if not supported, or
                                            ##  \return `RMW_RET_ERROR` if an unexpected error occurs.
                                            ##

proc rmw_subscription_get_network_flow_endpoints*(
    subscription: ptr rmw_subscription_t; allocator: ptr rcutils_allocator_t;
    network_flow_endpoint_array: ptr rmw_network_flow_endpoint_array_t): rmw_ret_t {.
    importc: "rmw_subscription_get_network_flow_endpoints",
    header: "get_network_flow_endpoints.h".}
  ##  Get network flow endpoints of a subscription
                                            ##
                                            ##  Query the underlying middleware for a given subscription's network flow endpoints
                                            ##
                                            ##  \param[in] subscription the subscription instance to inspect
                                            ##  \param[in] allocator allocator to be used when allocating space for network_flow_endpoint_array_t
                                            ##  \param[out] network_flow_endpoint_array the network flow endpoints
                                            ##  \return `RMW_RET_OK` if successful, or
                                            ##  \return `RMW_RET_INVALID_ARGUMENT` if any argument is null, or
                                            ##  \return `RMW_RET_BAD_ALLOC` if memory allocation fails, or
                                            ##  \return `RMW_RET_UNSUPPORTED` if not supported, or
                                            ##  \return `RMW_RET_ERROR` if an unexpected error occurs.
                                            ## 