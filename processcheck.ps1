param(
    [string]$procID=$(Throw "You need to provide a process ID as a command line argument"),
    [int]$amtToSlp = 5
)

$process = Get-Process -Id $procID -ErrorAction SilentlyContinue

if($process)
{
    do
    {
        $process = Get-Process -Id $procID -ErrorAction SilentlyContinue
        if($process)
        {
            Write-Host $process.ProcessName "is still running"
            Start-Sleep -Seconds $amtToSlp
        }
    }while($process) 

    Write-Host "Process has been terminated"
}
else
{
    Write-Host "Not a valid process ID"    
}
