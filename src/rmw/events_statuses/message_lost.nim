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

  rmw_message_lost_status_t* {.importc: "rmw_message_lost_status_t",
                               header: "message_lost.h", bycopy.} = object
    total_count* {.importc: "total_count".}: csize_t ##
                              ##  Total number of messages lost.
    total_count_change* {.importc: "total_count_change".}: csize_t ##
                              ##  Number of messages lost since last callback.


