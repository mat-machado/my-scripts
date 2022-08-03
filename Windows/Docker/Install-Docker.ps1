if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit
}

Write-Host "Instalação Docker..." -ForegroundColor Green
Write-Host ""

$ChocoVersion = choco -v

if (-Not($ChocoVersion)) {
    Write-Host ""
    Write-Host "Chcolatey não instalado..."  -ForegroundColor Yellow

    Set-ExecutionPolicy Bypass -Scope Process -Force; `
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
else {
    Write-Host ""
    Write-Host "Chocolatey já instalado na versão $ChocoVersion." -ForegroundColor Green
}

$HasDocker = $null -ne (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -Match "Docker" })

if (-Not $HasDocker) {
    Write-Host ""
    Write-Host "Docker não está instalado neste equipamento."  -ForegroundColor Yellow
    Write-Host "Iniciando instalação..."  -ForegroundColor Green

    $DockerInstall = choco search docker-desktop --exact

    if ($DockerInstall -contains '*docker-desktop*') {
        choco uninstall -y docker-desktop
    }

    choco install -y docker-desktop
    Pause
}
else {
    Write-Host ""
    Write-Host "Docker já está instalado neste equipamento."  -ForegroundColor DarkGreen
    Pause
}
