##  Copyright 2019 Open Source Robotics Foundation, Inc.
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
  rcutils/allocator, ./types, ./types, rcutils/logging, rcutils/logging,
  rcutils/logging, rcutils/error_handling, rcutils/error_handling,
  rcutils/error_handling, rcutils/error_handling, rcutils/error_handling,
  rcutils/error_handling, rcutils/snprintf, rcutils/snprintf,
  rcutils/error_handling, rcutils/testing/fault_injection,
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
  ./ret_types, ./init_options, ./security_options, ./security_options,
  ./init_options, ./init, ./types, ./serialized_message, ./types,
  ./subscription_content_filter_options, ./subscription_content_filter_options,
  ./types, ./time, ./time, ./types

##  Define publisher/subscription events


type                        ##  subscription events

  rmw_event_type_t* {.size: sizeof(cint).} = enum
    RMW_EVENT_LIVELINESS_CHANGED, RMW_EVENT_REQUESTED_DEADLINE_MISSED,
    RMW_EVENT_REQUESTED_QOS_INCOMPATIBLE, RMW_EVENT_MESSAGE_LOST, ##
                              ##  publisher events
    RMW_EVENT_LIVELINESS_LOST, RMW_EVENT_OFFERED_DEADLINE_MISSED, RMW_EVENT_OFFERED_QOS_INCOMPATIBLE, ##
                              ##  sentinel value
    RMW_EVENT_INVALID


type

  rmw_event_t* {.importc: "rmw_event_t", header: "event.h", bycopy.} = object
    implementation_identifier* {.importc: "implementation_identifier".}: cstring ##
                              ##  Implementation identifier, used to ensure two different implementations are not being mixed.
    data* {.importc: "data".}: pointer ##  Data specific to this event type from either the publisher or subscriber.
    event_type* {.importc: "event_type".}: rmw_event_type_t ##
                              ##  The event type that occurred.


##  Encapsulate the RMW event implementation, data, and type.


proc rmw_get_zero_initialized_event*(): rmw_event_t {.
    importc: "rmw_get_zero_initialized_event", header: "event.h".}
  ##
                              ##  Return a zero initialized event structure.

proc rmw_publisher_event_init*(rmw_event: ptr rmw_event_t;
                               publisher: ptr rmw_publisher_t;
                               event_type: rmw_event_type_t): rmw_ret_t {.
    importc: "rmw_publisher_event_init", header: "event.h".}
  ##
                              ##  Initialize a rmw publisher event.
                              ##
                              ##  \param[inout] rmw_event to initialize
                              ##  \param[in] publisher to initialize with
                              ##  \param[inout] event_type for the event to initialize
                              ##  \return `RMW_RET_OK` if successful, or
                              ##  \return `RMW_RET_INVALID_ARGUMENT` if invalid argument, or
                              ##  \return `RMW_RET_UNSUPPORTED` if event_type is not supported, or
                              ##  \return `RMW_RET_ERROR` if an unexpected error occurs.
                              ##

proc rmw_subscription_event_init*(rmw_event: ptr rmw_event_t;
                                  subscription: ptr rmw_subscription_t;
                                  event_type: rmw_event_type_t): rmw_ret_t {.
    importc: "rmw_subscription_event_init", header: "event.h".}
  ##
                              ##  Initialize a rmw subscription event.
                              ##
                              ##  \param[inout] rmw_event to initialize
                              ##  \param[in] subscription to initialize with
                              ##  \param[inout] event_type for the event to handle
                              ##  \return `RMW_RET_OK` if successful, or
                              ##  \return `RMW_RET_INVALID_ARGUMENT` if invalid argument, or
                              ##  \return `RMW_RET_UNSUPPORTED` if event_type is not supported, or
                              ##  \return `RMW_RET_ERROR` if an unexpected error occurs.
                              ##

proc rmw_take_event*(event_handle: ptr rmw_event_t; event_info: pointer;
                     taken: ptr bool): rmw_ret_t {.importc: "rmw_take_event",
    header: "event.h".}
  ##  Take an event from the event handle.
                       ##
                       ##  \param[in] event_handle event object to take from
                       ##  \param[inout] event_info event info object to write taken data into
                       ##  \param[out] taken boolean flag indicating if an event was taken or not
                       ##  \return `RMW_RET_OK` if successful, or
                       ##  \return `RMW_RET_BAD_ALLOC` if memory allocation failed, or
                       ##  \return `RMW_RET_ERROR` if an unexpected error occurs.
                       ##

proc rmw_event_fini*(event: ptr rmw_event_t): rmw_ret_t {.
    importc: "rmw_event_fini", header: "event.h".}
  ##  Finalize an rmw_event_t.
                                                  ##
                                                  ##  \param[in] event to finalize
                                                  ## 