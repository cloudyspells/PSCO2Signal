Describe "Get-CO2SignalBestAzureRegion.Tests" {
    BeforeAll {
        $module = Import-Module -Name $PSScriptRoot/../../src/PSCO2Signal/PSCO2Signal.psd1 -PassThru
        $module | Should -Not -BeNullOrEmpty
        $env:SIGNALTOKEN | Should -Not -BeNullOrEmpty
    }

    Context " Get-CO2SignalBestAzureRegion with named parameters" {
        BeforeAll {
            $testCase = Get-CO2SignalBestAzureRegion -Regions "westeurope","northeurope","eastus" -AuthToken $env:SIGNALTOKEN
        }

        It " Should return a result" {
            $testCase | Should -Not -BeNullOrEmpty
        }

        It " Should return a result with the correct properties" {
            $testCase.Timestamp | Should -Not -BeNullOrEmpty
            $testCase.CarbonIntensity | Should -Not -BeNullOrEmpty
            $testCase.CarbonIntensityUnit | Should -Not -BeNullOrEmpty
            $testCase.FossilFuelPercentage | Should -Not -BeNullOrEmpty
            $testCase.Region | Should -Not -BeNullOrEmpty
            $testCase.CountryCode | Should -Not -BeNullOrEmpty
        }

        It " Should return a result with the correct property types" {
            $testCase.Timestamp | Should -BeOfType System.DateTime
            $testCase.CarbonIntensity | Should -BeOfType System.Int64
            $testCase.CarbonIntensityUnit | Should -BeOfType System.String
            $testCase.FossilFuelPercentage | Should -BeOfType System.Double
            $testCase.Region | Should -BeOfType System.String
            $testCase.CountryCode | Should -BeOfType System.String
        }

        It " Should return a result with the correct property values" {
            $testCase.CarbonIntensityUnit | Should -Be "gCO2eq/kWh"
            $testCase.Region | Should -BeIn "westeurope","northeurope","eastus"
            $testCase.FossilFuelPercentage | Should -BeLessOrEqual 100
            $testCase.FossilFuelPercentage | Should -BeGreaterOrEqual 0
        }
    }

    Context " Get-CO2SignalBestAzureRegion with pipeline parameters" {
        BeforeAll {
            $testCase = "westeurope","northeurope","eastus" | Get-CO2SignalBestAzureRegion -AuthToken $env:SIGNALTOKEN
        }

        It " Should return a result" {
            $testCase | Should -Not -BeNullOrEmpty
        }

        It " Should return a result with the correct properties" {
            $testCase.Timestamp | Should -Not -BeNullOrEmpty
            $testCase.CarbonIntensity | Should -Not -BeNullOrEmpty
            $testCase.CarbonIntensityUnit | Should -Not -BeNullOrEmpty
            $testCase.FossilFuelPercentage | Should -Not -BeNullOrEmpty
            $testCase.Region | Should -Not -BeNullOrEmpty
            $testCase.CountryCode | Should -Not -BeNullOrEmpty
        }

        It " Should return a result with the correct property types" {
            $testCase.Timestamp | Should -BeOfType System.DateTime
            $testCase.CarbonIntensity | Should -BeOfType System.Int64
            $testCase.CarbonIntensityUnit | Should -BeOfType System.String
            $testCase.FossilFuelPercentage | Should -BeOfType System.Double
            $testCase.Region | Should -BeOfType System.String
            $testCase.CountryCode | Should -BeOfType System.String
        }

        It " Should return a result with the correct property values" {
            $testCase.CarbonIntensityUnit | Should -Be "gCO2eq/kWh"
            $testCase.Region | Should -BeIn "westeurope","northeurope","eastus"
            $testCase.FossilFuelPercentage | Should -BeLessOrEqual 100
            $testCase.FossilFuelPercentage | Should -BeGreaterOrEqual 0
        }
    }
}
