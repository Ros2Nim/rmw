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
  rcutils/macros, ./types, rcutils/logging, rcutils/allocator,
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


type

  rmw_message_sequence_t* {.importc: "rmw_message_sequence_t",
                            header: "message_sequence.h", bycopy.} = object ##
                              ##  Structure to hold a sequence of ROS messages.
    data* {.importc: "data".}: ptr pointer ##  Array of pointers to ROS messages.
    size* {.importc: "size".}: csize_t ##  The number of valid entries in `data`.
    capacity* {.importc: "capacity".}: csize_t ##  The total allocated capacity of the data array.
    allocator* {.importc: "allocator".}: ptr rcutils_allocator_t ##
                              ##  The allocator used to allocate the data array.


  rmw_message_info_sequence_t* {.importc: "rmw_message_info_sequence_t",
                                 header: "message_sequence.h", bycopy.} = object ##
                              ##  Structure to hold a sequence of message infos.
    data* {.importc: "data".}: ptr rmw_message_info_t ##
                              ##  Array of message info.
    size* {.importc: "size".}: csize_t ##  The number of valid entries in data.
    capacity* {.importc: "capacity".}: csize_t ##  The total allocated capacity of the data array.
    allocator* {.importc: "allocator".}: ptr rcutils_allocator_t ##
                              ##  The allocator used to allocate the data array.




proc rmw_get_zero_initialized_message_sequence*(): rmw_message_sequence_t {.
    importc: "rmw_get_zero_initialized_message_sequence",
    header: "message_sequence.h".}
  ##  Return an rmw_message_sequence_t struct with members initialized to `NULL`

proc rmw_message_sequence_init*(sequence: ptr rmw_message_sequence_t;
                                size: csize_t;
                                allocator: ptr rcutils_allocator_t): rmw_ret_t {.
    importc: "rmw_message_sequence_init", header: "message_sequence.h".}
  ##
                              ##  Initialize an rmw_message_sequence_t object.
                              ##
                              ##  \param[inout] sequence sequence object to be initialized.
                              ##  \param[in] size capacity of the sequence to be allocated.
                              ##  \param[in] allocator the allcator used to allocate memory.
                              ##

proc rmw_message_sequence_fini*(sequence: ptr rmw_message_sequence_t): rmw_ret_t {.
    importc: "rmw_message_sequence_fini", header: "message_sequence.h".}
  ##
                              ##  Finalize an rmw_message_sequence_t object.
                              ##
                              ##  The rmw_message_sequence_t struct has members which require memory to be allocated to them
                              ##  before setting values.
                              ##  This function reclaims any allocated resources within the object and zeroes out all other
                              ##  members.
                              ##
                              ##  Note: This will not call `fini` or deallocate the underlying message structures.
                              ##
                              ##  \param[inout] sequence sequence object to be finalized.
                              ##

proc rmw_get_zero_initialized_message_info_sequence*(): rmw_message_info_sequence_t {.
    importc: "rmw_get_zero_initialized_message_info_sequence",
    header: "message_sequence.h".}
  ##  Return an rmw_message_info_sequence_t struct with members initialized to `NULL`

proc rmw_message_info_sequence_init*(sequence: ptr rmw_message_info_sequence_t;
                                     size: csize_t;
                                     allocator: ptr rcutils_allocator_t): rmw_ret_t {.
    importc: "rmw_message_info_sequence_init", header: "message_sequence.h".}
  ##
                              ##  Initialize an rmw_message_info_sequence_t object.
                              ##
                              ##  \param[inout] sequence sequence object to be initialized.
                              ##  \param[in] size capacity of the sequence to be allocated.
                              ##  \param[in] allocator the allcator used to allocate memory.
                              ##

proc rmw_message_info_sequence_fini*(sequence: ptr rmw_message_info_sequence_t): rmw_ret_t {.
    importc: "rmw_message_info_sequence_fini", header: "message_sequence.h".}
  ##
                              ##  Finalize an rmw_message_sequence_t object.
                              ##
                              ##  The rmw_message_sequence_t struct has members which require memory to be allocated to them
                              ##  before setting values.
                              ##  This function reclaims any allocated resources within the object and zeroes out all other
                              ##  members.
                              ##
                              ##  \param[inout] sequence sequence object to be finalized.
                              ## 