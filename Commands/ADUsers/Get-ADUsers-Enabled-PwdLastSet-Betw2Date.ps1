<#
.SYNOPSIS
	Get all user's enabled account where password was changed between two date
.INPUTS
	SearchBase : Set the Active Directory search path
    Day1 : Most recent date
    Day2 : Anterior date
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

Function Get-ADUsers-Enabled-PwdLastSet-Betw2Date{
    Param($SearchBase,$Day1,$Day2)

    $D1 = Get-Date($Day1)
    $D2 = Get-Date($Day2)

    $ADQuery = Get-AdUser -filter {(Enabled -eq $true) -and (PasswordLastSet -le $D1) -and (PasswordLastSet -ge $D2) -and (pwdlastset -gt 0)} -SearchBase "$searchbase" -Properties PasswordLastSet| Select-Object-Object UserPrincipalName,PasswordLastSet,pwdLastSet
    return $ADQuery
}

Try{
    Get-ADUsers-Enabled-PwdLastSet-Betw2Date -SearchBase "<OU=,DC=,DC=>"  -Day1 "<FirstDate>" -Day2 "<LastDate>" | Measure-Object
    Get-ADUsers-Enabled-PwdLastSet-Betw2Date -SearchBase "<OU=,DC=,DC=>"  | Format-Table
    Exit 0
}catch{
    Write-Error "Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    Exit 1
}