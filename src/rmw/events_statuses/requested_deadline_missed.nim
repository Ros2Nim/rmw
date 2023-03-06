##  #pragma c2nim mangle "'rosidl_runtime_c__' {\\w+}" "$1"
##  #pragma c2nim mangle "'namespace_'" "namespace"
##  #pragma c2nim mangle "'rmw_time_s'" "rmw_time_t"

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

type

  rmw_requested_deadline_missed_status_t* {.
      importc: "rmw_requested_deadline_missed_status_t",
      header: "requested_deadline_missed.h", bycopy.} = object ##
                              ##  QoS Requested Deadline Missed information provided by a subscription.
    total_count* {.importc: "total_count".}: int32 ##
                              ##
                              ##  Lifetime cumulative number of missed deadlines detected for any instance read by the
                              ##  subscription.
                              ##  Missed deadlines accumulate; that is, each deadline period the total_count will be incremented
                              ##  by one for each instance for which data was not received.
                              ##
    total_count_change* {.importc: "total_count_change".}: int32 ##
                              ##  The incremental number of deadlines detected since the status was read.

