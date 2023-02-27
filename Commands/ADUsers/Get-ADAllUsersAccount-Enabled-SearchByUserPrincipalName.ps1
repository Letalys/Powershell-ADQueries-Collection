<#
.SYNOPSIS
	Get all user's enabled account searh by UserPrincipalName
.INPUTS
	SearchBase : Set the Active Directory search path
    UserPrincipalName : Set the UserprincipalName to search, you can use Wildcard
.NOTES
  Version:        1.0
  Author:         Letalys
  Creation Date:  27/02/2023
  Purpose/Change: Initial script development
.LINK
    Author : Letalys (https://github.com/Letalys)
#>
#requires -version 4
#Requires -Modules ActiveDirectory

Function Get-ADAllUsersAccount-Enabled{
    Param($SearchBase,$UserPrincipalName)
    $ADQuery = Get-ADUSer -Filter {(Enabled -eq $true) -and (UserPrincipalName -like "$UserPrincipalName")} -SearchBase $SearchBase 
    return $ADQuery
}

Try{
    Get-ADAllUsersAccount-Enabled -SearchBase "<OU=,DC=,DC=>" -UserPrincipalName "<*UserPrincipalName*>" | Measure-Object
    Get-ADAllUsersAccount-Enabled -SearchBase "<OU=,DC=,DC=>" -UserPrincipalName "<*UserPrincipalName*>" | Format-Table
    Exit 0
}catch{
    Write-Error "Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    Exit 1
}