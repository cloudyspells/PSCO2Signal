<#
    .SYNOPSIS
    Get CO2 Signal value for Azure Region

    .DESCRIPTION
    Retrieves the CO2 Signal value for the specified Azure Region.

    .PARAMETER Region
    The Azure Region to get the CO2 Signal value for.

    .PARAMETER AuthToken
    The CO2 Signal API token to use for authentication.

    .EXAMPLE
    Get-CO2SignalForAzureRegion -Region "westeurope" -AuthToken $token

    .EXAMPLE
    "westeurope" | Get-CO2SignalForAzureRegion -AuthToken $token

    .NOTES
    You will need to register an account for an API token from https://www.co2signal.com/ to use this function. You will also need a connected Azure PowerShell session.

    .LINK
    https://github.com/cloudyspells/PSCO2Signal/wiki/Get-CO2SignalForAzureRegion

    .LINK
    https://docs.co2signal.com/#get-latest-by-geographic-coordinate

    .LINK
    https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-6.4.0

    .INPUTS
    System.String
    - The Azure Region to get the CO2 Signal value for.

    .OUTPUTS
    System.Management.Automation.PSObject
    - Timestamp: The timestamp of the CO2 Signal data.
    - CarbonIntensity: The carbon intensity of the electricity.
    - CarbonIntensityUnit: The unit of measure of the carbon intensity value.
    - FossilFuelPercentage: The percentage of fossil fuel used to generate electricity.
    - Region: The Azure Region.
    - CountryCode: The country location code from CO2 Signal.
#>
function Get-CO2SignalForAzureRegion {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            HelpMessage = "The Azure Region to get the CO2 Signal value for."
            )]
        [ValidateNotNullOrEmpty()]
        [string]
        $Region,

        [Parameter(
            Mandatory = $true,
            HelpMessage = "The CO2 Signal API token to use for authentication."
            )]
        [ValidateNotNullOrEmpty()]
        [string]
        $AuthToken
    )

    $location = $Script:azLocations | Where-Object { $_.Location -eq $Region }
    if ($null -eq $location) {
        throw "The specified Azure Region '$Region' was not found."
    }
    Write-Verbose "Found Azure Region: $Region"
    $lat = $location.Latitude
    $long = $location.Longitude
    Write-Verbose "Found Latitude: $lat"
    Write-Verbose "Found Longitude: $long"
    $uri = "https://api.co2signal.com/v1/latest?lat=$lat&lon=$long"
    $headers = @{
        "auth-token" = $AuthToken
    }
    Write-Verbose "Calling CO2 Signal API: $uri"
    $response = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get -ContentType "application/json"
    Write-Verbose "CO2 Signal API response: $response"
    return New-Object psobject -Property @{
        CarbonIntensity = $response.data.carbonIntensity
        CarbonIntensityUnit = $response.units.carbonIntensity
        FossilFuelPercentage = $response.data.fossilFuelPercentage
        Region = $Region
        CountryCode = $response.countryCode
        Timestamp = $response.data.datetime
    }
}

Export-ModuleMember -Function Get-CO2SignalForAzureRegion
