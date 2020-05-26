$dte = (Get-Date).AddDays(-1)

Get-Process | ForEach-Object{
    if(($_.StartTime -gt $dte) -and ($_.StartTime -ne $null)) 
    {
        $processes += @(@{
            "Name" = $_.Name;
            "Description" = $_.Description;
            "PID" = $_.Id;
            "Start Time" = $_.StartTime;
        })
    }
}
$processes | ForEach-Object{[PSCustomObject]$_} | Export-Csv -Path $PWD/processes.csv -NoTypeInformation

$sortedProc = Get-Content .\processes.csv | Select-Object -skip 1

Get-WmiObject win32_service | ForEach-Object{
    $service = $_
    foreach ($proc in $sortedProc)
    {
        $elements = $proc -split ','
        $elements[0] = $elements[0].replace('"', "")
        $elements[1] = $elements[1].replace('"', "")
        $elements[2] = $elements[2].replace('"', "")
        $elements[3] = $elements[3].replace('"', "")
        $id = [int]$elements[3]
        if (($service.ProcessId -eq $id) -and ($service.ProcessId -ne 0)) 
        {
            $services += @(@{
                "Service Name" = $_.DisplayName;
                "Process Name" = $elements[1];
                "PID" = $id;
            })
        }
    }
}

$services | ForEach-Object { [PSCustomObject]$_ } | ConvertTo-Html | Out-File $PWD/services.html