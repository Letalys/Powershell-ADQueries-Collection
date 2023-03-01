<#
.SYNOPSIS
	Get all user's enabled account where password was changed anterior than selected date
.INPUTS
	SearchBase : Set the Active Directory search path
    Date1 : start date

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

Function Get-ADUsers-Enabled-PwdLastSet-MoreThanDate{
    Param($SearchBase,$Date1)

    $D1 = Get-Date($Date1)

    $ADQuery = Get-AdUser -filter {(Enabled -eq $true) -and (PasswordLastSet -le $D1)  -and (pwdlastset -gt 0)} -SearchBase "$searchbase" -Properties PasswordLastSet| Select-Object-Object UserPrincipalName,PasswordLastSet,pwdLastSet
    return $ADQuery
}

Try{
    Get-ADUsers-Enabled-PwdLastSet-Betw2Date -SearchBase "<OU=,DC=,DC=>"  -Date1 "<StartDate>" | Measure-Object
    Get-ADUsers-Enabled-PwdLastSet-Betw2Date -SearchBase "<OU=,DC=,DC=>"  -Date1 "<StartDate>" | Format-Table
    Exit 0
}catch{
    Write-Error "Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    Exit 1
}