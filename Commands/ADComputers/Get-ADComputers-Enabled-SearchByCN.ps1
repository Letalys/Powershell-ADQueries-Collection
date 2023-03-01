<#
.SYNOPSIS
	Get all computers enabled with search by CN
.INPUTS
	SearchBase : Set the Active Directory search path
    CN : Set the CN of searched computers, you can use wildcard
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

Function Get-ADComputers-Enabled-SearchByCN{
    Param($SearchBase,$CN)
    $ADQuery = Get-ADComputer -Filter {(Enabled -eq $true) -and (CN -like "$CN")} -SearchBase "$SearchBase"
    return $ADQuery
}

Try{
    Get-ADComputers-Enabled-SearchByCN -SearchBase "<OU=,DC=,DC=>" -CN "*<CN>*" | Measure-Object
    Get-ADComputers-Enabled-SearchByCN -SearchBase "<OU=,DC=,DC=>" -CN "*<CN>*" | Format-Table
    Exit 0
}catch{
    Write-Error "Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    Exit 1
}