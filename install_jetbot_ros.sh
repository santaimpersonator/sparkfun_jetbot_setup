#!/bin/bash

# Created by SparkFun Electronics June 2021
# Author: Wes Furuya
#  
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY without even the implied warrranty of
# MERCHANABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
# GNU General Public License for more details.
#
# You should have reciede a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/license>
#
#==================================================================================
# Copyright (c) 2021 SparkFun Electronics
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#==================================================================================
#==================================================================================


# Install Jetbot ROS: https://github.com/dusty-nv/jetbot_ros
#==================================================================================
echo -e "\e[1;32mInstall Jetbot ROS\e[0m"

# Install ROS Melodic
#----------------------------------------------------------------------------------
echo -e "\e[1;33m- Install Jetbot ROS Melodic\e[0m"

# enable all Ubuntu packages:
sudo apt-add-repository universe
sudo apt-add-repository multiverse
sudo apt-add-repository restricted

# add ROS repository to apt sources
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# install ROS Base
sudo apt-get update
sudo apt-get install -y ros-melodic-ros-base

# add ROS paths to environment
sudo sh -c 'echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc'



######### Close and restart the terminal.

# Install Adafruit Libraries
#----------------------------------------------------------------------------------
# These Python libraries from Adafruit support the TB6612/PCA9685 motor drivers and the SSD1306 debug OLED:

# pip should be installed
sudo apt-get install python3-pip

# Grant your user access to the i2c bus:
sudo usermod -aG i2c $USER

# install Adafruit libraries
sudo pip3 install -U Adafruit-MotorHAT
sudo pip3 install -U Adafruit-SSD1306

# Install SparkFun Qwiic Package
sudo pip3 install -U sparkfun-qwiic


################# Reboot the system for the changes to take effect.


# Create catkin workspace
#----------------------------------------------------------------------------------
# Create a ROS Catkin workspace to contain our ROS packages:
echo -e "\e[1;33m- Create a ROS Catkin Workspace\e[0m"


# create the catkin workspace
mkdir -p ~/workspace/catkin_ws/src
cd ~/workspace/catkin_ws
catkin_make

# add catkin_ws path to bashrc
sudo sh -c 'echo "source ~/workspace/catkin_ws/devel/setup.bash" >> ~/.bashrc'

# *Note: out of personal preference, my catkin_ws is created as a subdirectory under ~/workspace




########## Close and open a new terminal window. Verify that your catkin_ws is visible to ROS:




echo $ROS_PACKAGE_PATH 
/home/nvidia/workspace/catkin_ws/src:/opt/ros/melodic/share



# Build jetson-inference
#----------------------------------------------------------------------------------
# Clone and build the jetson-inference repo:
echo -e "\e[1;33m- Install and Build jetson-inference\e[0m"

# git and cmake should be installed
sudo apt-get install -y git cmake

# clone the repo and submodules
cd ~/workspace
git clone https://github.com/dusty-nv/jetson-inference
cd jetson-inference
git submodule update --init

# build from source
mkdir build
cd build
cmake ../
make

# install libraries
sudo make install



# Build ros_deep_learning
#----------------------------------------------------------------------------------
# Clone and build the ros_deep_learning repo:
echo -e "\e[1;33m- Install and Build ros_deep_learning\e[0m"

# install dependencies
sudo apt-get install -y ros-melodic-vision-msgs ros-melodic-image-transport ros-melodic-image-publisher

# clone the repo
cd ~/workspace/catkin_ws/src
git clone https://github.com/dusty-nv/ros_deep_learning

# make ros_deep_learning
cd ../    # cd ~/workspace/catkin_ws
catkin_make

# confirm that the package can be found
rospack find ros_deep_learning
/home/nvidia/workspace/catkin_ws/src/ros_deep_learning



# Build jetbot_ros
#----------------------------------------------------------------------------------
# Clone and build the jetbot_ros repo:
echo -e "\e[1;33m- Install and Build jetbot_ros\e[0m"

# clone the repo
cd ~/workspace/catkin_ws/src
git clone https://github.com/sparkfun/jetbot_ros
# git clone -b update-hardware_scan https://github.com/sparkfun/jetbot_ros

# build the package
cd ../    # cd ~/workspace/catkin_ws
catkin_make

# confirm that jetbot_ros package can be found
rospack find jetbot_ros
#/home/nvidia/workspace/catkin_ws/src/jetbot_ros