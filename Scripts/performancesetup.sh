#!/bin/bash

# CPU Performance Setup Script
# Sets CPU governor to performance, enables TLP, and shows status

echo "=== CPU Performance Setup Script ==="
echo "Starting CPU performance configuration..."

# Set CPU frequency governor to performance for all cores
echo "Setting CPU governor to performance..."
if command -v cpufreq-set >/dev/null 2>&1; then
    # Get number of CPU cores
    num_cores=$(nproc)
    
    # Set governor for each core (0-indexed)
    for ((i=0; i<num_cores; i++)); do
        sudo cpufreq-set -c $i -g performance
    done
    
    echo "✓ CPU governor set to performance for all $num_cores cores"
else
    echo "⚠ cpufreq-set not found, trying alternative method..."
    echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "✓ CPU governor set to performance (alternative method)"
    else
        echo "✗ Failed to set CPU governor"
    fi
fi

# Show current governor status
echo ""
echo "=== Current CPU Governor Status ==="
if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor ]; then
    for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
        cpu_num=$(echo $cpu | grep -o 'cpu[0-9]*' | grep -o '[0-9]*')
        governor=$(cat $cpu)
        echo "CPU$cpu_num: $governor"
    done
else
    echo "Governor information not available"
fi

# Show current frequencies
echo ""
echo "=== Current CPU Frequencies ==="
if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq ]; then
    for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq; do
        cpu_num=$(echo $cpu | grep -o 'cpu[0-9]*' | grep -o '[0-9]*')
        freq=$(cat $cpu)
        freq_mhz=$((freq / 1000))
        echo "CPU$cpu_num: ${freq_mhz} MHz"
    done
else
    echo "Frequency information not available"
fi

# Enable and start TLP
echo ""
echo "=== TLP Configuration ==="
if command -v tlp >/dev/null 2>&1; then
    echo "Enabling TLP service..."
    sudo systemctl enable tlp
    
    echo "Starting TLP..."
    sudo tlp start
    
    # Check TLP status
    if systemctl is-active --quiet tlp; then
        echo "✓ TLP is active and running"
    else
        echo "⚠ TLP service status unclear, checking manually..."
        sudo tlp-stat -s 2>/dev/null | head -5 || echo "TLP status check failed"
    fi
else
    echo "⚠ TLP not found. Install with: sudo apt install tlp tlp-rdw"
fi

echo ""
echo "=== Configuration Complete ==="
echo "CPU governor: performance"
echo "TLP: enabled and started"
echo "Script execution finished."
