param(
    [string]$ext = $(Throw "You need to provide an extension as a command line argument")
)

$backup = -join($PWD, "\backups")
$ext = -join("*.", $ext)

Get-ChildItem -Path $PWD | ForEach-Object{
    if($_.Name -like $ext)
    {
        if(-not(Test-Path $PWD\backups -PathType Any))
        {
            New-Item -Path $backup -ItemType Directory
        }
        if(-not(Test-Path $PWD\backups\$_.Name))
        {
            Copy-Item $_.Name -Destination $backup
        }
    }
}

