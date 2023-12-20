# Setting a New DHCP Server Scope using PowerShell

# Define scope parameters
$scopeName = "ExampleScope"
$startRange = "192.168.1.10" # Starting IP address of the scope
$endRange = "192.168.1.100"  # Ending IP address of the scope
$subnetMask = "255.255.255.0"
$gateway = "192.168.1.1"
$dnsServers = "192.168.1.2", "192.168.1.3"

# Authorize the DHCP server in Active Directory
Add-DhcpServerInDC -DnsName "DhcpServerName"

# Add a new DHCP scope
Add-DhcpServerv4Scope -Name $scopeName -StartRange $startRange -EndRange $endRange -SubnetMask $subnetMask

# Optionally, set additional scope options like default gateway (Router) and DNS servers
Set-DhcpServerv4OptionValue -ScopeId $startRange -Router $gateway
Set-DhcpServerv4OptionValue -ScopeId $startRange -DnsServer $dnsServers

# Note:
# - Replace the IP addresses and subnet mask with values appropriate for your network.
# - Ensure the DHCP role is installed and you have administrative privileges to run these commands.
