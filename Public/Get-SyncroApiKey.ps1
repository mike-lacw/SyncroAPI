function Get-SyncroApiKey {
	[CmdletBinding()]
	Param()
	if ($null -eq $Int_SyncroAPIKey) {
		Write-Error "No API key has been set. Please use New-SyncroAPIKey to set it."
	} else {
		$Int_SyncroAPIKey
	}
}
