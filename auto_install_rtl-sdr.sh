# MIT License

# Copyright (c) [2023] [Dave Vermeulen]

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


#!/bin/bash

set -e

# Update package repositories
echo "Updating package repositories..."
apt-get update

# Install required packages
echo "Installing cmake and libusb-1.0-0.dev..."
apt-get install cmake -y
apt-get install libusb-1.0-0.dev -y

# Clone rtl-sdr repository
echo "Cloning rtl-sdr repository..."
git clone git://git.osmocom.org/rtl-sdr.git
# git clone https://gitea.osmocom.org/sdr/rtl-sdr.git

# Change to the rtl-sdr directory
echo "Changing to rtl-sdr directory..."
cd rtl-sdr/

# Create the build directory
echo "Creating build directory..."
mkdir build

# Change to the build directory
echo "Changing to build directory..."
cd build/

# Run CMake to generate build files
echo "Running CMake..."
cmake ../ -DDETACH_KERNEL_DRIVER=ON -DINSTALL_UDEV_RULES=ON

# Build rtl-sdr
echo "Building rtl-sdr..."
make

# Install rtl-sdr
echo "Installing rtl-sdr..."
make install

# Refresh library path
echo "Refreshing library path..."
ldconfig

# Get current IP address
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# Prompt for systemd service installation
read -rp "Do you want to install the systemd service for rtl_tcp? (y/n): " install_service

if [[ "$install_service" =~ ^[Yy]$ ]]; then
    # Create systemd service
    echo "Creating systemd service for rtl_tcp..."
    cat > /etc/systemd/system/rtl_tcp.service <<EOF
[Unit]
Description=RTL_TCP Service
After=network.target

[Service]
ExecStart=/usr/local/bin/rtl_tcp -a $IP_ADDRESS
Restart=always
RestartSec=5

[Install]
WantedBy=default.target
EOF

    # Reload systemd daemon
    echo "Reloading systemd daemon..."
    systemctl daemon-reload

    # Enable and start the service
    echo "Enabling and starting rtl_tcp service..."
    systemctl enable rtl_tcp.service
    systemctl start rtl_tcp.service

    echo "rtl_tcp systemd service has been installed and started."
else
    echo "Skipping installation of rtl_tcp systemd service."
fi

echo " "
echo "Installation and execution complete."

#Please be sure to check out my youtube channel Thanks! 73's Dave ZR6LSD
#YouTube: https://www.youtube.com/channel/UChsvCpuR1VJg0w5DX9j5GsA

