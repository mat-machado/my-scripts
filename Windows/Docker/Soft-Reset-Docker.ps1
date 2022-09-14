$resp = Read-Host "Isso irá apagar todo o conteúdo do Docker, exceto as imagens, deseja continuar? (s/n)"

if ($resp -eq "s") {
    Write-Host ""
    Write-Host "Deletando containers..." -ForegroundColor Yellow
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)

    Write-Host ""
    Write-Host "Deletando volumes..." -ForegroundColor Yellow
    docker volume prune -f

    Write-Host ""
    Write-Host "Docker limpo com sucesso!" -ForegroundColor DarkGreen
    Start-Sleep -s 4
}
