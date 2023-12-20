Rename-Computer -NewName 'NewComputerName'

# Also lets just boot to a powershell command
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "Shell" -Value "powershell.exe"

Restart-Computer

# Remove the old ip address
Remove-NetIPAddress -InterfaceAlias 'Ethernet0'

# Also you might have to remove the default gateway
Remove-NetRoute -InterfaceAlias 'Ethernet0' -NextHop 10.0.0.2

# Now you can add the new IP Address
New-NetIPAddress `
    -InterfaceAlias 'Ethernet0' `
    -IPAddress '10.0.77.101' `
    -PrefixLength 24 `
    -DefaultGateway '10.0.77.1'

# You will also need to set the DNS address
Set-DnsClientServerAddress `
    -InterfaceAlias 'Ethernet0' `
    -ServerAddresses '10.0.77.101, 10.0.77.102'

# Set the timezone
Set-TimeZone -Id 'Mountain Standard Time'

# Add to domain
Add-Computer `
    -DomainName 'docodo.local' `
    -Credential 'docodo.local\gmassey' -Restart

# Enable Remote Management
Enable-PSRemoting -Force

# Enable PowerShell
Set-ExecutionPolicy RemoteSigned

# Enable Remote Desktop

# This command sets the registry to enable Remote Desktop
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -Value 0

# 2. Configure the Windows Firewall to Allow Remote Desktop
# This command enables the necessary firewall rule for Remote Desktop
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# 3. Optional: Enable Network Level Authentication for extra security
# This command sets the registry to enable NLA for Remote Desktop
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 1

# 4. Restart the Remote Desktop Services to apply changes
# This command restarts the TermService to apply the above changes
Restart-Service -Name TermService -Force

# Download and install updates
Install-Module -Name PSWindowsUpdate -Force
Import-Module PSWindowsUpdate
Get-WindowsUpdate -Install -AcceptAll -AutoReboot