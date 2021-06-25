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

# Uninstall LibreOffice
#==================================================================================
echo -e "\n\n\e[0;37mUninstall LibreOffice\e[0m"
sudo apt-get remove --purge -y libreoffice*
sudo apt-get clean

# Clear Package Information
echo -e "\e[1;33m- Clear Package Information\e[0m"
sudo apt-get -y autoremove

# # Resize partition (not working)
# # resize2fs -p '<drive>' <size>
# e2fsck -f -y -v -C 0 '/dev/mmcblk0p1'
# # resize2fs -p '/dev/mmcblk0p1' 19968000K
# resize2fs -p '/dev/mmcblk0p1' 30720000K

# Add Partition Expansion Service to Execute on Next Boot
echo -e "\e[100mAdd Partition Expansion Service\e[0m"
sudo chmod 644 nvresizefs.sh nvresizefs.service
sudo cp nvresizefs.sh /etc/systemd
sudo cp nvresizefs.service /etc/systemd/system
sudo systemctl enable nvresizefs.service


# Clear Terminal History/Buffer
#==================================================================================
echo -e "\n\n\e[0;37mClear Bash History\e[0m"
history -c; history -w; rm ~/.bash_history