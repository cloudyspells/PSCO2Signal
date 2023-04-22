# PSCO2Signal PowerShell Module Quickstart

This PowerShell module is intended for retrieving emissions data from [CO2signal](https://www.co2signal.com/) for a supplied Azure Region during resource deployments. This is a lightweight solution making use of only the limited functionality available with a free account at _CO2signal_. This means the module is only able to get near-realtime emissions data and no prodictive values. This means this module is _not_ a real solution for reduced carbon deployments and -software. It _does_ however provide some nice realtime values so you can simulate the beheaviour of deployments and software based on emissions data without the cost of a paid account for such data. For example in lab- or proof of concept environments.

## Usage

### PowerShell Module

To get started with this module you will need an account on [CO2signal](https://www.co2signal.com/). See the website for details on registering and the conditions that apply.

Once you have an account, you will need to create an API token. This can be done in the _API_ section of your account. You will need to copy the token and store it in a secure location. You will need to supply this token to the module when you use it.

The module is available on the [PowerShell Gallery](https://www.powershellgallery.com/packages/PSCO2Signal/). You can install it using the following command:

```console
PS C:\> Install-Module -Name PSCO2Signal
```

Once installed, you can import the module using the following command:

```console
PS C:\> Import-Module -Name PSCO2Signal
```

#### Get current percentage of energy with emissions for the 'westeurope' Azure region:

```console
PS C:\> Get-CO2SignalForAzureRegion -Region westeurope -AuthToken $token

Region               : westeurope
FossilFuelPercentage : 29.37
CountryCode          : NL
CarbonIntensity      : 231
CarbonIntensityUnit  : gCO2eq/kWh
Timestamp            : 3/26/2023 8:00:00 AM

```

#### Determine the lowest emissions for the list of northeurope, westeurope, francecentral and uksouth Azure regions:

```console
PS C:\> Get-CO2SignalBestAzureRegion -Regions westeurope,uksouth,northeurope,francecentral -AuthToken $token

Region               : westeurope
FossilFuelPercentage : 29.37    
CountryCode          : NL
CarbonIntensity      : 231
CarbonIntensityUnit  : gCO2eq/kWh
Timestamp            : 3/26/2023 8:00:00 AM

```
