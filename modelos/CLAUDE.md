# Escritório [NOME DO ESCRITÓRIO]

> Modelo do pacote Agente Contábil · por Kelvin Rocha. Copie este arquivo para a pasta onde você abre o Claude Code (por exemplo, `Escritorio/CLAUDE.md`) e troque os campos entre colchetes. O Claude Code lê este arquivo automaticamente em toda conversa aberta nessa pasta.

## Quem somos
- Escritório: [NOME] · CRC [UF-000000/O]
- Responsável técnico: [NOME], CRC [UF-000000/O]
- Cidade e UF da maioria dos clientes: [CIDADE/UF] (os agentes usam para ISS, ICMS e feriados locais)

## Como trabalhamos
- Pastas: `clientes/<cliente>/<AAAA-MM>/entradas` para o que o cliente manda e `clientes/<cliente>/<AAAA-MM>/saidas` para o que os agentes geram.
- Sistema contábil e fiscal: [Domínio / Alterdata / Questor / Fortes / Omie / outro]. Quando gerar arquivo de importação, use o layout desse sistema.
- Planilhas de saída: CSV com separador `;` e vírgula decimal (abre direto no Excel em português), mais um resumo em Markdown.
- Com o cliente: linguagem simples, sem juridiquês, sem prometer prazo de órgão público.

## Regras
- Use os agentes do pacote Agente Contábil sempre que o assunto bater com um deles. Quando houver vários arquivos misturados, comece pelo `triagem-documentos`.
- Nunca peça nem guarde senha, certificado digital ou token.
- Tudo é rascunho até a revisão do responsável técnico.
- Valores e prazos marcados [CONFIRMAR] precisam de checagem antes de qualquer envio.

## Particularidades dos clientes
- [cliente-a]: [ex.: Lucro Presumido com decisão judicial contra a LC 224/2025]
- [cliente-b]: [ex.: Simples, Anexo III com fator R, ISS fixo de sociedade uniprofissional]
- [cliente-c]: [ex.: comércio com filial em outra UF e produtos com ICMS-ST]
