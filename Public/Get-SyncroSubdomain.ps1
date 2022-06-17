function Get-SyncroSubdomain {
	[CmdletBinding()]
	Param()
	if ($null -eq $Int_SyncroSubdomain) {
		Write-Error "No Subdomain has been set. Please use New-SyncroSubdomain to set it."
	} else {
		$Int_SyncroSubdomain
	}
}
