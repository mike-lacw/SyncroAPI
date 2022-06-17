function Invoke-SyncroRequest {
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $true)]
		[string]$Method,
		[Parameter(Mandatory = $true)]
		[string]$Resource,
		[string]$Body
	)
	
	write-verbose "Method: $Method"
	write-verbose "Resource: $Resource"
	write-verbose "Body: $($Body | out-string)"
	write-verbose "Subdomain: $(Get-SyncroSubdomain)"

	
	try {
		
		$SyncroAPIKey = Get-SyncroApiKey
		$SyncroSubdomain = "https://$(Get-SyncroSubdomain).syncromsp.com/api/v1/"
		Write-Verbose "URI: $($SyncroSubdomain + $Resource)"

		if (($Method -eq "put") -or ($Method -eq "post")) {

			$SyncroResult = Invoke-RestMethod -method $method -uri $($SyncroSubdomain + $Resource) `
				-headers @{'Authorization' = (New-Object PSCredential "user", $SyncroAPIKey).GetNetworkCredential().Password; } `
				-ContentType 'application/json; charset=utf-8' -body $Body			

		} else {	
			$SyncroResult = Invoke-RestMethod -method $method -uri $($SyncroSubdomain + $Resource) `
				-headers @{'Authorization' = (New-Object PSCredential "user", $SyncroAPIKey).GetNetworkCredential().Password; } `
				-ContentType 'application/json; charset=utf-8'
		}

		

	} catch {
		if ("$_".trim() -eq "Retry later" -or "$_".trim() -eq "The remote server returned an error: (429) Too Many Requests.") {
			Write-Host "Syncro API Rate limited. Waiting 30 Seconds then trying again" -foregroundcolor red
			Start-Sleep 30
			$SyncroResult = Invoke-SyncroRequest -Method $method -Resource $resource -Body $Body
		} else {
			Write-Error "'$_'"
		}
	}
	
	return $SyncroResult
	
}