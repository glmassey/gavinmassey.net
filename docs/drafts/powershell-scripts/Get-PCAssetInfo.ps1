<#
    .Synopsis
        Gets basic computer asset information
    .DESCRIPTION
        Gets information from the bios and computer system using CIM and builds a simple report.
    .EXAMPLE
        Simply run on any machine and the results will be displayed on screen
#>

# Get computer system and BIOS information
$ComputerSystem = Get-CimInstance -ClassName CIM_ComputerSystem
$Bios = Get-CimInstance -ClassName CIM_BIOSElement

# Check if the information was retrieved successfully
if ($ComputerSystem -and $Bios) {
    # Build the results hashtable
    $Results = @{
        'Computer Name' = $ComputerSystem.Name
        'Model'         = $ComputerSystem.Model
        'Serial Number' = $Bios.SerialNumber
    }

    # Convert the hashtable to a custom PowerShell object
    $Report = [PSCustomObject]$Results

    # Clear the host (console) and display the report
    Clear-Host
    $Report | Format-Table -AutoSize
}
else {
    Write-Error "Failed to retrieve system or BIOS information."
}
