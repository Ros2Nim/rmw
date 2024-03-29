##  Copyright 2014-2018 Open Source Robotics Foundation, Inc.
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

const
  RMW_RET_OK* = 0            ##  The operation ran as expected
  RMW_RET_ERROR* = 1         ##  Generic error to indicate operation could not complete successfully
  RMW_RET_TIMEOUT* = 2       ##  The operation was halted early because it exceeded its timeout critera
  RMW_RET_UNSUPPORTED* = 3   ##  The operation or event handling is not supported.
  RMW_RET_BAD_ALLOC* = 10    ##  Failed to allocate memory
  RMW_RET_INVALID_ARGUMENT* = 11 ##  Argument to function was invalid
  RMW_RET_INCORRECT_RMW_IMPLEMENTATION* = 12 ##  Incorrect rmw implementation.
  RMW_RET_NODE_NAME_NON_EXISTENT* = 203 ##  rmw node specific ret codes in 2XX
                                        ##  Failed to find node name
                                        ##  Using same return code than in rcl

type

  rmw_ret_t* = int32         ##  Return code for rmw functions

