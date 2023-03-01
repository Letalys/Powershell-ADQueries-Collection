<#
.SYNOPSIS
	Get all user's disabled where last change more than a selected Date
.INPUTS
	SearchBase : Set the Active Directory search path
    SelectedYear : Choose the starting year to obtain the accounts of previous years
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

Function Get-ADUsers-Disabled-LastChanged-MoreThanYear{
    Param($SearchBase,$SelectYear)

    $ADQuery = Get-AdUser -filter {(Enabled -eq $false) -and (WhenChanged.Year -lt $SelectYear)} -SearchBase "$SearchBase" -Properties WhenChanged
    return $ADQuery
}

Try{
    Get-ADUsers-Disabled-LastChanged-MoreThanYear -SearchBase "<OU=,DC=,DC=>" -SelectYear "<Year>" | Measure-Object
    Get-ADUsers-Disabled-LastChanged-MoreThanYear -SearchBase "<OU=,DC=,DC=>" | Format-Table UserPrincipalName,WhenChanged
    Exit 0
}catch{
    Write-Error "Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    Exit 1
}