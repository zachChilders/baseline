# This script pulls all secrets from an AzureKeyvault that you are a Service Principal on with at least READ, LIST permissions.
# After dot sourcing it ". init.ps1", all processes launched in that session will have access to your secrets as environment variables.
# This is also a good place to do initial dev setup, provided you do it idempotently.

$KeyVaultName = "KEYVAULTNAME"

Get-AzureKeyVaultSecret -VaultName $KeyVaultName `
    | % { Get-AzureKeyVaultSecret -VaultName $KeyVaultName -Name $_.Name } `
    | % { [Environment]::SetEnvironmentVariable($_.Name, $_.SecretValueText) }

# Install Requirements and import it
if (!(Get-Module "Requirements" -ListAvailable)) {
    Install-Module "Requirements" -Scope "CurrentUser" -Force
}
Import-Module "Requirements"

Invoke-ChecklistRequirement -Describe "Install Pester" `
    -Test { (Get-Module "Pester" -ListAvailable) } `
    -Set { Install-Module "Pester" -Force }

Invoke-ChecklistRequirement -Describe "Set Module Path" `
    -Test { ("./src/modules" -notin $env:PSModulePath) }
    -Set { $env:PSModulePath += ":./src/modules" }