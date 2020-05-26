param(
    [int]$days = $(Throw "You need to provide an amount of days as a command line argument")
)

$daysOld = 0 - $days
$date = Get-Date

$destination  = -join ("\", $date, ".zip") -replace " ", "-" -replace "/","-" -replace ":","-"
$destination = -join($PWD, $destination)

Get-ChildItem | ForEach-Object{
    if($_.LastWriteTime -lt $date.AddDays($daysOld))
    {
        $file = $_.FullName
        Compress-Archive -Path $file -Update -DestinationPath $destination
    }
}