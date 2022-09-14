$resp = Read-Host "Isso irá apagar todo o conteúdo do Docker, deseja continuar? (s/n)"

if ($resp -eq "s") {

    Write-Host ""
    Write-Host "Deletando containers..." -ForegroundColor Yellow
    docker stop -f $(docker ps -a -q)
    docker rm -f $(docker ps -a -q)

    Write-Host ""
    Write-Host "Deletando imagens..." -ForegroundColor Yellow
    docker rmi -f $(docker images -a -q)

    Write-Host ""
    Write-Host "Deletando volumes..." -ForegroundColor Yellow
    docker volume prune -f
    docker system prune -a -f

    Write-Host ""
    Write-Host "Docker limpo com sucesso!" -ForegroundColor DarkGreen
    Start-Sleep -s 4
}
