##  Copyright 2016-2017 Open Source Robotics Foundation, Inc.
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


proc rmw_check_zero_rmw_string_array*(array: ptr rcutils_string_array_t): rmw_ret_t {.
    importc: "rmw_check_zero_rmw_string_array", header: "sanity_checks.h".}
  ##
                              ##  Check that a string_array struct is zero initialized
                              ##
                              ##  This sets error message and returns error code if array is not zero initialized
                              ##
                              ##  \param[in] array The string array to check
                              ##  \return RMW_RET_OK if array is zero initialized, otherwise RMW_RET_ERROR
                              ## 