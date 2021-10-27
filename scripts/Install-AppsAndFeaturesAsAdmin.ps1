<#
.SYNOPSIS
    Installs apps and Windows features for Bill's Windows setup.
.DESCRIPTION
    Installs apps and Windows features for Bill's Windows setup.

    Primarily uses winget, but falls back to choco for a few things.
.EXAMPLE
    PS C:\> .\Install-AppsAndFeaturesAsAdmin.ps1
    Installs apps and Windows features.
.INPUTS
    None.
.OUTPUTS
    None.
.NOTES
    Requires the following prerequisites:
    
    1. "App Installer" is installed from the app store and up-to-date.
    2. Virtualization is enabled in BIOS.
    3. Script run from a shell blessed with admin powers.
#>
[CmdletBinding()]
param (
    [Parameter()]
    [Switch]
    $Personal
)

#region Install Windows Features

Write-Host "######### Install Windows Features #########" -ForegroundColor Yellow

Write-Host "Checking Hyper-V Status" -ForegroundColor Magenta

if ((Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V).State -ne [Microsoft.Dism.Commands.FeatureState]::Enabled) {
    Write-Host "Enabling Hyper-V" -ForegroundColor Magenta
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart
    Write-Host "Finished enabling Hyper-V" -ForegroundColor Magenta
} else {
    Write-Host "Hyper-V is enabled." -ForegroundColor Green
}

Write-Host "######### End Install Windows Features #########" -ForegroundColor Yellow

#endregion

#region Install Chocolatey

Write-Host "######### Install Chocolatey #########" -ForegroundColor Yellow

if ($null -eq $(Get-Command -Name choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey." -ForegroundColor Magenta

    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

    # Choco features
    choco feature enable -n=useRememberedArgumentsForUpgrades

    Write-Host "Completed installing Chocolatey." -ForegroundColor Magenta
} else {
    Write-Host "Chocolatey already installed." -ForegroundColor Green
}

Write-Host "######### End Install Chocolatey #########" -ForegroundColor Yellow

#endregion

#region Chocolatey Packages Install

Write-Host "######### Chocolatey Packages Install #########" -ForegroundColor Yellow

choco install -y (Join-Path -Path $PSScriptRoot -ChildPath "packages-$(if ($Personal) { "personal" } else { "work" }).config")

Write-Host "######### End Chocolatey Packages Install #########" -ForegroundColor Yellow

#endregion

#region Windows Package Manager Packages Install

Write-Host "######### Windows Package Manager Packages Install #########" -ForegroundColor Yellow

winget import --accept-package-agreements --accept-source-agreements -i (Join-Path -Path $PSScriptRoot -ChildPath "winget-$(if ($Personal) { "personal" } else { "work" }).json")

Write-Host "######### End Windows Package Manager Packages Install #########" -ForegroundColor Yellow

#endregion

#region Desktop Cleanup

Write-Host "######### Desktop Shortcut Cleanup #########" -ForegroundColor Yellow

$desktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
$commonDesktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonDesktopDirectory)

$shortcuts = New-Object -TypeName 'System.Collections.Generic.List[System.IO.FileSystemInfo]'

$desktopShortcuts = $desktopPath | Get-ChildItem -Filter "*.lnk"
$commonDesktopShortcuts = $commonDesktopPath | Get-ChildItem -Filter "*.lnk"

foreach ($folderShortcuts in $desktopShortcuts,$commonDesktopShortcuts) {
    if ($folderShortcuts) {
        $shortcuts.AddRange([System.Collections.Generic.List[System.IO.FileSystemInfo]]$folderShortcuts)
    }
}

$sh = New-Object -ComObject WScript.Shell

foreach($shortcut in $shortcuts) {
    $target = $sh.CreateShortcut($shortcut.FullName).TargetPath

    if ($target -like "*.exe") {
        Write-Host "Removing shortcut for $($shortcut.Name -replace '.lnk','')" -ForegroundColor Magenta

        $shortcut | Remove-Item -Force -ErrorAction Continue
    }
}

Write-Host "######### End Desktop Shortcut Cleanup #########" -ForegroundColor Yellow


#endregion

#region Check for Pending Reboots

Write-Host "######### Check for Pending Reboots #########" -ForegroundColor Yellow

# This code adapted from Adam Bertram's Test-PendingReboot script
# https://adamtheautomator.com/pending-reboot-registry/
# https://www.powershellgallery.com/packages/Test-PendingReboot/1.7/Content/Test-PendingReboot.ps1

function Test-RegistryKey {
    [OutputType('bool')]
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Key
    )

    $ErrorActionPreference = 'Stop'

    if (Get-Item -Path $Key -ErrorAction Ignore) {
        $true
    }
}

function Test-RegistryValue {
    [OutputType('bool')]
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Key,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Value
    )

    $ErrorActionPreference = 'Stop'

    if (Get-ItemProperty -Path $Key -Name $Value -ErrorAction Ignore) {
        $true
    }
}

function Test-RegistryValueNotNull {
    [OutputType('bool')]
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Key,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Value
    )

    $ErrorActionPreference = 'Stop'

    if (($regVal = Get-ItemProperty -Path $Key -Name $Value -ErrorAction Ignore) -and $regVal.($Value)) {
        $true
    }
}

$tests = @(
    { Test-RegistryKey -Key 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending' }
    { Test-RegistryKey -Key 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootInProgress' }
    { Test-RegistryKey -Key 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired' }
    { Test-RegistryKey -Key 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\PackagesPending' }
    { Test-RegistryKey -Key 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\PostRebootReporting' }
    { Test-RegistryValueNotNull -Key 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager' -Value 'PendingFileRenameOperations' }
    { Test-RegistryValueNotNull -Key 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager' -Value 'PendingFileRenameOperations2' }
    { 
        ((Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Updates' -Name 'UpdateExeVolatile' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty UpdateExeVolatile) -ne 0) -and
        ((Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Updates' -Name 'UpdateExeVolatile' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty UpdateExeVolatile) -ne $null)
    }
    { Test-RegistryValue -Key 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce' -Value 'DVDRebootSignal' }
    { Test-RegistryKey -Key 'HKLM:\SOFTWARE\Microsoft\ServerManager\CurrentRebootAttemps' }
    { Test-RegistryValue -Key 'HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon' -Value 'JoinDomain' }
    { Test-RegistryValue -Key 'HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon' -Value 'AvoidSpnSet' }
    {
        (Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName').ComputerName -ne
        (Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName').ComputerName
    }
    {
        if (Get-ChildItem -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Services\Pending') {
            $true
        }
    }
)

$rebootNeeded = $false

foreach ($test in $tests) {
    if (& $test) {
        $rebootNeeded = $true
        break
    }
}

if ($rebootNeeded) {
    Write-Host "SYSTEM HAS PENDING REBOOT" -ForegroundColor White -BackgroundColor Red
    Write-Host "If this is initial setup, it is recommended to reboot before running any further setup scripts." -ForegroundColor Magenta
} else {
    Write-Host "NO PENDING REBOOT DETECTED" -ForegroundColor White -BackgroundColor Green
}

# End code adapted from Adam Bertram's script

Write-Host "######### End Check for Pending Reboots #########" -ForegroundColor Yellow

#endregion