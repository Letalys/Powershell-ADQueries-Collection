<#
.SYNOPSIS
	Get all user's enabled account where password never set
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

Function Get-ADUsers-Enabled-PwdLastSet-Never{
    Param($SearchBase)
    $ADQuery = Get-AdUser -filter {(Enabled -eq $true) -and (pwdlastset -eq 0)} -SearchBase "$SearchBase" -Properties PasswordLastSet| Select-Object-Object UserPrincipalName,PasswordLastSet,pwdLastSet
    return $ADQuery
}

Try{
    Get-ADUsers-Enabled-PwdLastSet-Never -SearchBase "<OU=,DC=,DC=>"  | Measure-Object
    Get-ADUsers-Enabled-PwdLastSet-Never -SearchBase "<OU=,DC=,DC=>"  | Format-Table
    Exit 0
}catch{
    Write-Error "Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    Exit 1
}