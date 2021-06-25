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
echo -e "\e[1;32mInstall Jetbot\e[0m"

# Clone Jetbot Repository
#----------------------------------------------------------------------------------
echo -e "\e[1;33m  - Clone Jetbot Repository\e[0m"
cd && git clone https://github.com/santaimpersonator/jetbot.git
# git clone https://github.com/NVIDIA-AI-IOT/jetbot

# Run configuration scripts
cd jetbot/scripts
echo -e "\e[1;33m- Run configuration scripts\e[0m"
# chmox +x create-sdcard-image-from-scratch.sh configure_jetson.sh

# Run configure_jetson.sh script
#----------------------------------------------------------------------------------
# - Disable GUI to free up more RAM
# - Disable ZRAM
# - Default to Max-N power mode
echo -e "\e[1;33m  - Run configure_jetson.sh script\e[0m"
./configure_jetson.sh

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
echo -e "\e[1;33m  - Run create-sdcard-image-from-scratch.sh script\e[0m"
./create-sdcard-image-from-scratch.sh

# Copy JetBot notebooks to home Directory
#----------------------------------------------------------------------------------
echo -e "\e[1;33m  - Copy JetBot Notebooks\e[0m"
cp -r ~/jetbot/notebooks ~/Notebooks

# Download Models: https://github.com/NVIDIA-AI-IOT/jetbot/wiki/Examples
#==================================================================================
echo -e "\e[1;32m  - Download Models\e[0m"

# Download Pre-Trained Model for Collision Avoidance Example
#----------------------------------------------------------------------------------
echo -e "\e[1;33m     - Collision Avoidance Model\e[0m"
cd ~/Notebooks/collision_avoidance
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1UsRax8bR3R-e-0-80KfH2zAt-IyRPtnW' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1UsRax8bR3R-e-0-80KfH2zAt-IyRPtnW" -O best_model.pth && rm -rf /tmp/cookies.txt

# Download Object Detection Model for Object Following Example
#----------------------------------------------------------------------------------
echo -e "\e[1;33m    - Object Detection Model\e[0m"
cd ~/Notebooks/object_following
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1KjlDMRD8uhgQmQK-nC2CZGHFTbq4qQQH' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1KjlDMRD8uhgQmQK-nC2CZGHFTbq4qQQH" -O ssd_mobilenet_v2_coco.engine && rm -rf /tmp/cookies.txt


# For Jetpack +4.5: Build and Enable Docker Contatiners
if [ $JETSON_JETPACK \> 4.4 ]
then
    # Rebuild Docker Containers
    #==================================================================================
    echo -e "\e[1;32m  - Rebuild and Install Docker Containers\e[0m"

    # Configure the Environment Variables
    #----------------------------------------------------------------------------------
    echo -e "\e[1;33m    - Configure the Environment Variables\e[0m"
    cd ~/jetbot/docker && source configure.sh

    # Build Docker Container
    #----------------------------------------------------------------------------------
    echo -e "\e[1;33m    - Build Docker Container\e[0m"
    cd ~/jetbot/docker && ./build.sh

    # Install Docker Container
    #----------------------------------------------------------------------------------
    echo -e "\e[1;33m    - Install Docker Container\e[0m"
    cd ~/jetbot/docker && ./enable.sh

# For Previous Jetpack Releases: Install jetbot Python Package and Create Services
else
    # Install jetbot Python Module
    #----------------------------------------------------------------------------------
    echo -e "\e[1;32m  - Install jetbot Python Module\e[0m"
    cd ~/jetbot && sudo python3 setup.py install 

    # Install jetbot Services
    #----------------------------------------------------------------------------------
    echo -e "\e[1;32m  - Install jetbot Services\e[0m"
    cd jetbot/utils
    python3 create_stats_service.py
    sudo mv jetbot_stats.service /etc/systemd/system/jetbot_stats.service
    sudo systemctl enable jetbot_stats
    sudo systemctl start jetbot_stats
    python3 create_jupyter_service.py
    sudo mv jetbot_jupyter.service /etc/systemd/system/jetbot_jupyter.service
    sudo systemctl enable jetbot_jupyter
    sudo systemctl start jetbot_jupyter
fi