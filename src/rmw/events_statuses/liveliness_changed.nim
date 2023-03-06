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

  rmw_liveliness_changed_status_t* {.importc: "rmw_liveliness_changed_status_t",
                                     header: "liveliness_changed.h", bycopy.} = object ##
                              ##  QoS Liveliness Changed information provided by a subscription.
    alive_count* {.importc: "alive_count".}: int32 ##
                              ##
                              ##  The total number of currently active Publishers which publish to the topic associated with
                              ##  the Subscription.
                              ##  This count increases when a newly matched Publisher asserts its liveliness for the first time
                              ##  or when a Publisher previously considered to be not alive reasserts its liveliness.
                              ##  The count decreases when a Publisher considered alive fails to assert its liveliness and
                              ##  becomes not alive, whether because it was deleted normally or for some other reason.
                              ##
    not_alive_count* {.importc: "not_alive_count".}: int32 ##
                              ##
                              ##  The total count of current Publishers which publish to the topic associated with the
                              ##  Subscription that are no longer asserting their liveliness.
                              ##  This count increases when a Publisher considered alive fails to assert its liveliness and
                              ##  becomes not alive for some reason other than the normal deletion of that Publisher.
                              ##  It decreases when a previously not alive Publisher either reasserts its liveliness or is
                              ##  deleted normally.
                              ##
    alive_count_change* {.importc: "alive_count_change".}: int32 ##
                              ##  The change in the alive_count since the status was last read.
    not_alive_count_change* {.importc: "not_alive_count_change".}: int32 ##
                              ##  The change in the not_alive_count since the status was last read.

