<##
 # Assert-ValidStyle
 ##
 # Prints all static analysis violations found in the repo and throws on violation.
 #>

# enable module installation if necessary
if (-not (Get-PackageProvider -Name "NuGet" -ErrorAction SilentlyContinue)) {
    Install-PackageProvider -Name "NuGet" -Force -Scope CurrentUser | Out-Null
}
if (-not (Get-PSRepository "PSGallery" -ErrorAction SilentlyContinue)) {
    Set-PSRepository "PSGallery" -InstallationPolicy Trusted | Out-Null
}

# install module if necessary
if (-not (Get-Module "PSScriptAnalyzer" -ListAvailable)) {
    Install-Module "PSScriptAnalyzer" -Scope CurrentUser -Force | Out-Null #-SkipPublisherCheck
}


Import-Module "PSScriptAnalyzer"


# run static analysis
$FailedTests = Invoke-ScriptAnalyzer `
    -Path "$PSScriptRoot\.." `
    -Recurse `
    -ErrorVariable scriptAnalyzerErrors
if ($FailedTests -or $scriptAnalyzerErrors) {
    # fail
    "--------------------------",
    "- Static Analysis Errors -",
    "--------------------------" `
        | % { Write-Host $_ }
    $scriptAnalyzerErrors | Out-String | % { Write-Host $_ }
    $FailedTests | Format-Table | Out-String | % { Write-Host $_ }
    throw "Failed style enforcement tests"

} else {
    # pass
    Write-Host "Script style is valid"

}
