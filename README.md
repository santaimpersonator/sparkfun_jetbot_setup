## Introduction
This repository contains shell scripts for the [SparkFun Jetbot Kit](). There are two primary scripts for configuring the `jetbot` software:

* Configures the Ubuntu OS on Jetson Nano, installs the necessary dependencies, and setup the [`jetbot` software]() to be utilized with the SparkFun Jetbot Kit.
    * Configuration script for the Python package version of the `jetbot` software
        * Jetbot version
        * Jetpack version
    * Configuration script for the `Docker` container version of the `jetbot` software
        * Jetbot version
        * Jetpack version

* []() - Used to create custom SD card image
    * Create an image of the OS as is
    * Create an image of the OS as is, with setup for `oem-config` tool enabled
    * Configures OS, sets up `jetbot` software creates an image of the OS as is, with setup for `oem-config` tool enabled
        * Meant to be used on a fresh/new OS

### Required Hardware

* Jetson Nano
    * *Compatible* SD Card
    * Power Supply
    * Jumper
    * Keyboard, Mouse, and Display

*To create a custom image:*
* Computer
    * Ubuntu OS
    * NVIDIA SDK Manager Installed
    * Hard Drive Space *(equivalent to the size of the SD Card in the Jetson Nano)*
* Micro-USB Cable

## Documentation
For additional details on the scripts in this repository, please refer to the [`DOCUMENTATION.md`]() file.

## Contents
* **`add-on_software`** - Additional software installation scripts
    * `install_aws_greengrass.sh` - Installs AWS Greengrass *(version 1.0)*
    * `install_edimax_driver.sh` - Install the drivers for the Edimax WiFi USB dongle
    * `install_jetbot_ros.sh` - Installs Jetbot ROS
* **`create_image`** - 
    * `enable_oem-config.sh` - 
* **`docker_container`** - Scripts used to build, run, and stop/disable the Docker containers
    * `build_run_docker_containers.sh` - 
    * `disable_docker_containers.sh` - 
* **`history_cleanup`** - Scripts used to erase user's history
    * `clear_bash_history.sh` - 
    * `clear_ipython_history.sh` - 
* **`jetbot_installation`** - Scripts used to setup and configure the `jetbot` software
    * `disable_remove_services.sh` - 
    * `download_models.sh` - 
    * `enable_services.sh` - 
    * `move_notebook.sh` - 
* **`os_configureation`** - OS configuration scripts
    * `disable_graphical_desktop.sh` - 
    * `disable_zram.sh` - 
    * `enable_graphical_desktop.sh` - 
    * `enable_swap.sh` - 
    * `set_power_profile_5W.sh` - 
    * `set_power_profile_max-n.sh` - 
    * `uninstall_libreoffice.sh` - 
* **`resize_partition`** - Disk partition resizing scripts
    * `install_resize_files.sh` - 
    * `nvresizefs.service` - 
    * `nvresizefs.sh` - 