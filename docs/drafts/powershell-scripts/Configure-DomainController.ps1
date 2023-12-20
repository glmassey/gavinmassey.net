# Change the computer name
Rename-Computer -NewName "perth-dc1"

# Restart the computer
Restart-Computer

# This will show you a list of all the network adapters
Get-NetAdapter

# To remove the ip address assignment (if already exists)
#Remove-NetIPAddress -InterfaceAlias Ethernet0

# To set a new ip address
New-NetIPAddress -InterfaceAlias Ethernet0 -IPAddress 10.0.77.2 -PrefixLength 24 -DefaultGateway 10.0.77.1

Set-DnsClientServerAddress -InterfaceAlias "Ethernet0" -ServerAddresses 127.0.0.1

# The following 3 commands can be used to explicitly set the default gateway, if you
# forgot to add the -DefaultGateway flag when setting the ip address

# Identify the default gateway route to remove
#Get-NetRoute -InterfaceAlias Ethernet0 -DestinationPrefix "0.0.0.0/0"

# Remove the default gateway
#Remove-NetRoute -InterfaceAlias Ethernet0 -DestinationPrefix "0.0.0.0/0"

# Setting the Default Gateway
#New-NetRoute -InterfaceAlias "Ethernet0" -DestinationPrefix "0.0.0.0/0" -NextHop 10.0.77.1

# Set the time zone to Western Australia Standard Time for Perth, Australia
Set-TimeZone -Id "W. Australia Standard Time"

# Make sure to install the AD DS role before setting DNS server addresses
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Install the AD DS Forest with the domain name 'corp.docodo.io'
Install-ADDSForest -DomainName "docodo.local"

# Reboot the server
Restart-Computer

# Make sure to install the AD DS role before setting DNS server addresses
Install-WindowsFeature -Name DHCP -IncludeManagementTools

# Install the AD DS Forest with the domain name 'corp.docodo.io'
Install-ADDSForest -DomainName "docodo.local"

# Configure the DHCP server with a new scope for 'PacktLabNet'
Set-DhcpServerv4Scope -ScopeId 10.0.0.0 -StartRange 10.0.0.10 -EndRange 10.0.0.100

# Set the default gateway, DNS domain, and DNS server for DHCP clients
Set-DhcpServerv4OptionValue -DnsDomain "corp.docodo.io" -DnsServer 10.0.0.2 -Router 10.0.0.1 -ScopeId 10.0.0.0

# Add the DHCP server in the current domain controller
Add-DhcpServerInDC

# Creating a new AD user 'SysAdmin' with the specified password and properties
New-ADUser -SamAccountName "gmassey" -AccountPassword (Read-Host "Set user password" -AsSecureString) `
    -Name "gmassey" -Enabled $true -PasswordNeverExpires $true -ChangePasswordAtLogon $false

# Adding 'SysAdmin' to the 'Enterprise Admins' and 'Domain Admins' groups
Add-ADPrincipalGroupMembership -Identity "gmassey" `
    -MemberOf "CN=Enterprise Admins,CN=Users,DC=docodo,DC=local", `
    "CN=Domain Admins,CN=Users,DC=docodo,DC=local"

# Retrieving group membership for the 'SysAdmin' user
Get-ADPrincipalGroupMembership -Identity "gmassey"

# After AD DS installation, set the DNS client server address to the local server
# This should be the IP of your newly configured DNS server within the domain.
# If this is the primary ip address, you can keep the lookback ip address, but 
# secondary domain controllers should explicity set the ip address
Set-DnsClientServerAddress -InterfaceAlias "Ethernet0" -ServerAddresses 10.0.77.2