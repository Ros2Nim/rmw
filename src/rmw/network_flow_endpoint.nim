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
  ./types, rcutils/logging, rcutils/allocator, rcutils/macros,
  rcutils/types/rcutils_ret, rcutils/visibility_control_macros,
  rcutils/error_handling, rcutils/snprintf, rcutils/testing/fault_injection,
  rcutils/types/array_list, rcutils/types/char_array, rcutils/types/hash_map,
  rcutils/types/string_array, rcutils/qsort, rcutils/types/string_map,
  rcutils/types/uint8_array, ./events_statuses/events_statuses,
  ./events_statuses/incompatible_qos, ./qos_policy_kind,
  ./events_statuses/liveliness_changed, ./events_statuses/liveliness_lost,
  ./events_statuses/message_lost, ./events_statuses/offered_deadline_missed,
  ./events_statuses/requested_deadline_missed, ./init, ./init_options,
  ./domain_id, ./localhost, ./ret_types, ./security_options,
  ./serialized_message, ./subscription_content_filter_options, ./time

const
  RMW_INET_ADDRSTRLEN* = 48 ##  Maximum length of internet address string including terminating null
                            ##  Inspired from linux/inet.h

type

  rmw_transport_protocol_t* {.size: sizeof(cint).} = enum ##
                              ##  Transport protocol types
    RMW_TRANSPORT_PROTOCOL_UNKNOWN = 0, RMW_TRANSPORT_PROTOCOL_UDP,
    RMW_TRANSPORT_PROTOCOL_TCP, RMW_TRANSPORT_PROTOCOL_COUNT

  rmw_internet_protocol_t* {.size: sizeof(cint).} = enum ##
                              ##  Internet protocol types
    RMW_INTERNET_PROTOCOL_UNKNOWN = 0, RMW_INTERNET_PROTOCOL_IPV4,
    RMW_INTERNET_PROTOCOL_IPV6, RMW_INTERNET_PROTOCOL_COUNT

  rmw_network_flow_endpoint_t* {.importc: "rmw_network_flow_endpoint_t",
                                 header: "network_flow_endpoint.h", bycopy.} = object ##
                              ##  Structure that describes network flow endpoint of a publisher or subscription
    transport_protocol* {.importc: "transport_protocol".}: rmw_transport_protocol_t ##
                              ##  Transport protocol
    internet_protocol* {.importc: "internet_protocol".}: rmw_internet_protocol_t ##
                              ##  Internet protocol
    transport_port* {.importc: "transport_port".}: uint16 ##
                              ##  Port
    flow_label* {.importc: "flow_label".}: uint32 ##  Flow label
                                                  ##  TODO(anamud): Consider specializing since flow_label is set only at publisher
                                                  ##  ... side.
    dscp* {.importc: "dscp".}: uint8 ##  DSCP (Diff. Services Code Point)
                                     ##  TODO(anamud): Consider specializing since DSCP is set only at publisher
                                     ##  ... side.
    internet_address* {.importc: "internet_address".}: array[48, char] ##
                              ##  Internet address




proc rmw_get_zero_initialized_network_flow_endpoint*(): rmw_network_flow_endpoint_t {.
    importc: "rmw_get_zero_initialized_network_flow_endpoint",
    header: "network_flow_endpoint.h".}
  ##  Return a rmw_network_flow_endpoint_t struct with zero-initialized members

proc rmw_network_flow_endpoint_get_transport_protocol_string*(
    transport_protocol: rmw_transport_protocol_t): cstring {.
    importc: "rmw_network_flow_endpoint_get_transport_protocol_string",
    header: "network_flow_endpoint.h".}
  ##  Convert to string variant of transport protocol
                                       ##
                                       ##  \param[in] transport_protocol transport_protocol_t to be converted
                                       ##

proc rmw_network_flow_endpoint_get_internet_protocol_string*(
    internet_protocol: rmw_internet_protocol_t): cstring {.
    importc: "rmw_network_flow_endpoint_get_internet_protocol_string",
    header: "network_flow_endpoint.h".}
  ##  Convert to string variant of internet protocol
                                       ##
                                       ##  \param[in] internet_protocol internet_protocol_t to be converted
                                       ##

proc rmw_network_flow_endpoint_set_internet_address*(
    network_flow_endpoint: ptr rmw_network_flow_endpoint_t;
    internet_address: cstring; size: csize_t): rmw_ret_t {.
    importc: "rmw_network_flow_endpoint_set_internet_address",
    header: "network_flow_endpoint.h".}
  ##  Set internet address in the rmw_network_flow_endpoint_t struct
                                       ##
                                       ##  \param[in] network_flow_endpoint network_flow_endpoint_t to be initialized
                                       ##  \param[in] internet_address the internet address as C-style string
                                       ##  \param[in] size size of internet_address excluding terminating null
                                       ##  \returns `RMW_RET_OK` on successfull initilization, or
                                       ##  \returns `RMW_RET_INVALID_ARGUMENT` if `network_flow_endpoint` is NULL, or
                                       ##  \returns `RMW_RET_INVALID_ARGUMENT` if `internet_address` is NULL, or
                                       ##  \returns `RMW_RET_INVALID_ARGUMENT` if `size` is not less than RMW_INET_ADDRSTRLEN, or
                                       ##  \returns `RMW_RET_ERROR` when an unspecified error occurs.
                                       ## 