##  Copyright 2022 Open Source Robotics Foundation, Inc.
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
  rcutils/allocator, rcutils/macros, rcutils/types/rcutils_ret,
  rcutils/visibility_control_macros, ./types, rcutils/logging,
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


type ##  `rmw_message_info_t.publication_sequence_number` is filled correctly
      ##  by the rmw implementation.

  rmw_feature_t* {.size: sizeof(cint).} = enum ##  List of optional rmw features.
                                                ##
                                                ##  Some of the features listed here might become mandatory in the feature, in which case all rmw
                                                ##  implementations should return `true`.
                                                ##
                                                ##  There might be some optional features that are not listed here, but the goal is to have all of
                                                ##  them added.
                                                ##
    RMW_FEATURE_MESSAGE_INFO_PUBLICATION_SEQUENCE_NUMBER = 0, ##
                              ##  `rmw_message_info_t.reception_sequence_number` is filled correctly
                              ##  by the rmw implementation.
    RMW_FEATURE_MESSAGE_INFO_RECEPTION_SEQUENCE_NUMBER = 1



proc rmw_feature_supported*(feature: rmw_feature_t): bool {.
    importc: "rmw_feature_supported", header: "features.h".}
  ##
                              ##  Query if a feature is supported by the rmw implementation.
                              ##
                              ##  \return `true` if the rmw implementation supports the feature, `false` if not.
                              ## 