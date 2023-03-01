# Powershell : ADQueries Collection

Some ADQueries functions to retrieve informations from Active Directory
## Script informations

These scripts have been formatted into functions to facilitate their use and give examples, however you can just retrieve the line corresponding to the desired command and run it standalone

### Users

|Script|Description|
|-|-|
|[Get-ADUsers-CreatedByYear.ps1](./Commands/ADUsers/Get-ADUsers-CreatedByYear.ps1)|Get all user's disabled account|
|[Get-ADUsers-Disabled-LastChanged-MoreThanYear.ps1](./Commands/ADUsers/Get-ADUsers-Disabled-LastChanged-MoreThanYear.ps1)|Get all user's disabled where last change more than a selected Date|
|[Get-ADUsers-Disabled.ps1](./Commands/ADUsers/Get-ADUsers-Disabled.ps1)|Get all user's disabled account|
|[Get-ADUsers-Enabled-AccountExpired.ps1](./Commands/ADUsers/Get-ADUsers-Enabled-AccountExpired.ps1)|Get all user's disabled where account is expired|
|[Get-ADUsers-Enabled-LastLogon-Never.ps1](./Commands/ADUsers/Get-ADUser-Enabled-LastLogon-Never.ps1)|Get all user's enabled never been logged on|
|[Get-ADUsers-Enabled-LockedAccount.ps1](./Commands/ADUsers/Get-ADUsers-Enabled-LockedAccount.ps1)|Get all user's enabled and locked account|
|[Get-ADUsers-Enabled-PwdLastSet-Betw2Date.ps1](./Commands/ADUsers/Get-ADUsers-Enabled-PwdLastSet-Betw2Date.ps1)|Get all user's enabled account where password was changed between two date|
|[Get-ADUsers-Enabled-PwdExpired.ps1](./Commands/ADUsers/Get-ADUsers-Enabled-PwdExpired.ps1)|Get all user's enabled account where password is expired|
|[Get-ADUsers-Enabled-PwdLastSet-Less1Mth.ps1](./Commands/ADUsers/Get-ADUsers-Enabled-PwdLastSet-Less1Mth.ps1)|Get all user's enabled account where password was changed less than a month ago|
|[Get-ADUsers-Enabled-PwdLastSet-MoreThanDate.ps1](./Commands/ADUsers/Get-ADUser-Enabled-PwdLastSet-MoreThanDate.ps1)|Get all user's enabled account where password was changed anterior than selected date|
|[Get-ADUsers-Enabled-PwdLastSet-Never.ps1](./Commands/ADUsers/Get-ADUsers-Enabled-PwdLastSet-Never.ps1)|Get all user's enabled account where password never been set|
|[Get-ADUSers-Enabled-PwdNeverExpire](./Commands/ADUsers/Get-ADUSers-Enabled-PwdNeverExpire)|Get all user's enabled account where Password Never Expire|
|[Get-ADUsers-Enabled-PwdNotRequired.ps1](./Commands/ADUsers/Get-ADUsers-Enabled-PwdNotRequired.ps1)|Get all user's enabled where password not required|
|[Get-ADUsers-Enabled-SearchBySamAccountName.ps1](./Commands/ADUsers/Get-ADUsers-Enabled-SearchBySamAccountName.ps1)|Get all user's enabled account searh by SamaccountName|
|[Get-ADUsers-Enabled-SearchByUserPrincipalName.ps1](./Commands/ADUsers/Get-ADUsers-Enabled-SearchByUserPrincipalName.ps1)|Get all user's enabled account searh by UserPrincipalName|
|[Get-ADUsers-Enabled.ps1](./Commands/ADUsers/Get-ADUsers-Enabled.ps1)|Get all user's enabled account|


### Computers

|Script|Description|
|-|-|

## 🔗 Links
https://github.com/Letalys/Powershell-ADQueries-Collection


## Autor
- [@Letalys (GitHUb)](https://www.github.com/Letalys)