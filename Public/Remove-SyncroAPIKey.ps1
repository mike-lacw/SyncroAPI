function Remove-SyncroAPIKey {
	[CmdletBinding()]
	Param()
	Set-Variable -Name "Int_SyncroAPIKey" -Value $null -Visibility Private -Scope script -Force
}