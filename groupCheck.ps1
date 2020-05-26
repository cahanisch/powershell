Get-ADGroup -Filter * -Properties Name | ForEach-Object{
    Write-Host "Group: "$_.Name
    foreach ($group in $_) {
        Get-ADGroupMember -Identity $group | Select Name
    }
    Write-Host ""
}