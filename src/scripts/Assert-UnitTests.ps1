$ErrorActionPreference = "Stop"

Import-Module Pester

$results = Invoke-Pester -PassThru
if ($results.FailedCount) {
    throw "Unit Tests failed"
}
