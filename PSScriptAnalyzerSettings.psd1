@{
    Severity     = @(
        'Error',
        'Warning',
        'Information'
    )
    ExcludeRules = @(
        'PSAvoidUsingConvertToSecureStringWithPlainText',
        'PSAvoidUsingWriteHost',
        'PSUseOutputTypeCorrectly',
        'PSUseShouldProcessForStateChangingFunctions',
        "PSAvoidGlobalVars"
    )
    Rules        = @{
        PSAlignAssignmentStatement = @{
            Enable         = $true
            CheckHashtable = $true
        }
        PSAvoidUsingCmdletAliases  = @{
            # only whitelist verbs from *-Object cmdlets
            Whitelist = @(
                '%',
                '?',
                'compare',
                'foreach',
                'group',
                'measure',
                'select',
                'sort',
                'tee',
                'where',
                'Add-AzureRMAccount'
            )
        }
        PSPlaceCloseBrace          = @{
            Enable             = $false
            NoEmptyLineBefore  = $false
            IgnoreOneLineBlock = $true
            NewLineAfter       = $false
        }
        PSPlaceOpenBrace           = @{
            Enable             = $true
            OnSameLine         = $true
            NewLineAfter       = $true
            IgnoreOneLineBlock = $true
        }
        PSProvideCommentHelp       = @{
            Enable                  = $true
            ExportedOnly            = $true
            BlockComment            = $true
            VSCodeSnippetCorrection = $true
            Placement               = "before"
        }
        PSUseConsistentIndentation = @{
            Enable          = $false
            IndentationSize = 4
            Kind            = "space"
        }
        PSUseConsistentWhitespace  = @{
            Enable         = $true
            CheckOpenBrace = $true
            CheckOpenParen = $true
            CheckOperator  = $false
            CheckSeparator = $true
        }
    }
}