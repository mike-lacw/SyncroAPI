function Get-SyncroCustomers {
	[CmdletBinding()]
	Param (
		[String]$Sort = '',
		[String]$Query = '',
		[String]$FirstName = '',
		[String]$LastName = '',
		[Alias("business_name")]
		[String]$BusinessName = '',
		[String]$Email = '',
		[Switch]$Disabled = $false,
		[Int]$Id = ''
	
	)


	if ($Id) {
		$Company = Invoke-SyncroRequest -Method get -Resource "customers/$Id"
		return $Company
	} else {
	
		$ResourceFilter = ''
	
		if ($Sort) {
			$ResourceFilter = "$($ResourceFilter)&sort=$($Sort)"
		}
	
		if ($Query) {
			$ResourceFilter = "$($ResourceFilter)&query=$($Query)"
		}
	
		if ($FirstName) {
			$ResourceFilter = "$($ResourceFilter)&firstname=$($FirstName)"
		}
		
		if ($LastName) {
			$ResourceFilter = "$($ResourceFilter)&lastname=$($LastName)"
		}

		if ($BusinessName) {
			$ResourceFilter = "$($ResourceFilter)&business_name=$($BusinessName)"
		}

		if ($Email) {
			$ResourceFilter = "$($ResourceFilter)&email=$($Email)"
		}

		if ($Disabled) {
			$ResourceFilter = "$($ResourceFilter)&include_disabled=true"
		}
	
	
	
		$i = 1;
		$AllCustomers = do {
			$Customers = Invoke-SyncroRequest -Method get -Resource "customers?page=$i$($ResourceFilter)"
			$i++
			$Customers.Customers
		} while ($Customers.Customers.count % 100 -eq 0 -and $Customers.Customers.count -ne 0)
		
			
		return $AllCustomers
	
	}
}