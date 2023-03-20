# Package

version       = "0.1.0"
author        = "Jaremy Creechley"
description   = "Nim wrapper for ROS2 RMW"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["rmw"]


# Dependencies

requires "nim >= 1.6.10"
requires "https://github.com/Ros2Nim/rcutils.git >= 0.2.0"
requires "https://github.com/Ros2Nim/rosidl.git"
requires "https://github.com/Ros2Nim/rosidl_runtime_c.git"
