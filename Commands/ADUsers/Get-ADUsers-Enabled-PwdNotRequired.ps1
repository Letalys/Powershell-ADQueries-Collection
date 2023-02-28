<#
.SYNOPSIS
	Get all user's enabled where password not required
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

Function Get-ADUsers-Enabled-PwdNotRequired{
    Param($SearchBase)
    $ADQuery = Get-ADUSer -Filter {(Enabled -eq $true)} -SearchBase "$searchbase" -Properties PasswordNotRequired | Select-Object-Object UserPrincipalName,PasswordNotRequired |Where-Object {$_.PasswordNotRequired -eq $true}|
    return $ADQuery
}

Try{
    Get-ADUsers-Enabled-PwdNotRequired -SearchBase "<OU=,DC=,DC=>" | Measure-Object
    Get-ADUsers-Enabled-PwdNotRequired -SearchBase "<OU=,DC=,DC=>" | Format-Table
    Exit 0
}catch{
    Write-Error "Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    Exit 1
}