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


# Install Jetbot: https://github.com/NVIDIA-AI-IOT/jetbot
#==================================================================================
echo -e "e\[1;32mInstall Jetbot\e[0m"

# Clone Jetbot Repository
echo -e "e\[1;33m- Clone Jetbot Repository\e[0m"
cd
git clone https://github.com/santaimpersonator/jetbot

# Run configuration scripts
cd jetbot/scripts
echo -e "e\[1;33m- Clone Jetbot Repository\e[0m"
# chmox +x create-sdcard-image-from-scratch.sh configure_jetson.sh

# Run create-sdcard-image-from-scratch.sh script
#----------------------------------------------------------------------------------
# - Enable i2c permissions
# - Make swapfile
# - Install pip and some python dependencies
# - Install jtop
# - Install the pre-built TensorFlow pip wheel
# - Install the pre-built PyTorch pip wheel 
# - Install torchvision package

# - Install torch2trt
# - Install traitlets (master, to support the unlink() method)
# - Install jupyter lab
# - Install jupyter_clickable_image_widget
# - Install bokeh
# - Install jetbot python module
# - Install jetbot services
# - Install python gst dependencies
# - Install zmq dependency (should actually already be resolved by jupyter)
# - Optimize the system configuration to create more headroom
# - Copy JetBot notebooks to home directory
echo -e "e\[1;33m- Run create-sdcard-image-from-scratch.sh script\e[0m"
./create-sdcard-image-from-scratch.sh

# Run configure_jetson.sh script
#----------------------------------------------------------------------------------
# - Disable GUI to free up more RAM
# - Disable ZRAM
# - Default to Max-N power mode
echo -e "e\[1;33m- Run configure_jetson.sh script \e[0m"
./configure_jetson.sh


# Return to home directory
cd