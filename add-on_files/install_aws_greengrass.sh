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


# Install AWS Greengrass (v1)
# https://docs.aws.amazon.com/greengrass/latest/developerguide/
#==================================================================================
echo -e "\e[1;33mInstall AWS Greengrass\e[0m"

# *To transition to version 2, check out the following resource:
# https://docs.aws.amazon.com/greengrass/v2/developerguide/move-from-v1.html

# Create the user and group for the greengrass daemon running behind the scenes.
sudo adduser --system ggc_user
sudo addgroup --system ggc_group

# Optional, but I think would be good to have, is the greengrass dependency checker. For debugging by the end user.
mkdir greengrass-dependency-checker-GGCv1.9.x
cd greengrass-dependency-checker-GGCv1.9.x
wget https://github.com/aws-samples/aws-greengrass-samples/raw/master/greengrass-dependency-checker-GGCv1.9.x.zip
unzip greengrass-dependency-checker-GGCv1.9.x.zip
sudo ./check_ggc_dependencies | more

# Download the software and unzip it to the root directory
# Download link: https://d1onfpft10uf5o.cloudfront.net/greengrass-core/downloads/1.9.2/greengrass-linux-aarch64-1.9.2.tar.gz 
sudo adduser --system ggc_user
sudo addgroup --system ggc_group
wget https://d1onfpft10uf5o.cloudfront.net/greengrass-core/downloads/1.9.2/greengrass-linux-aarch64-1.9.2.tar.gz
sudo tar -xvf greengrass-linux-aarch64-1.9.2.tar.gz -C /