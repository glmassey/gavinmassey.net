# Make sure to install the AD DS role before setting DNS server addresses
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Install the AD DS Forest with the domain name 'docodo.io'
# This is only for the first domain controller, if you are 
# Adding a second one, use the next command
Install-ADDSForest -DomainName "docodo.local"

# Use this to add a second domain controller
Install-ADDSDomainController -DomainName "docodo.local" -Credential (Get-Credential)