# Agente Contabil - por Kelvin Rocha
#   .\instalar.ps1                     instala para todos os projetos (%USERPROFILE%\.claude\agents)
#   .\instalar.ps1 -Projeto <pasta>    instala so em uma pasta (<pasta>\.claude\agents)
#   .\instalar.ps1 -Remover [-Projeto <pasta>]  remove os agentes deste pacote
param(
    [string]$Projeto,
    [switch]$Remover
)
$ErrorActionPreference = 'Stop'

$origem = Join-Path $PSScriptRoot 'agents'
$agentes = @(Get-ChildItem -Path $origem -Filter '*.md' -ErrorAction SilentlyContinue)
if ($agentes.Count -eq 0) {
    Write-Host 'Nao encontrei a pasta agents ao lado deste instalador. Rode-o de dentro da pasta descompactada.'
    exit 1
}

if ($Projeto) {
    if (-not (Test-Path -Path $Projeto -PathType Container)) {
        Write-Host "Pasta nao encontrada: $Projeto"
        exit 1
    }
    $base = (Resolve-Path -Path $Projeto).Path
} else {
    $base = $HOME
}
$destino = Join-Path (Join-Path $base '.claude') 'agents'

if ($Remover) {
    $removidos = 0
    foreach ($a in $agentes) {
        $alvo = Join-Path $destino $a.Name
        if (Test-Path -Path $alvo) {
            Remove-Item -Path $alvo
            $removidos++
        }
    }
    Write-Host "Removidos $removidos agentes de $destino"
    exit 0
}

New-Item -ItemType Directory -Force -Path $destino | Out-Null
Copy-Item -Path $agentes.FullName -Destination $destino -Force
Write-Host "Instalados $($agentes.Count) agentes em $destino"
Write-Host 'Reinicie o Claude Code e digite /agents para conferir.'
