param(
    [string]$group=$(Throw "Parameter is missing: Group")
)
Write-Host "Group: "$group
try{
    Get-ADGroupMember -Identity $group | Select Name
}
catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]{
    Write-Host "Group does not exist"
}