# Start PowerShell as an Administrator

# Start the Windows Time Service
Start-Service w32time

# Verify the Service is Running
Get-Service w32time

# Set the NTP Server to time.windows.com
w32tm /config /syncfromflags:manual /manualpeerlist:"time.windows.com"

# Update the Windows Time Service Configuration
w32tm /config /update

# Restart the Windows Time Service
Restart-Service w32time

# Verify the Configuration
w32tm /query /configuration
w32tm /query /status

# Synchronize the Time Immediately
w32tm /resync

# Check the Current Time
Get-Date
