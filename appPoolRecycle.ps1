#list all application pools
$pools = (get-iisapppool).name
#recursivly recycling the application pool
foreach($pool in $pools){
    #recycle the application pool
    Restart-WebAppPool $pool
    #output the event log 
    $wasLog = Get-EventLog -LogName System -Source WAS -Newest 1 | Select-Object Timegenerated, message
    $outLog = $env:computername + " " +$pool + " " + $wasLog.TimeGenerated.ToString() + " " + $wasLog.Message.ToString() 
    Add-Content -Path "c:\temp.txt" -Value $outLog
}