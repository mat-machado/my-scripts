if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit
}

Write-Host "WSL installation..." -ForegroundColor Yellow
Write-Host ""

if ([Environment]::GetEnvironmentVariable('WSL_RESTARTED') -eq 1) {
    $BasePath = Split-Path $PSCommandPath
    Start-Process "$BasePath\configs\WSL_Update.msi" -ArgumentList '/quiet' -Wait
    Invoke-Expression 'cmd /c start powershell -Command { wsl --set-default-version 2 }'
    Copy-Item "$BasePath\configs\.wslconfig" -Destination "$ENV:UserProfile"
    [System.Environment]::SetEnvironmentVariable('WSL_RESTARTED', '0', [System.EnvironmentVariableTarget]::Machine)
    Write-Host "Finished WSL install!"
    Pause
}
else {
    $BuildNumber = [int](Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").CurrentBuildNumber

    if ($BuildNumber -lt 19041) {
        Write-Warning "Your windows version does not support WSL yet! Please use the link below and click in 'Atualizar Agora'!"
        Write-Host "https://www.microsoft.com/pt-br/software-download/windows10"
        Write-Host ""
        Pause
    }
    else {
        dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
        dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
        Write-Host ""
        Write-Warning "Please, restart your computer and run this script again!"
        [System.Environment]::SetEnvironmentVariable('WSL_RESTARTED', '1', [System.EnvironmentVariableTarget]::Machine)
        Pause
    }
}
