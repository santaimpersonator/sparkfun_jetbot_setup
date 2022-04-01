#!/bin/bash

# Created by SparkFun Electronics February 2022
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