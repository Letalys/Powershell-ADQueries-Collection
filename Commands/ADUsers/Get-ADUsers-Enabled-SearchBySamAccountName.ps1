<#
.SYNOPSIS
	Get all user's enabled account searh by SamaccountName
.INPUTS
	SearchBase : Set the Active Directory search path
    Samaccountname : Set the UserprincipalName to search, you can use Wildcard
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

Function Get-ADUsers-Enabled-SearchByUserSamaccountname{
    Param($SearchBase,$SamaccountName)
    $ADQuery = Get-ADUSer -Filter {(Enabled -eq $true) -and (SamaccountName -like "$SamaccountName")} -SearchBase "$SearchBase"
    return $ADQuery
}

Try{
    Get-ADUsers-Enabled-SearchByUserSamaccountname -SearchBase "<OU=,DC=,DC=>" SamaccountName "<*SamaccountName*>" | Measure-Object
    Get-ADUsers-Enabled-SearchByUserSamaccountname -SearchBase "<OU=,DC=,DC=>" SamaccountName "<*SamaccountName*>" | Format-Table
    Exit 0
}catch{
    Write-Error "Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    Exit 1
}