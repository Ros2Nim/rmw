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
  RMW_RET_OK* = 0            ##  Return code for rmw functions
  RMW_RET_ERROR* = 1
  RMW_RET_TIMEOUT* = 2
  RMW_RET_UNSUPPORTED* = 3
  RMW_RET_BAD_ALLOC* = 10
  RMW_RET_INVALID_ARGUMENT* = 11
  RMW_RET_INCORRECT_RMW_IMPLEMENTATION* = 12
  RMW_RET_NODE_NAME_NON_EXISTENT* = 203

type

  rmw_ret_t* = int32

##  The operation ran as expected

##  Generic error to indicate operation could not complete successfully

##  The operation was halted early because it exceeded its timeout critera

##  The operation or event handling is not supported.

##  Failed to allocate memory

##  Argument to function was invalid

##  Incorrect rmw implementation.

##  rmw node specific ret codes in 2XX
##  Failed to find node name
##  Using same return code than in rcl
