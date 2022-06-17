function New-SyncroAPIKey {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $false,
			ValueFromPipeline = $true)]
		[String]
		$ApiKey
	)
		
	if ($ApiKey) {
		$SecApiKey = ConvertTo-SecureString $ApiKey -AsPlainText -Force
	} else {
		Write-Host "Please enter your Syncro API key, you can obtain it from https://your-syncro-subdomain.syncromsp.com/api_tokens/admin/api_keys"
		$SecApiKey = Read-Host -AsSecureString
	}
	Set-Variable -Name "Int_SyncroAPIKey" -Value $SecApiKey -Visibility Private -Scope script -Force

}