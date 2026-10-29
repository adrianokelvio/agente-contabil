#!/usr/bin/env bash
# Agente Contábil · por Kelvio Rocha
#   bash instalar.sh                              instala para todos os projetos (~/.claude/agents)
#   bash instalar.sh --projeto <pasta>            instala só em uma pasta (<pasta>/.claude/agents)
#   bash instalar.sh --remover [--projeto <pasta>]  remove os agentes deste pacote
set -euo pipefail
shopt -s nullglob

ORIGEM="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/agents"
DESTINO="$HOME/.claude/agents"
REMOVER=0

while [ $# -gt 0 ]; do
  case "$1" in
    --projeto)
      [ $# -ge 2 ] || { echo "Informe a pasta: --projeto <pasta>"; exit 1; }
      [ -d "$2" ] || { echo "Pasta não encontrada: $2"; exit 1; }
      DESTINO="$(cd "$2" && pwd)/.claude/agents"
      shift 2 ;;
    --remover) REMOVER=1; shift ;;
    -h|--help) sed -n '2,5p' "$0"; exit 0 ;;
    *) echo "Opção desconhecida: $1 (use --help)"; exit 1 ;;
  esac
done

AGENTES=("$ORIGEM"/*.md)
if [ ${#AGENTES[@]} -eq 0 ]; then
  echo "Não encontrei a pasta agents/ ao lado deste instalador. Rode-o de dentro da pasta descompactada."
  exit 1
fi

if [ "$REMOVER" -eq 1 ]; then
  removidos=0
  for f in "${AGENTES[@]}"; do
    alvo="$DESTINO/$(basename "$f")"
    if [ -f "$alvo" ]; then
      rm "$alvo"
      removidos=$((removidos + 1))
    fi
  done
  echo "Removidos $removidos agentes de $DESTINO"
  exit 0
fi

mkdir -p "$DESTINO"
cp "${AGENTES[@]}" "$DESTINO/"
echo "Instalados ${#AGENTES[@]} agentes em $DESTINO"
echo "Reinicie o Claude Code e digite /agents para conferir."
