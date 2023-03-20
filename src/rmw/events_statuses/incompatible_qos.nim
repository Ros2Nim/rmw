##  Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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
  ../qos_policy_kind


type

  rmw_qos_incompatible_event_status_t* {.
      importc: "rmw_qos_incompatible_event_status_t",
      header: "incompatible_qos.h", bycopy.} = object
    total_count* {.importc: "total_count".}: int32 ##
                              ##
                              ##  Total cumulative number of times the concerned subscription discovered a
                              ##  publisher for the same topic with an offered QoS that was incompatible
                              ##  with that requested by the subscription.
                              ##
    total_count_change* {.importc: "total_count_change".}: int32 ##
                              ##
                              ##  The change in total_count since the last time the status was read.
                              ##
    last_policy_kind* {.importc: "last_policy_kind".}: rmw_qos_policy_kind_t ##
                              ##
                              ##  The Qos Policy Kind of one of the policies that was found to be
                              ##  incompatible the last time an incompatibility was detected.
                              ##


  rmw_requested_qos_incompatible_event_status_t* = rmw_qos_incompatible_event_status_t ##
                              ##  Event state for a subscription's 'RMW_EVENT_REQUESTED_QOS_INCOMPATIBLE' events.

  rmw_offered_qos_incompatible_event_status_t* = rmw_qos_incompatible_event_status_t ##
                              ##  Event state for a publisher's 'RMW_EVENT_OFFERED_QOS_INCOMPATIBLE' events.

