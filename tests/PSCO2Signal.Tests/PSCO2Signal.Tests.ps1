Describe "PSCO2Signal.Tests" {
    BeforeAll {
        $module = Import-Module -Name $PSScriptRoot/../../src/PSCO2Signal/PSCO2Signal.psd1 -PassThru -Force
        $module | Should -Not -BeNullOrEmpty
        $env:SIGNALTOKEN | Should -Not -BeNullOrEmpty
    }
    Context " PSCO2Signal Base Module Tests" {
        BeforeAll {
            $getModule = Get-Module -Name PSCO2Signal
        }

        It " Should have a valid module manifest" {
            $getModule | Should -Not -BeNullOrEmpty
            $getModule | Should -BeOfType 'System.Management.Automation.PSModuleInfo'
            $getModule.RootModule | Should -Be "PSCO2Signal.psm1"
            $getModule.Version | Should -Match "^\d+\.\d+\.\d+\.\d+$"
            $getModule.GUID | Should -Not -BeNullOrEmpty
        }
    }
}
