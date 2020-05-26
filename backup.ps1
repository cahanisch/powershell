param(
    [string]$fileName = $(Throw "You need to provide a file as a command line argument")
)
if (Test-Path $fileName)
{
    $backup = -join($fileName, ".backup")
    Write-Host "Creating a backup of "$fileName
    Copy-Item $fileName $backup
}
else 
{
    Write-Host "File not found"
}