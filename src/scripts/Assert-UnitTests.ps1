$ErrorActionPreference = "Stop"

if (!(Get-Module "Pester" -ListAvailable)) {
    Install-Module "Pester" -Scope "CurrentUser" -Force
}
Import-Module Pester

$results = Invoke-Pester -PassThru
if ($results.FailedCount) {
    throw "Unit Tests failed"
}
