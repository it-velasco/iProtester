# Define the IP address
$ip = "www.google.com"

# Define the log file
$logFile = "logs.txt"
$networkName = Get-NetConnectionProfile | Where {$_.IPv4Connectivity -eq "Internet"} | Select -ExpandProperty Name
$counter = 0;

#Title
"I-ProTester" | Out-File -Append $logFile; 
Write-Output "I-ProTester";
"Internet Provider Tester" | Out-File -Append $logFile; 
Write-Output "Welcome to the Internet Provider Tester app";
"By: Jonathan Velasco" | Out-File -Append $logFile;
Write-Output "By: Jonathan Velasco";
"jonathan@it-velasco.com" | Out-File -Append $logFile;
Write-Output "jonathan@it-velasco.com";

# Start an infinite loop
while ($true) {
	
    # Send a single ping packet and capture the result
    $ping = Test-Connection -ComputerName $ip -Count 1 -Quiet;

    # Get the current date and time
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss";

    # Check the result of the ping
    if ($ping) {
        # If the ping was successful, log "Connected"
        "$timestamp $networkName - Connected" | Out-File -Append $logFile
		Write-Output "$timestamp $networkName - Connected"
		$counter = 0;
    } else {
		  $counter++;
      # If the ping failed, log "Disconnected"
      "$timestamp $networkName - Disconnected for approximately $counter minutes." | Out-File -Append $logFile
      Write-Output "$timestamp $networkName - Disconnected for approximately $counter minutes."
    }

    # Wait for 60 seconds (1 minute)
    Start-Sleep -Seconds 60
}
