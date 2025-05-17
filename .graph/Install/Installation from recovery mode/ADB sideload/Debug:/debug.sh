# Kill old server
adb kill-server

# Check Device Status
adb devices

# Test Connection
adb -P 5038 wait-for-usb-sideload

# Stop old Chroot
pmbootstrap shutdown

# Try()
pmbootstrap flasher --method=adb sideload
