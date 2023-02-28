<#
.SYNOPSIS
	Get all user's enabled and locked account
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

Function Get-ADUsers-Enabled-LockedAccount{
    Param($SearchBase)
    $ADQuery = Get-ADUSer -Filter {(Enabled -eq $true)} -SearchBase "$SearchBase" -Properties LockedOut | Select-Object-Object UserPrincipalName,LockedOut |Where-Object {$_.LockedOut -eq $true}
    return $ADQuery
}

Try{
    Get-ADUsers-Enabled-LockedAccount -SearchBase "<OU=,DC=,DC=>" | Measure-Object
    Get-ADUsers-Enabled-LockedAccount -SearchBase "<OU=,DC=,DC=>" | Format-Table
    Exit 0
}catch{
    Write-Error "Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    Exit 1
}