#Requires -Modules Az.Resources
$context = Get-AzContext
if ($null -eq $context) {
    throw "You must be logged in to Azure to use this module."
}

$Script:azLocations = Get-AzLocation

ForEach ($functionScript in (Get-ChildItem -Path $PSScriptRoot -Filter *.ps1)) {
    . $functionScript.FullName
}

