# PSCO2Signal Github Action Quickstart

This PowerShell module also comes with a _GitHub Action_ you can use in your
GitHub workflows. Again you will need a pre-existing account for _CO2signal_
and an Azure CLI/PowerShell secret configured in your repo.

## Inputs

- `azure_credential` - **Required** - Azure credential secret for azure/login
  action
- `signal_token` - **Required** - CO2Signal API token
- `regions` - **Required** - Comma separated list of Azure regions to check

## Outputs

- `region` - The Azure region with the lowest emissions
- `fosilFuelPercentage` - The percentage of energy in the region that is fossil
  fuel based

## Example

```yaml
on:
  pull_request:
    branches:
      - 'main'
      - 'releases/**'

name: Deploy to region with lowest emissions

jobs:
  deploy-to-test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2

      - name: Get CO2Signal for Azure Region
        id: co2signal
        uses: cloudyspells/PSCO2Signal@v1
        with:
          auth-token: ${{ secrets.CO2SIGNAL_TOKEN }}
          regions: 'westeurope,uksouth,northeurope,francecentral'

      - name: echo region
        run: echo ${{ steps.co2signal.outputs.region }}

      - name: Deploy to best region
        uses: azure/arm-deploy@v1
        with:
          resourceGroupName: 'my-rg'
          location: ${{ steps.co2signal.outputs.region }}
          template: 'azuredeploy.json'
          parameters: 'azuredeploy.parameters.json'
          deploymentName: 'my-deployment'
          subscriptionId: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
          credentials: ${{ secrets.AZURE_CREDENTIALS }}
```
