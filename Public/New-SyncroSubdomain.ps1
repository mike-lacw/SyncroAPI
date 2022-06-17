function New-SyncroSubdomain {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $false,
			ValueFromPipeline = $true)]
		[String]
		$Subdomain
	)
		
	if (!$Subdomain) {
		Write-Host "Please enter your Syncro subdomain without the rest of the url , for example if your url is https://demo.syncromsp.com, enter demo :"
		$Subdomain = Read-Host
	}

	Set-Variable -Name "Int_SyncroSubdomain" -Value $Subdomain -Visibility Private -Scope script -Force

}