<#
.SYNOPSIS
	Get all user's disabled account
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

Function Get-ADUsers-Disabled{
    Param($SearchBase)
    $ADQuery = Get-ADUSer -Filter {(Enabled -eq $false)} -SearchBase "$SearchBase"
    return $ADQuery
}

Try{
    Get-ADUsers-Disabled -SearchBase "<OU=,DC=,DC=>" | Measure-Object
    Get-ADUsers-Disabled -SearchBase "<OU=,DC=,DC=>" | Format-Table
    Exit 0
}catch{
    Write-Error "Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    Exit 1
}