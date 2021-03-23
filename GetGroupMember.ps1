$GroupName = $args[0]
IF($GroupName -eq $null){$GroupName = Read-Host -Prompt "What's the group name?"}
$Attrib = Get-Content .\attrib.txt

Get-ADGroupMember -Identity $GroupName -Recursive | 
    Where-Object objectClass -eq 'user' |
    Get-ADUser -Properties $Attrib | 
    Select-Object $Attrib | 
    Sort sAMAccountName | 
Export-CSV ".\$GroupName.csv" -NoTypeInformation -Encoding UTF8

explorer ".\$GroupName.csv"