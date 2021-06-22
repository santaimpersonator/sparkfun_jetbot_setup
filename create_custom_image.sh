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

# Clear Terminal
# clear
echo -e "\n\e[1;32mConfigure Custom Jetbot Image\e[0m"

# Remove Carriage Returns and Add Permissions
echo -e "\e[100mRun Partition Expansion Script\e[0m"
sed -i 's/\r$//' nvresizefs.sh
sudo bash nvresizefs.sh

# Remove carriage returns
sed -i 's/\r$//' install_edimax_driver.sh install_aws_greengrass.sh install_jetbot.sh install_jetbot_ros.sh

echo -e "\e[1;33m- Adding File Permissions\e[0m"
chmod +x install_edimax_driver.sh install_aws_greengrass.sh install_jetbot.sh install_jetbot_ros.sh

# Download Package Information
echo -e "\e[1;33m- Download Package Information\e[0m"
sudo apt-get update

# # Enable All Ubuntu Packages
echo -e "\e[1;33m- Enable All Packages\e[0m"
sudo apt-add-repository main
sudo apt-add-repository universe
sudo apt-add-repository multiverse
sudo apt-add-repository restricted

# # Install htop, nano, and dkms
echo -e "\e[1;33m- - Install htop, nano, ipython3, pip3, and dkms\e[0m"
sudo apt-get install htop nano ipython3 dkms python3-pip


# Install Edimax WiFi Driver:
#==================================================================================
echo -e "\n\n\e[0;37mInstall Edimax WiFi Driver\e[0m"
./install_edimax_driver.sh

# Install Jetbot
#==================================================================================
# https://github.com/NVIDIA-AI-IOT/jetbot
echo -e "\n\n\e[0;37mInstall Jetbot\e[0m"
./install_jetbot.sh


# Install Jetbot ROS
#==================================================================================
echo -e "\n\n\e[0;37mRun Jetbot ROS Installation Script\e[0m"
./install_jetbot_ros.sh

# - Install ROS Melodic
# - Install Adafruit Libraries (ommitted # Already done in jetbot configuration script))
# - Create catkin workspace
# - Build jetson-inference
# - Build ros_deep_learning
# - Build jetbot_ros




# Install AWS Greengrass
#==================================================================================
echo -e "\n\n\e[0;37mRun AWS Greengrass Installation Script\e[0m"
./install_aws_greengrass.sh



# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# ${DIR}/create-sdcard-image-from-scratch.sh\

# https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/flashing.html
#  sudo ./flash.sh -S 58GiB jetson-nano-sd mmcblk0p1


# # Resize partition
# # resize2fs -p '<drive>' <size>
# e2fsck -f -y -v -C 0'/dev/mmcblk0p1'
# # resize2fs -p '/dev/mmcblk0p1' 19968000K
# resize2fs -p '/dev/mmcblk0p1' 20000000K

# Clear Terminal History/Buffer
#==================================================================================
# echo -e "\n\n\e[0;37mClear Bash History\e[0m"
# history -c; history -w; rm ~/.bash_history
