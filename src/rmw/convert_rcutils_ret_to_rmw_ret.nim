##  Copyright 2017 Open Source Robotics Foundation, Inc.
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
  rcutils/types/array_list, rcutils/allocator, rcutils/macros,
  rcutils/types/rcutils_ret, rcutils/visibility_control_macros,
  rcutils/types/char_array, rcutils/types/hash_map, rcutils/types/string_array,
  rcutils/error_handling, rcutils/snprintf, rcutils/testing/fault_injection,
  rcutils/qsort, rcutils/types/string_map, rcutils/types/uint8_array, ./types,
  rcutils/logging, ./events_statuses/events_statuses,
  ./events_statuses/incompatible_qos, ./qos_policy_kind,
  ./events_statuses/liveliness_changed, ./events_statuses/liveliness_lost,
  ./events_statuses/message_lost, ./events_statuses/offered_deadline_missed,
  ./events_statuses/requested_deadline_missed, ./init, ./init_options,
  ./domain_id, ./localhost, ./ret_types, ./security_options,
  ./serialized_message, ./subscription_content_filter_options, ./time


proc rmw_convert_rcutils_ret_to_rmw_ret*(rcutils_ret: rcutils_ret_t): rmw_ret_t {.
    importc: "rmw_convert_rcutils_ret_to_rmw_ret",
    header: "convert_rcutils_ret_to_rmw_ret.h".}
  ##  Map a `rcutil_ret_t` value to the equivalent `rmw_ret_t` value
                                                ##
                                                ##  \param[in] rcutils_ret The rcutils type to map
                                                ##  \return rmw_ret_t result mapped value, or RMW_RET_ERROR if the rcutils_ret value is not supported
                                                ## 