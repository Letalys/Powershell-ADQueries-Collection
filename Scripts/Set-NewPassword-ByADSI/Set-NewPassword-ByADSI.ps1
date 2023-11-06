<#
.SYNOPSIS
  Generate New password for users
.DESCRIPTION
  This script set new password given in paramater to all SamAccountName in a CSV File and set changeAtLogon Attribute
  This script use ADSI provider.
.INPUT
  Set the CSV File containing SamAccountNameList
.OUPUT
  Create a log file at the same location of the script.
.EXAMPLE
  .\Set-NewPassword-ByADSI.ps1 -CSVPath "C:\Temp\<CSVFile>.csv" -NewPassword "<NewPassword>"
.NOTES
  Version:        1.0
  Author:         C.Goemaere
  Creation Date:  27/10/2023
  Purpose/Change: Initial script development
#>

[CmdletBinding()]
	param
	(
		[ValidateNotNullOrEmpty()][Parameter(Mandatory=$true)][String]$CSVPath,
		[ValidateNotNullOrEmpty()][Parameter(Mandatory=$true)][String]$NewPassword
	)

Function Set-NewPassword{
    [CmdletBinding()]
	param
	(
		[ValidateNotNullOrEmpty()][Parameter(Mandatory=$true)][Object]$ADSIUser,
		[ValidateNotNullOrEmpty()][Parameter(Mandatory=$true)][String]$NewPassword
	)

    $ADSIUserObject = [ADSI]"LDAP://$(($ADSIUser.Properties).distinguishedname)"
    $ADSIUserObject.Invoke("SetPassword", $($NewPassword))
    $ADSIUserObject.CommitChanges()
}

Function Set-ChangePasswordAtLogon{
    [CmdletBinding()]
	param
	(
		[ValidateNotNullOrEmpty()][Parameter(Mandatory=$true)][Object]$ADSIUser
	)

    $ADSIUserObject = [ADSI]"LDAP://$(($ADSIUser.Properties).distinguishedname)"
    $ADSIUserObject.Put("pwdLastSet", 0)
    $ADSIUserObject.SetInfo()
}

Clear-Host

Write-Host ""
$logPath = "$($PSSCriptRoot)\Set-NewPassword-ByADSI.log"


try{
    Add-Content -Path $logPath -Value "-- Start Process --"
    Write-Host -ForegroundColor Cyan "-- Start Process --"

    $CSVImport = Import-Csv -Path $CSVPath -Header SamAccountName

    foreach($User in $CSVImport){
        Write-Host -NoNewline -ForegroundColor Yellow "Search Account : "
        Write-Host $($User.SamAccountName)

        Add-Content -Path $logPath -Value "Search Account : $($User.SamAccountName)"

        $objSearcher=[adsisearcher]""
        $objSearcher.Filter = "(&(objectClass=user)(samaccountname=$($User.SamAccountName)))"
        $ADSIResult = $objSearcher.FindOne()

        if($null -ne $ADSIResult){
            Write-Host -ForegroundColor green "`t$(($ADSIResult.Properties).displayname) `n`t$((($ADSIResult.Properties).distinguishedname))"
            Add-Content -Path $logPath -Value "`t$(($ADSIResult.Properties).displayname) `n`t$((($ADSIResult.Properties).distinguishedname))"

            Try{
                Write-Host -ForegroundColor Yellow -NoNewline "`tSet new password : "
                
                Set-NewPassword -ADSIUser $ADSIResult -NewPassword $NewPassword

                Write-Host -ForegroundColor Green  "OK"
                Add-Content -Path $logPath -Value "`tSet new password : OK"
            }Catch{
                Write-Host -ForegroundColor red  "KO"
                Add-Content -Path $logPath -Value "`tSet new password : KO"
                Write-Host -ForegroundColor red  $_
                Add-Content -Path $logPath -Value $_
            }

            Try{
                Write-Host -ForegroundColor Yellow -NoNewline "`tSet ChangeAtLogon : "

                Set-ChangePasswordAtLogon -ADSIUser $ADSIResult

                Add-Content -Path $logPath -Value "t`Set ChangeAtLogon : OK"
                Write-Host -ForegroundColor Green "OK"
            }Catch{
                Write-Host -ForegroundColor red  "KO"
                Write-Host -ForegroundColor red  $_
                Add-Content -Path $logPath -Value "t`Set ChangeAtLogon : KO"
                Add-Content -Path $logPath -Value $_
            }

        }else{
            Write-Host -ForegroundColor red "`tAccount Not Found"
            Add-Content -Path $logPath -Value "tAccount Not Found"
        }
    }
}catch{
    Write-Host -ForegroundColor red "ERROR : `n$($_)"
    Add-Content -Path $logPath -Value "ERROR : `n$($_)"
}Finally{
    Add-Content -Path $logPath -Value "-- End Process --"
    Write-Host -ForegroundColor Cyan "-- End Process --"

    Write-host -NoNewline -ForegroundColor Yellow "Log location : "
    Write-Host $logPath
}
