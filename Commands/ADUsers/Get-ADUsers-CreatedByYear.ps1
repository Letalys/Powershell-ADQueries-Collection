<#
.SYNOPSIS
	Get all user's account created in a year, grouped by month
.INPUTS
	SearchBase : Set the Active Directory search path
    SelectedYear : Set the Year for stats
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

Function Get-ADUsers-CreatedByYear{
    Param($SearchBase,$SelectedYear)
    $ADQuery = Get-ADUser -filter * -Properties whenCreated -SearchBase "$SearchBase" | 
                Where-Object {$_.whenCreated.Year -eq $SelectedYear} |
                Group-Object {$_.whenCreated.Month} | Select-Object Count,Name
    return $ADQuery
}

Try{
    Get-ADUsers-CreatedByYear -SearchBase "<OU=,DC=,DC=>" -SelectedYear "<Year>" | Format-Table -AutoSize
    Exit 0
}catch{
    Write-Error "Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    Exit 1
}