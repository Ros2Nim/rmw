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

  rmw_offered_deadline_missed_status_t* {.
      importc: "rmw_offered_deadline_missed_status_t",
      header: "offered_deadline_missed.h", bycopy.} = object ##
                              ##  QoS Deadline Missed information provided by a publisher.
    total_count* {.importc: "total_count".}: int32 ##
                              ##
                              ##  Lifetime cumulative number of offered deadline periods elapsed during which a Publisher failed
                              ##  to provide data.
                              ##  Missed deadlines accumulate; that is, each deadline period the total_count will be incremented
                              ##  by one.
                              ##
    total_count_change* {.importc: "total_count_change".}: int32 ##
                              ##  The change in total_count since the last time the status was last read.


