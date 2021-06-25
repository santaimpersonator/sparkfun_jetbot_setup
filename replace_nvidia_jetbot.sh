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

# Remove Carriage Returns and Add Permissions
echo -e "\e[100mRun Partition Expansion Script\e[0m"
sed -i 's/\r$//' expand_partition.sh
sudo bash expand_partition.sh

# Install pip3
echo -e "\e[100mInstall pip3 htop nano ipython3\e[0m"
sudo apt-get install -y python3-pip nano htop ipython3

# Install jtop
echo -e "\e[100mInstall jtop\e[0m"
sudo -H pip3 install -U jetson-stats 

# Replace Nvidia Jetbot Installation
#==================================================================================
echo -e "\e[0;37mReplace Jetbot Installation\e[0m"


# Remove Jetbot Installation
#==================================================================================
echo -e "\e[1;32m- Remove Jetbot Installation\e[0m"

# Disable Docker Container
#----------------------------------------------------------------------------------
echo -e "\e[1;33m  - Disable Docker Container\e[0m"
cd ~/jetbot/docker && ./disable.sh

# Delete jetbot Folder
#----------------------------------------------------------------------------------
echo -e "\e[1;33m  - Delete jetbot Folder\e[0m"
cd && sudo rm -rf jetbot

# Delete JetBot notebooks
#----------------------------------------------------------------------------------
cd && sudo rm -rf Notebooks

# Uninstall jetbot Python Package
#----------------------------------------------------------------------------------
echo -e "\e[1;33m  - Uninstall jetbot Python Package\e[0m"
sudo pip3 uninstall jetbot
pip3 uninstall jetbot

# Stop and Delete jetbot Services
#----------------------------------------------------------------------------------
echo -e "\e[1;33m  - Remove jetbot Services\e[0m"

# Stop and Disable Services
sudo systemctl stop jetbot_stats
sudo systemctl disable jetbot_stats
sudo systemctl stop jetbot_jupyter
sudo systemctl disable jetbot_jupyter

# Remove Files
sudo rm -rf /etc/systemd/system/jetbot_stats.service 
sudo rm -rf /etc/systemd/system/jetbot_jupyter.service

# Reload and Reset List
sudo systemctl daemon-reload
sudo systemctl reset-failed


# Replace Jetbot Installation
#==================================================================================
echo -e "\e[1;33m- Replace Jetbot Installation\e[0m"

# Clone Jetbot Repository
#----------------------------------------------------------------------------------
echo -e "\e[1;33m  - Clone New Jetbot Repository\e[0m"
cd && git clone https://github.com/santaimpersonator/jetbot.git
# git clone https://github.com/NVIDIA-AI-IOT/jetbot


# Copy JetBot notebooks to home Directory
#----------------------------------------------------------------------------------
echo -e "\e[1;33m  - Copy New JetBot Notebooks\e[0m"
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
    echo -e "\e[1;32m  - Rebuild and Install New Docker Containers\e[0m"

    # Configure the Environment Variables
    #----------------------------------------------------------------------------------
    echo -e "\e[1;33m    - Configure the Environment Variables\e[0m"
    cd ~/jetbot/docker && source configure.sh

    # Build New Docker Container
    #----------------------------------------------------------------------------------
    echo -e "\e[1;33m    - Build New Docker Container\e[0m"
    cd ~/jetbot/docker && ./build.sh

    # Install New Docker Container
    #----------------------------------------------------------------------------------
    echo -e "\e[1;33m    - Install New Docker Container\e[0m"
    cd ~/jetbot/docker && ./enable.sh

# For Previous Jetpack Releases: Install jetbot Python Package and Create Services
else
    # Install New jetbot Python Module
    #----------------------------------------------------------------------------------
    echo -e "\e[1;32m  - Install New jetbot Python Module\e[0m"
    cd ~/jetbot && sudo python3 setup.py install 

    # Install New jetbot Services
    #----------------------------------------------------------------------------------
    echo -e "\e[1;32m  - Install New jetbot Services\e[0m"
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