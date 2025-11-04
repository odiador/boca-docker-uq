#!/bin/bash
# Fix the BOCA jail to support x86-64 Java compilation

# Enable multiarch support for x86-64
if [ -d /bocajail ]; then
    echo "Enabling multiarch support in chroot jail..."
    
    # Add amd64 architecture
    chroot /bocajail dpkg --print-architecture
    chroot /bocajail dpkg --print-foreign-architectures | grep -q amd64 || chroot /bocajail dpkg --add-architecture amd64
    
    # Update and install x86-64 C library
    chroot /bocajail apt-get -y update
    chroot /bocajail apt-get -y install --no-install-recommends libc6:amd64
    
    echo "Multiarch support enabled successfully"
else
    echo "Warning: /bocajail not found"
fi
