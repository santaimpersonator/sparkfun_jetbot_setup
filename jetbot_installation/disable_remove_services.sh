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