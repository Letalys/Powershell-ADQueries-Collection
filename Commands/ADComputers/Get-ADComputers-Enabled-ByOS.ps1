<#
.SYNOPSIS
	Get all computers Grouped by OS and OS Version
.INPUTS
	SearchBase : Set the Active Directory search path
.NOTES
  Version:        1.0
  Author:         Letalys
  Creation Date:  28/02/2023
  Purpose/Change: Initial script development
.LINK
    Author : Letalys (https://github.com/Letalys)
#>
#requires -version 4
#Requires -Modules ActiveDirectory

Function Get-ADComputers-Enabled-ByOS{
    Param($SearchBase)
    $ADQuery = Get-ADComputer -Filter {(Enabled -eq $true)} -Properties operatingSystem,OperatingSystemVersion -SearchBase "$SearchBase" | 
                Group-Object -Property operatingSystem,OperatingSystemVersion | 
                Select-Object Name,Count | Sort-Object Name
    return $ADQuery
}

Try{
    Get-ADComputers-Enabled-ByOS -SearchBase "<OU=,DC=,DC=>" | Format-Table -AutoSize
    Exit 0
}catch{
    Write-Error "Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    Exit 1
}