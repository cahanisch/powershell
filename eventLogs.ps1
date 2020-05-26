Get-EventLog -List
New-EventLog -LogName "ScriptEvents" -Source "ScriptingAssignment10" -ErrorAction SilentlyContinue
Limit-EventLog -LogName "ScriptEvents" -RetentionDays 1 -MaximumSize 65536 -OverflowAction OverwriteOlder
for ($i = 0; $i -lt 100; $i++) {
    Write-EventLog -LogName "ScriptEvents" -Source "ScriptingAssignment10" -EventId 1234 -Message "Something happened"
}
Write-Host " "
Get-EventLog -List
$path = -join($PWD, "\logfile.csv")
Get-EventLog -Logname ScriptEvents | Export-Csv $path
Clear-EventLog -Logname "ScriptEvents"