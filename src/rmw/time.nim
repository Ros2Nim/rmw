##  Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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
  rcutils/time, rcutils/macros, rcutils/macros, rcutils/macros, rcutils/macros,
  rcutils/macros, rcutils/time, rcutils/types, rcutils/types/array_list,
  rcutils/types/array_list, rcutils/allocator, rcutils/allocator,
  rcutils/allocator, rcutils/types/rcutils_ret, rcutils/allocator,
  rcutils/visibility_control, rcutils/visibility_control_macros,
  rcutils/visibility_control_macros, rcutils/visibility_control,
  rcutils/allocator, rcutils/types/array_list, rcutils/types,
  rcutils/types/char_array, rcutils/types/char_array, rcutils/types,
  rcutils/types/hash_map, rcutils/types/hash_map, rcutils/types,
  rcutils/types/string_array, rcutils/types/string_array,
  rcutils/error_handling, rcutils/error_handling, rcutils/error_handling,
  rcutils/error_handling, rcutils/error_handling, rcutils/error_handling,
  rcutils/snprintf, rcutils/snprintf, rcutils/error_handling,
  rcutils/testing/fault_injection, rcutils/testing/fault_injection,
  rcutils/testing/fault_injection, rcutils/error_handling,
  rcutils/error_handling, rcutils/error_handling, rcutils/error_handling,
  rcutils/types/string_array, rcutils/qsort, rcutils/qsort,
  rcutils/types/string_array, rcutils/types, rcutils/types/string_map,
  rcutils/types/string_map, rcutils/types, rcutils/types/uint8_array,
  rcutils/types/uint8_array, rcutils/types, rcutils/time, ./macros,
  ./visibility_control, ./visibility_control

type

  rmw_time_t* {.importc: "rmw_time_t", header: "time.h", bycopy.} = object ##
                              ##  A struct representing a duration or relative time in RMW - does not encode an origin.
    sec* {.importc: "sec".}: uint64 ##  Seconds component
    nsec* {.importc: "nsec".}: uint64 ##  Nanoseconds component


  rmw_time_point_value_t* = rcutils_time_point_value_t

  rmw_duration_t* = rcutils_duration_value_t

const
  RMW_DURATION_INFINITE* = (9223372036'i64, 854775807'i64) ##
                              ##  Constant representing an infinite duration. Use rmw_time_equal for comparisons.
                              ##
                              ##  Different RMW implementations have different representations for infinite durations.
                              ##  This value is reported for QoS policy durations that are left unspecified.
                              ##  Do not directly compare `sec == sec && nsec == nsec`, because we don't want to be sensitive
                              ##  to non-normalized values (nsec > 1 second) - use rmw_time_equal instead.
                              ##  This value is INT64_MAX nanoseconds = 0x7FFF FFFF FFFF FFFF = d 9 223 372 036 854 775 807
                              ##
                              ##  Note: these constants cannot be `static const rmw_time_t` because in C that can't be used
                              ##  as a compile-time initializer
                              ##
  RMW_DURATION_UNSPECIFIED* = (0'i64, 0'i64)


proc rmw_time_equal*(left: rmw_time_t; right: rmw_time_t): _Bool {.
    importc: "rmw_time_equal", header: "time.h".}
  ##  Check whether two rmw_time_t represent the same time.

proc rmw_time_total_nsec*(time: rmw_time_t): rmw_duration_t {.
    importc: "rmw_time_total_nsec", header: "time.h".}
  ##
                              ##  Return the total nanosecond representation of a time.
                              ##
                              ##  \return INT64_MAX if input is too large to store in 64 bits
                              ##

proc rmw_time_from_nsec*(nanoseconds: rmw_duration_t): rmw_time_t {.
    importc: "rmw_time_from_nsec", header: "time.h".}
  ##
                              ##  Construct rmw_time_t from a total nanoseconds representation.
                              ##
                              ##  rmw_time_t only specifies relative time, so the origin is not relevant for this calculation.
                              ##  \return RMW_DURATION_INFINITE if input is negative, which is not representable in rmw_time_t
                              ##

proc rmw_time_normalize*(time: rmw_time_t): rmw_time_t {.
    importc: "rmw_time_normalize", header: "time.h".}
  ##
                              ##  Ensure that an rmw_time_t does not have nanoseconds > 1 second.