<#
.SYNOPSIS
	Get all user's enabled account where password is expired
.INPUTS
	SearchBase : Set the Active Directory search path
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

Function Get-ADAllUsersAccount-Enabled-PwdExpired{
    Param($SearchBase)
    $ADQuery = Get-ADUSer -Filter {(Enabled -eq $true)} -SearchBase $SearchBase -Properties PasswordExpired | Select-Object UserPrincipalName,PasswordExpired | Where-Object {$_.PasswordExpired -eq $true}
    return $ADQuery
}

Try{
    #You can use Wildcard
    Get-ADAllUsersAccount-Enabled -SearchBase "<OU=,DC=,DC=>"  | Measure-Object
    Get-ADAllUsersAccount-Enabled -SearchBase "<OU=,DC=,DC=>"  | Format-Table
    Exit 0
}catch{
    Write-Error "Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    Exit 1
}