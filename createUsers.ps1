$users = Import-Csv

foreach ($user in $users) 
{
    $pass = ConvertTo-SecureString $user.password -AsPlainText -Force
    try {
        New-ADGroup -Name $user.department -SamAccountName $user.department -GroupScope Global
    }
    catch [Microsoft.ActiveDirectory.Management.ADException]{
    }
    catch{
    }
    try {
        New-ADUser -Surname $user.lastname -GivenName $user.firstname -Name $user.username -SamAccountName $user.username -Department $user.department -AccountPassword $pass -City $user.province -Enabled $true -ChangePasswordAtLogon $true
        Add-ADGroupMember -Identity $user.department -Members $user.username
        Add-ADGroupMember -Identity $user.identity -Members $user.username
    }
    catch [Microsoft.ActiveDirectory.Management.ADException]{
    }
    catch{   
    }
}