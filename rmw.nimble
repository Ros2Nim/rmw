# Package

version       = "0.2.1"
author        = "Jaremy Creechley"
description   = "Nim wrapper for ROS2 RMW"
license       = "MIT"
srcDir        = "src"
skipDirs      = @["deps"]

# Dependencies

requires "nim >= 1.6.0"
requires "https://github.com/Ros2Nim/rcutils.git"
requires "https://github.com/Ros2Nim/rosidl.git"
