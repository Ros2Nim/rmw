##  Copyright 2021 Open Source Robotics Foundation, Inc.
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
  rcutils/visibility_control_macros, rcutils/types/array_list,
  rcutils/types/char_array, rcutils/types/hash_map, rcutils/types/string_array,
  rcutils/error_handling, rcutils/snprintf, rcutils/testing/fault_injection,
  rcutils/qsort, rcutils/types/string_map, rcutils/types/uint8_array,
  ./ret_types


type

  rmw_subscription_content_filter_options_t* {.
      importc: "rmw_subscription_content_filter_options_t",
      header: "subscription_content_filter_options.h", bycopy.} = object
    filter_expression* {.importc: "filter_expression".}: cstring ##
                              ##
                              ##  Specify the criteria to select the data samples of interest.
                              ##
                              ##  It is similar to the WHERE part of an SQL clause.
                              ##
    expression_parameters* {.importc: "expression_parameters".}: rcutils_string_array_t ##
                              ##
                              ##  Give values to the tokens placeholder ‘parameters’ (i.e., "%n" tokens begin from 0) in the
                              ##  filter_expression. The number of supplied parameters must fit with the requested values.
                              ##
                              ##  It can be NULL if there is no "%n" tokens placeholder in filter_expression.
                              ##  The maximum index number must be smaller than 100.
                              ##




proc rmw_get_zero_initialized_content_filter_options*(): rmw_subscription_content_filter_options_t {.
    importc: "rmw_get_zero_initialized_content_filter_options",
    header: "subscription_content_filter_options.h".}
  ##
                              ##  Get zero initialized content filter options.

proc rmw_subscription_content_filter_options_init*(filter_expression: cstring;
    expression_parameters_argc: csize_t; expression_parameter_argv: ptr cstring;
    allocator: ptr rcutils_allocator_t;
    options: ptr rmw_subscription_content_filter_options_t): rmw_ret_t {.
    importc: "rmw_subscription_content_filter_options_init",
    header: "subscription_content_filter_options.h".}
  ##
                              ##  Initialize the given content filter options.
                              ##
                              ##  \param[in] filter_expression The filter expression.
                              ##  \param[in] expression_parameters_argc The expression parameters argc.
                              ##  \param[in] expression_parameter_argv The expression parameters argv.
                              ##  \param[in] allocator The allocator used when copying data to the content filter options.
                              ##  \param[out] options The content filter options to be set.
                              ##  \returns RMW_RET_INVALID_ARGUMENT, or
                              ##  \returns RMW_RET_BAD_ALLOC, or
                              ##  \returns RMW_RET_OK
                              ##

proc rmw_subscription_content_filter_options_set*(filter_expression: cstring;
    expression_parameters_argc: csize_t; expression_parameter_argv: ptr cstring;
    allocator: ptr rcutils_allocator_t;
    options: ptr rmw_subscription_content_filter_options_t): rmw_ret_t {.
    importc: "rmw_subscription_content_filter_options_set",
    header: "subscription_content_filter_options.h".}
  ##
                              ##  Set the given content filter options.
                              ##
                              ##  \param[in] filter_expression The filter expression.
                              ##  \param[in] expression_parameters_argc The expression parameters argc.
                              ##  \param[in] expression_parameter_argv The expression parameters argv.
                              ##  \param[in] allocator The allocator used when copying data to the content filter options.
                              ##  \param[out] options The content filter options to be set.
                              ##  \returns RMW_RET_INVALID_ARGUMENT, or
                              ##  \returns RMW_RET_BAD_ALLOC, or
                              ##  \returns RMW_RET_OK
                              ##

proc rmw_subscription_content_filter_options_copy*(
    src: ptr rmw_subscription_content_filter_options_t;
    allocator: ptr rcutils_allocator_t;
    dst: ptr rmw_subscription_content_filter_options_t): rmw_ret_t {.
    importc: "rmw_subscription_content_filter_options_copy",
    header: "subscription_content_filter_options.h".}
  ##
                              ##  Copy the given content filter options.
                              ##
                              ##  \param[in] src content filter options to be copied.
                              ##  \param[in] allocator allocator used when copying data to the new content filter options.
                              ##  \param[out] dst content filter options to be set.
                              ##  \returns RMW_RET_INVALID_ARGUMENT, or
                              ##  \returns RMW_RET_BAD_ALLOC, or
                              ##  \returns RMW_RET_OK
                              ##

proc rmw_subscription_content_filter_options_fini*(
    options: ptr rmw_subscription_content_filter_options_t;
    allocator: ptr rcutils_allocator_t): rmw_ret_t {.
    importc: "rmw_subscription_content_filter_options_fini",
    header: "subscription_content_filter_options.h".}
  ##
                              ##  Finalize the content filter options.
                              ##
                              ##  \param[in] options content filter options to be finalized.
                              ##  \param[in] allocator allocator used to deallocate the content filter options.
                              ##  \returns RMW_RET_INVALID_ARGUMENT, or
                              ##  \returns RMW_RET_ERROR, or
                              ##  \returns RMW_RET_OK
                              ## 