# Define the IP address
$ip = "www.google.com"

# Define the log file
$logFile = "logs.txt"
$networkName = Get-NetConnectionProfile | Where {$_.IPv4Connectivity -eq "Internet"} | Select -ExpandProperty Name
$counter = 0;
$asciiCount = 0;

$ascii = @(
	'        ____        ', 
	' /  |  |    |  /  | ', 
	'/___|_ |    | /___|_', 
	'    |  |    |     | ', 
	'    |  |____|     | ', 
	'	                 ',
	'                    ',
	'                    ',
	'                    '
);

$asciiTitle = @(
	'___    __   __   __  ___  __  __  ___  __  __ ', 
	' |    |  | |  | |  |  |  |   |     |  |   |  |', 
	' |  _ |__| |__| |  |  |  |__ |__   |  |__ |__|', 
	' |    |    |\   |  |  |  |      |  |  |   |\  ', 
	'_|_   |    | \  |__|  |  |__  __|  |  |__ | \ ', 
	''
);

for ($index = 0; $index -lt $asciiTitle.count; $index++) {
	Write-Output $asciiTitle[$index];
}

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
        "$timestamp $networkName - Connected" | Out-File -Append $logFile;
		Write-Output "$timestamp $networkName - Connected";
		$counter = 0;
		$asciiCount = 0;
    } else {
		$counter++;

		$print404 = $ascii[$asciiCount];
        # If the ping failed, log "Disconnected"
		if ($counter -eq 1) {
			"$timestamp $networkName - Disconnected for approximately $counter minute." | Out-File -Append $logFile;
			Write-Output "$timestamp $networkName - Disconnected for approximately $counter minute.  $print404";
		} else {
			"$timestamp $networkName - Disconnected for approximately $counter minutes." | Out-File -Append $logFile;
			Write-Output "$timestamp $networkName - Disconnected for approximately $counter minutes. $print404";
		}
		
		if ($asciiCount -lt $ascii.count) {
			$asciiCount++;
		} else {
			$asciiCount = 0;
		}
    }

    # Wait for 60 seconds (1 minute)
    Start-Sleep -Seconds 60
}
