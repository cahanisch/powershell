param(
    [string]$user=$(Throw "Parameter is missing: username")
)
(Get-ADUser -Identity $user -Properties memberof).memberof | Get-ADGroup | Select-Object name | Sort-Object name | ForEach-Object{
    Write-Host "Group: "$_.name
    Get-ADGroupMember -Identity $_.name | Select Name | ForEach-Object{
        Write-Host $_.name
    }
    Write-Host ""
}