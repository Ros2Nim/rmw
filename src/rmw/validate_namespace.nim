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
  ./serialized_message, ./subscription_content_filter_options, ./time,
  ./validate_full_topic_name


proc rmw_validate_namespace*(namespace: cstring; validation_result: ptr cint;
                             invalid_index: ptr csize_t): rmw_ret_t {.
    importc: "rmw_validate_namespace", header: "validate_namespace.h".}
  ##
                              ##  Determine if a given namespace is valid.
                              ##  Validity of a namespace is based on rules for a topic defined here:
                              ##
                              ##    http://design.ros2.org/articles/topic_and_service_names.html
                              ##
                              ##  Note that this function expects that there are no URL suffixes as described
                              ##  in the above document which can be used for topics and services.
                              ##
                              ##  If either the C string or validation_result pointer are null, then
                              ##  `RMW_RET_INVALID_ARGUMENT` will be returned.
                              ##  The namespace_ should be a valid, null-terminated C string.
                              ##  The validation_result int pointer should point to valid memory so a result
                              ##  can be stored in it as an output variable.
                              ##  The invalid_index size_t pointer should either point NULL or to valid memory
                              ##  so in the event of a validation error, the location in the input string can
                              ##  be stored therein.
                              ##  If NULL is passed in for invalid_index, it will be not be set.
                              ##
                              ##  The invalid_index will not be assigned a value if the namespace is valid.
                              ##
                              ##  The int which validation_result points to will have a one of a few possible
                              ##  results values (defined with macros) stored into it:
                              ##
                              ##  - RMW_NAMESPACE_VALID
                              ##  - RMW_NAMESPACE_INVALID_IS_EMPTY_STRING
                              ##  - RMW_NAMESPACE_INVALID_NOT_ABSOLUTE
                              ##  - RMW_NAMESPACE_INVALID_ENDS_WITH_FORWARD_SLASH
                              ##  - RMW_NAMESPACE_INVALID_CONTAINS_UNALLOWED_CHARACTERS
                              ##  - RMW_NAMESPACE_INVALID_CONTAINS_REPEATED_FORWARD_SLASH
                              ##  - RMW_NAMESPACE_INVALID_NAME_TOKEN_STARTS_WITH_NUMBER
                              ##  - RMW_NAMESPACE_INVALID_TOO_LONG
                              ##
                              ##  The result value can be converted to a description with the
                              ##  rmw_namespace_validation_result_string() function.
                              ##
                              ##  The ``RMW_NAMESPACE_INVALID_ENDS_WITH_FORWARD_SLASH`` validation result does
                              ##  not apply to ``"/"``, which is a valid namespace.
                              ##
                              ##  The ``RMW_NAMESPACE_INVALID_TOO_LONG`` is guaranteed to be checked last,
                              ##  such that if you get that result, then you can assume all other checks
                              ##  succeeded.
                              ##  This is done so that the length limit can be treated as a warning rather
                              ##  than an error if desired.
                              ##
                              ##  If a non RMW_RET_OK return value is returned, the RMW error message will be set
                              ##
                              ##  \param[in] namespace_ namespace to be validated
                              ##  \param[out] validation_result int in which the result of the check is stored
                              ##  \param[out] invalid_index index of the input string where an error occurred
                              ##  \returns `RMW_RET_OK` on successfully running the check, or
                              ##  \returns `RMW_RET_INVALID_ARGUMENT` on invalid parameters, or
                              ##  \returns `RMW_RET_ERROR` when an unspecified error occurs.
                              ##

proc rmw_validate_namespace_with_size*(namespace: cstring;
                                       namespace_length: csize_t;
                                       validation_result: ptr cint;
                                       invalid_index: ptr csize_t): rmw_ret_t {.
    importc: "rmw_validate_namespace_with_size", header: "validate_namespace.h".}
  ##
                              ##  Deterimine if a given namespace is valid.
                              ##
                              ##  This is an overload with an extra parameter for the length of namespace_.
                              ##  If a non RMW_RET_OK return value is returned, the RMW error message will be set.
                              ##
                              ##  \sa rmw_validate_namespace(const char *, int *, size_t *)
                              ##
                              ##  \param[in] namespace_ namespace to be validated
                              ##  \param[in] namespace_length The number of characters in namespace_.
                              ##  \param[out] validation_result int in which the result of the check is stored
                              ##  \param[out] invalid_index index of the input string where an error occurred
                              ##  \returns `RMW_RET_OK` on successfully running the check, or
                              ##  \returns `RMW_RET_INVALID_ARGUMENT` on invalid parameters, or
                              ##  \returns `RMW_RET_ERROR` when an unspecified error occurs.
                              ##

proc rmw_namespace_validation_result_string*(validation_result: cint): cstring {.
    importc: "rmw_namespace_validation_result_string",
    header: "validate_namespace.h".}
  ##  Return a validation result description, or NULL if RMW_NAMESPACE_VALID.
                                    ##
                                    ##  \param[in] validation_result the result of validation
                                    ##  \returns `NULL` if the validation result is `RMW_NAMESPACE_VALID`, or
                                    ##  \returns a string representing the validation result.
                                    ## 