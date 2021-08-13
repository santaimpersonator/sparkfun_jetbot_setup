#!/bin/bash

# Copyright (c) 2019, NVIDIA CORPORATION. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#  * Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#  * Neither the name of NVIDIA CORPORATION nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
# OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# This is a script to create swapfile if space is available
# https://github.com/NVIDIA-AI-IOT/jetbot/blob/master/scripts/enable_swap.sh

SWAPDIRECTORY="/"
SWAPSIZE=4
NAME_SWAP="swfile"
SWAPLOCATION="$SWAPDIRECTORY/$NAME_SWAP"

# Check the size of the swap file
CURRENT_SWAP_SIZE=$(IFS=' '; read -a strarr <<< $(free -m | grep Swap:); echo ${strarr[1]})


make_swap(){
	sudo fallocate -l ${SWAPSIZE}G ${SWAPLOCATION}
	sudo chmod 600 ${SWAPLOCATION}
	sudo mkswap ${SWAPLOCATION}
	sudo swapon ${SWAPLOCATION}
	sudo bash -c 'echo "/swfile none swap sw 0 0" >> /etc/fstab'
}

remove_swap(){
	SWAPFILE=$1 
	sudo swapoff ${SWAPFILE}
	sudo rm ${SWAPFILE}
}

if [ $CURRENT_SWAP_SIZE -gt 4000 ]; then
	echo "### You have enough swap memory space."
elif [ $CURRENT_SWAP_SIZE -gt 0 ]; then
	echo "### You have swap memory space, but not big enough."
	if [ -f "$SWAPLOCATION" ]; then
		remove_swap $SWAPLOCATION
	fi
	# You may want to delete all files you find under 'cat /proc/swaps'
	make_swap
else
	echo "### No swap memory currently configured on the system."
	make_swap
fi

cat /etc/fstab
