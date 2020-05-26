param(
    [string]$fileName = $(Throw "You need to provide a file as a command line argument")
)

$pass = Read-Host "Please enter the default password: " -AsSecureString

$data = Get-Content $fileName

foreach($user in $data){
    New-LocalUser $user -Password $pass 
}