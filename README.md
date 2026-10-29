<div align="center">

# Agente Contábil

**50 agentes de IA para escritórios de contabilidade, prontos para usar no Claude Code**

Fiscal · Obrigações e SPED · Departamento Pessoal · Contabilidade · IRPF · Societário · Consultoria

Criado por **Kelvin Rocha**

![Agentes](https://img.shields.io/badge/agentes-50-1f6feb) ![Claude Code](https://img.shields.io/badge/Claude%20Code-subagentes-d97757) ![Legislação](https://img.shields.io/badge/legisla%C3%A7%C3%A3o-out%2F2026-2da44e) ![Licença](https://img.shields.io/badge/licen%C3%A7a-MIT-lightgrey)

</div>

> [!IMPORTANT]
> Os agentes entregam **rascunhos técnicos**. Revise antes de transmitir declaração, emitir guia ou orientar o cliente. A responsabilidade técnica continua sendo do contador (CRC).

## Sumário

1. [O que é](#o-que-é)
2. [Antes de começar](#antes-de-começar)
3. [Instalação com os arquivos baixados (ZIP)](#instalação-com-os-arquivos-baixados-zip)
4. [Primeiro uso](#primeiro-uso)
5. [Como organizar os arquivos do cliente](#como-organizar-os-arquivos-do-cliente)
6. [Que tipo de arquivo anexar](#que-tipo-de-arquivo-anexar)
7. [Modelo de prompt](#modelo-de-prompt)
8. [Catálogo: os 50 agentes com prompt pronto](#catálogo-os-50-agentes-com-prompt-pronto)
9. [Fluxos prontos](#fluxos-prontos)
10. [Segurança e LGPD](#segurança-e-lgpd)
11. [Atualizar, personalizar e desinstalar](#atualizar-personalizar-e-desinstalar)
12. [Perguntas frequentes](#perguntas-frequentes)
13. [Autor e licença](#autor-e-licença)

## O que é

O **Agente Contábil** é um pacote de 50 especialistas para o [Claude Code](https://claude.com/claude-code). Cada um conhece a fundo uma rotina do escritório: apurar o DAS, calcular uma rescisão, conciliar o banco, montar a ECF, revisar o IRPF, abrir uma empresa, responder uma intimação.

Na prática, você fala com o Claude como falaria com um colega, anexa os arquivos do cliente, e ele chama o especialista certo. O agente:

- **lê os arquivos** (XML, planilhas, OFX, SPED, PDF);
- **faz as contas em Python**, nunca de cabeça, e mostra a memória de cálculo;
- **entrega arquivos prontos** na pasta `saidas/` do cliente (CSV, resumo, checklist);
- **marca com [CONFIRMAR]** todo valor, prazo ou código que precisa de checagem na fonte oficial;
- **avisa o que falta** com uma lista curta ("Preciso de:"), em vez de inventar.

```
agente-contabil/
├── agents/          ← os 50 agentes (é esta pasta que você instala)
├── modelos/
│   └── CLAUDE.md    ← modelo de configuração do seu escritório (opcional)
├── instalar.sh      ← instalador para macOS e Linux
├── instalar.ps1     ← instalador para Windows
├── CHANGELOG.md
├── LICENSE
└── README.md
```

## Antes de começar

| Você precisa de | Como conseguir |
|---|---|
| **Claude Code** (terminal, app desktop ou extensão do VS Code) | Instale pelo site oficial: [claude.com/claude-code](https://claude.com/claude-code). Exige uma conta Claude com acesso ao Claude Code. |
| **Python 3** | Os agentes fazem as contas em Python. macOS e Linux geralmente já têm; no Windows, instale em [python.org](https://www.python.org/downloads/) marcando "Add Python to PATH". |
| **pandas e openpyxl** (para ler Excel) | No terminal: `pip install pandas openpyxl` |

## Instalação com os arquivos baixados (ZIP)

### 1. Baixe o pacote

Nesta página do GitHub, clique no botão verde **Code** → **Download ZIP** e descompacte o arquivo. Vai aparecer a pasta `agente-contabil-main`, com a subpasta `agents/` e os 50 arquivos `.md`.

### 2. Escolha onde instalar

| Opção | Pasta de destino | Quando usar |
|---|---|---|
| **Para todos os projetos** (recomendado) | macOS/Linux: `~/.claude/agents/`<br>Windows: `%USERPROFILE%\.claude\agents\` | Você abre o Claude Code em várias pastas |
| **Só em uma pasta** | `<sua-pasta>/.claude/agents/` | Quer os agentes só na pasta do escritório |

### 3. Copie os agentes (escolha um jeito)

**Jeito A: instalador, um comando só**

macOS ou Linux: abra o Terminal dentro da pasta descompactada e rode:

```bash
bash instalar.sh
```

Windows: abra o PowerShell dentro da pasta descompactada e rode:

```powershell
powershell -ExecutionPolicy Bypass -File .\instalar.ps1
```

Para instalar só em uma pasta, acrescente o caminho: `bash instalar.sh --projeto ~/Escritorio` ou `.\instalar.ps1 -Projeto C:\Escritorio`.

**Jeito B: comandos manuais**

macOS ou Linux (supondo que o ZIP foi descompactado em Downloads):

```bash
mkdir -p ~/.claude/agents
cp ~/Downloads/agente-contabil-main/agents/*.md ~/.claude/agents/
```

Windows (PowerShell):

```powershell
New-Item -ItemType Directory -Force "$env:USERPROFILE\.claude\agents" | Out-Null
Copy-Item "$env:USERPROFILE\Downloads\agente-contabil-main\agents\*.md" "$env:USERPROFILE\.claude\agents\"
```

**Jeito C: sem terminal (arrastar e soltar)**

- **macOS:** no Finder, aperte `Cmd + Shift + G`, digite `~/.claude` e dê Enter. Crie a pasta `agents` se ela não existir e arraste para dentro os 50 arquivos da pasta `agents/` baixada. (Para ver pastas ocultas: `Cmd + Shift + .`)
- **Windows:** no Explorador de Arquivos, digite `%USERPROFILE%\.claude` na barra de endereço e dê Enter. Crie a pasta `agents` se ela não existir e cole os 50 arquivos dentro.

### 4. Reinicie e confira

Feche e abra o Claude Code de novo, porque os agentes são carregados quando a sessão começa. Depois digite:

```text
/agents
```

A lista deve mostrar os agentes `fiscal-…`, `dp-…`, `contabil-…`, `irpf-…` e os demais. Se não aparecerem, veja as [perguntas frequentes](#perguntas-frequentes).

<details>
<summary><b>Prefere usar git?</b></summary>

```bash
git clone https://github.com/adrianokelvio/agente-contabil.git
cd agente-contabil
bash instalar.sh
```

Para atualizar depois: `git pull && bash instalar.sh`.

</details>

## Primeiro uso

1. Crie uma pasta de trabalho, por exemplo `Escritorio/clientes/padaria-exemplo/2026-10/entradas/`, e coloque nela os arquivos do cliente.
2. Abra o Claude Code na pasta `Escritorio` (no terminal: `cd Escritorio` e depois `claude`; no app: abra a pasta).
3. Escolha um agente no [catálogo](#catálogo-os-50-agentes-com-prompt-pronto), copie o prompt pronto, troque os `[CAMPOS]` e anexe os arquivos com `@`.
4. O resultado aparece na conversa e os arquivos ficam em `saidas/`, dentro da pasta do cliente.

Exemplo real de pedido:

```text
Use o agente fiscal-simples-nacional para apurar o DAS de 10/2026 da Padaria Exemplo LTDA, CNPJ [00.000.000/0001-00].
Atividade: comércio (Anexo I), com produtos sujeitos a ICMS-ST.
Arquivos: @clientes/padaria-exemplo/2026-10/entradas/
Quero a memória de cálculo em CSV e um resumo para conferir no PGDAS-D.
```

## Como organizar os arquivos do cliente

```
Escritorio/
├── CLAUDE.md                 ← opcional: regras do seu escritório (copie de modelos/CLAUDE.md)
└── clientes/
    └── padaria-exemplo/
        ├── cadastro/         ← contrato social, cartão CNPJ, procurações
        └── 2026-10/
            ├── entradas/     ← o que o cliente mandou (XML, XLSX, OFX, PDF...)
            └── saidas/       ← o que os agentes geram (CSV, resumos, scripts)
```

- Uma pasta por competência (`AAAA-MM`) deixa o histórico organizado e facilita comparar meses.
- Não renomeie nem edite os XMLs: o agente usa a chave e os campos originais.
- Mande as planilhas no formato original. Planilha colada como imagem perde precisão.
- O arquivo `CLAUDE.md` na raiz é lido automaticamente pelo Claude Code. Use o [modelo](modelos/CLAUDE.md) para informar CRC, cidade, sistema contábil e particularidades dos clientes.

## Que tipo de arquivo anexar

| Formato | Exemplos | Dica |
|---|---|---|
| **XML** | NF-e, NFC-e, CT-e, NFS-e | Melhor formato para notas fiscais: o agente lê todos os campos. Anexe a pasta inteira. |
| **XLSX ou CSV** | Faturamento, folha, balancete, razão, contas a pagar e a receber | Uma tabela por aba, com cabeçalho na primeira linha. |
| **OFX** | Extrato bancário | Melhor que PDF para conciliação. Baixe no internet banking. |
| **TXT do SPED** | EFD ICMS/IPI, EFD-Contribuições, ECD, ECF | Use o arquivo validado ou transmitido pelo PVA. |
| **PDF** | DAS, DARF, extrato do PGDAS-D, informe de rendimentos, relatório de situação fiscal, contrato social, holerite | PDF com texto selecionável funciona melhor que documento escaneado. |
| **JPG ou PNG** | Foto de recibo, nota ou comprovante | Use quando não houver outra opção e confira os valores lidos. |
| **DOCX** | Contratos, atas, intimações | Se der erro de leitura, salve como PDF. |

> [!CAUTION]
> **Nunca anexe** certificado digital (`.pfx`/`.p12`), senhas (e-CAC, gov.br, prefeitura, banco), tokens ou códigos de acesso. Nenhum agente precisa disso.

Cada agente do catálogo abaixo informa **exatamente quais arquivos anexar**.

## Modelo de prompt

Esta estrutura funciona com qualquer agente:

```text
Use o agente [nome-do-agente] para [tarefa] da [EMPRESA], CNPJ [00.000.000/0001-00], competência [MM/AAAA].
Contexto: [regime tributário, atividade, particularidades do cliente].
Arquivos: @clientes/[cliente]/[AAAA-MM]/entradas/
Quero: [memória de cálculo, resumo para o cliente, checklist, minuta...].
Salve em: clientes/[cliente]/[AAAA-MM]/saidas/
```

**Dicas que fazem diferença**

- **Diga o nome do agente** para garantir que ele seja usado. Sem o nome, o Claude escolhe pelo assunto. Também funciona bem, mas é menos previsível.
- **`@` anexa arquivo ou pasta.** Digite `@` e comece a escrever o caminho para o Claude Code completar.
- **Contexto evita retrabalho:** regime, atividade, UF/município, se tem ST, filial, liminar, funcionários.
- **Quando a resposta começar com "Preciso de:"**, responda só aqueles itens e peça para continuar.
- **[CONFIRMAR]** quer dizer "confira na fonte oficial antes de usar". Não ignore.
- **Encadeie agentes:** "Use o agente triagem-documentos na pasta @entradas/ e depois chame os agentes que ele indicar."

## Catálogo: os 50 agentes com prompt pronto

Clique em uma área para ver os agentes, os arquivos que cada um precisa e o prompt pronto para copiar.

| Área | Agentes |
|---|---|
| **Comece por aqui** | `triagem-documentos` |
| **Regimes e apuração** | `fiscal-simples-nacional` · `fiscal-mei` · `fiscal-lucro-presumido` · `fiscal-lucro-real` |
| **Tributos** | `fiscal-pis-cofins` · `fiscal-icms` · `fiscal-ipi` · `fiscal-iss` · `fiscal-retencoes-federais` · `fiscal-auditoria-xml` |
| **Obrigações acessórias e SPED** | `obrigacoes-calendario` · `obrigacoes-dctfweb-reinf` · `obrigacoes-efd-icms-ipi` · `obrigacoes-efd-contribuicoes` · `obrigacoes-ecd-ecf` · `obrigacoes-declaracoes-anuais` |
| **Departamento Pessoal** | `dp-admissao` · `dp-folha-mensal` · `dp-ferias-13` · `dp-rescisao` · `dp-afastamentos-sst` · `dp-encargos-fgts` · `dp-pro-labore-autonomos` |
| **Contabilidade** | `contabil-plano-e-lancamentos` · `contabil-conciliacoes` · `contabil-conciliacao-cartoes` · `contabil-estoques-cmv` · `contabil-imobilizado` · `contabil-fechamento-mensal` · `contabil-demonstracoes` |
| **Consultoria e planejamento** | `consultoria-planejamento-tributario` · `consultoria-reforma-tributaria` · `consultoria-lucros-dividendos` · `consultoria-gestao-financeira` · `consultoria-precificacao` · `consultoria-due-diligence-valuation` |
| **Imposto de Renda Pessoa Física** | `irpf-declaracao-anual` · `irpf-ganho-capital` · `irpf-investimentos` · `irpf-carne-leao` · `irpf-malha-fina` |
| **Societário** | `societario-abertura` · `societario-alteracao` · `societario-baixa` |
| **Regularidade, defesa e créditos** | `regularidade-fiscal` · `regularidade-defesa-fiscal` · `regularidade-recuperacao-creditos` |
| **Escritório e atendimento** | `escritorio-novo-cliente` · `escritorio-comunicacao-cliente` |

<details>
<summary><b>Comece por aqui</b> · 1 agente</summary>

#### `triagem-documentos` · Triagem de documentos

**O que faz:** identifica cada arquivo da pasta do cliente pelo conteúdo (XML, OFX, SPED, guias, certidões, planilhas) e gera inventário com tipo, CNPJ mascarado, competência e o agente certo para cada um.

**Arquivos para anexar:** pasta ou ZIP com os documentos do mês (XML, OFX, TXT do SPED, PDF, XLSX, CSV, JPG/PNG, ZIP) · lista do que o cliente costuma enviar (TXT ou CSV, opcional)

```text
Use o agente triagem-documentos para inventariar os documentos de [MÊS/AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Regime: [MEI / Simples Nacional / Lucro Presumido / Lucro Real]. Filiais: [CNPJs ou "não tem"].
O que costuma vir todo mês: [ex.: XMLs de saída e de entrada, extratos de 2 bancos, folha, guias].
Organizar em entradas/AAAA-MM/<tipo>/? [só propor / pode copiar, sem mover os originais]
Arquivos: @entradas/recebidos/ @entradas/[lote-do-cliente].zip
Quero o inventário em CSV, a lista do que falta e qual agente usar em cada arquivo.
```

</details>

<details>
<summary><b>Regimes e apuração</b> · 4 agentes</summary>

#### `fiscal-simples-nacional` · Simples Nacional (DAS e PGDAS-D)

**O que faz:** calcula e confere o DAS do mês como o PGDAS-D: anexo, RBT12, alíquota efetiva, fator R e segregação de ST, monofásico, ISS retido, exportação e locação, com teste de sublimite e teto.

**Arquivos para anexar:** receita dos 12 meses anteriores e do mês (XLSX/CSV) · XMLs de saída e de compra do mês (XML) · folha dos 12 meses anteriores (XLSX/PDF) · extrato do PGDAS-D (PDF)

```text
Use o agente fiscal-simples-nacional para calcular o DAS de [MM/AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Atividades: [comércio / indústria / serviços: quais]. Abertura em [DD/MM/AAAA]. UF e município: [UF / cidade].
Regime de reconhecimento: [competência / caixa]. Revende produtos com ICMS-ST ou monofásicos? [sim/não]
Tem ISS retido, exportação ou locação de bens móveis? [sim/não: quais]
Arquivos: @entradas/receitas_12m.xlsx @entradas/folha_12m.xlsx @entradas/extrato_pgdas.pdf @entradas/xml/
Quero a memória por linha de segregação, o fator R e o DAS conferido com o PGDAS-D.
```

#### `fiscal-mei` · MEI

**O que faz:** confere se o cliente pode seguir como MEI, testa o limite do ano (com a LC 238/2026), calcula DAS-MEI e excesso, prepara a DASN-SIMEI e conduz o desenquadramento para ME.

**Arquivos para anexar:** CCMEI (PDF) · relatório mensal de receitas ou extratos bancários e da maquininha (XLSX/CSV/OFX) · notas emitidas (XML/PDF) · extrato do PGMEI (PDF)

```text
Use o agente fiscal-mei para revisar o ano de [AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Ocupação no CCMEI: [descrição]. Abertura em [DD/MM/AAAA]. Vende ou presta serviço para empresas (CNPJ)? [sim/não]
Tem empregado? [não / sim: salário R$ [valor], função [função]]. É transportador autônomo de cargas? [sim/não]
Arquivos: @entradas/ccmei.pdf @entradas/receitas_mensais.xlsx @entradas/extrato_pgmei.pdf @entradas/notas/
Quero o teste do limite com projeção até dezembro, os DAS em aberto, a DASN-SIMEI e, se for o caso, o plano de desenquadramento.
```

#### `fiscal-lucro-presumido` · Lucro Presumido

**O que faz:** apura IRPJ e CSLL do trimestre e PIS/COFINS do mês, com memória de cálculo, códigos de DARF e o teste dos R$ 5 milhões da LC 224/2025.

**Arquivos para anexar:** faturamento por mês e por atividade (XLSX/CSV) · XMLs das notas emitidas (XML) · balancete ou razão das receitas (PDF/XLSX) · comprovantes de retenção (PDF)

```text
Use o agente fiscal-lucro-presumido para apurar o [1º/2º/3º/4º] trimestre de [AAAA] da [RAZÃO SOCIAL], CNPJ [00.000.000/0001-00].
Atividades: [serviços / comércio / indústria; se for misto, informe a divisão].
Receita bruta acumulada no ano até o trimestre anterior: R$ [valor]. Tem decisão judicial sobre a LC 224/2025? [sim/não]
Arquivos: @entradas/faturamento.xlsx @entradas/balancete.pdf @entradas/xml/
Quero a memória de cálculo em CSV e o resumo com DARFs e vencimentos.
```

#### `fiscal-lucro-real` · Lucro Real

**O que faz:** apura IRPJ e CSLL no Lucro Real trimestral ou por estimativa, com adições, exclusões, compensação limitada a 30%, parte B do e-Lalur/e-Lacs, balancete de suspensão e teto de JCP.

**Arquivos para anexar:** balancete do período (XLSX/PDF) · razão das contas de despesa (XLSX/CSV) · parte B ou ECF anterior (XLSX/TXT do SPED) · DARFs de estimativa e comprovantes de retenção (PDF)

```text
Use o agente fiscal-lucro-real para apurar o [1º/2º/3º/4º trimestre ou mês de estimativa] de [AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Forma de apuração: [trimestral / anual por estimativa]. Saldo de prejuízo fiscal: R$ [valor]; base negativa de CSLL: R$ [valor].
Vai creditar JCP no período? [não / sim: PL por conta e TJLP no anexo]
Arquivos: @entradas/balancete.xlsx @entradas/razao_despesas.csv @entradas/parte_b.xlsx @entradas/darfs/
Quero a memória de cálculo, a parte B atualizada e o quadro de DARFs com vencimentos.
```

</details>

<details>
<summary><b>Tributos</b> · 6 agentes</summary>

#### `fiscal-pis-cofins` · PIS e COFINS

**O que faz:** apura PIS e COFINS cumulativos e não cumulativos com créditos de insumos, monofásico, exclusão do ICMS, rateio e controle do saldo credor, item a item.

**Arquivos para anexar:** XMLs de entrada e saída (XML) · razão de receitas, custos e despesas (XLSX/CSV) · relação do imobilizado (XLSX) · EFD-Contribuições (TXT do SPED) · descrição do processo produtivo (PDF/DOCX) · decisões judiciais, se houver (PDF)

```text
Use o agente fiscal-pis-cofins para apurar PIS e COFINS de [MM/AAAA] da [RAZÃO SOCIAL], CNPJ [00.000.000/0001-00].
Regime: [Lucro Real não cumulativo / Lucro Presumido cumulativo]. Atividade: [indústria / comércio / serviços].
Revende produtos monofásicos? [sim/não; quais]. Tem ação judicial sobre PIS/COFINS? [não / sim: tese e nº do processo]
Saldo credor do mês anterior: PIS R$ [valor] · COFINS R$ [valor].
Arquivos: @entradas/xml/ @entradas/razao.xlsx @entradas/imobilizado.xlsx @entradas/efd-contribuicoes.txt
Quero a apuração em CSV, a planilha de insumos com o critério de cada item e o resumo com DARFs e vencimentos.
```

#### `fiscal-icms` · ICMS, ST e DIFAL

**O que faz:** apura o ICMS próprio e confere ST (MVA original e ajustada), DIFAL, alíquota interestadual e CIAP nota a nota, marcando as regras que dependem da UF.

**Arquivos para anexar:** XMLs de entrada e saída (XML) · EFD ICMS/IPI (TXT do SPED) · guias GNRE e estaduais pagas (PDF) · cadastro de produtos com NCM e CEST (XLSX/CSV) · ficha do imobilizado (XLSX)

```text
Use o agente fiscal-icms para apurar o ICMS de [MM/AAAA] da [RAZÃO SOCIAL], CNPJ [00.000.000/0001-00], IE [número], UF [UF].
Atividade: [indústria / atacado / varejo]. Vende para outras UFs? [não / sim: quais e se para consumidor final].
Tem inscrição de substituto tributário em outra UF ou benefício fiscal? [não / sim: qual]
Arquivos: @entradas/xml/ @entradas/sped-fiscal.txt @entradas/guias/ @entradas/produtos.xlsx
Quero a apuração do mês, a planilha de ST e DIFAL nota a nota e a lista do que foi pago a mais ou a menos.
```

#### `fiscal-ipi` · IPI

**O que faz:** enquadra a operação no RIPI, confere NCM e alíquota na TIPI, apura débitos e créditos do IPI e mostra o reflexo no ICMS e a transição de 2027.

**Arquivos para anexar:** XMLs de entrada e saída (XML) · ficha técnica ou descrição do processo (XLSX/PDF) · EFD ICMS/IPI (TXT do SPED) · contratos de industrialização por encomenda (PDF) · declarações de importação (PDF/XML)

```text
Use o agente fiscal-ipi para apurar o IPI de [MM/AAAA] da [RAZÃO SOCIAL], CNPJ [00.000.000/0001-00].
O estabelecimento: [fabrica / importa e revende / manda industrializar por terceiros]. Principais produtos e NCM: [lista].
Industrializa por encomenda? [não / sim: para quem ou de quem]. Saldo credor do mês anterior: R$ [valor].
Arquivos: @entradas/xml/ @entradas/sped-fiscal.txt @entradas/ficha-tecnica.xlsx @entradas/contratos/
Quero a apuração, as divergências de NCM contra a TIPI e um resumo do que muda para a empresa em 2027.
```

#### `fiscal-iss` · ISS

**O que faz:** enquadra o serviço na LC 116/2003, define o município competente e quem recolhe, calcula o ISS nota a nota e aponta retenção indevida e bitributação.

**Arquivos para anexar:** NFS-e emitidas e tomadas (XML/PDF) · contratos de serviço (PDF/DOCX) · contrato social e inscrição municipal (PDF) · lei do ISS do município (PDF) · guias e declarações municipais (PDF/XLSX)

```text
Use o agente fiscal-iss para analisar o ISS de [MM/AAAA] da [RAZÃO SOCIAL], CNPJ [00.000.000/0001-00], estabelecida em [MUNICÍPIO/UF].
Serviços prestados: [descrição]. Onde são executados: [municípios]. Optante do Simples? [sim/não].
Sociedade de profissionais com ISS fixo? [sim/não]. Algum município cobra o mesmo serviço? [não / sim: quais]
Arquivos: @entradas/nfse/ @entradas/contratos/ @entradas/lei-iss.pdf
Quero o quadro por município com ISS devido, retido e a recolher, e o parecer sobre local de incidência e retenção.
```

#### `fiscal-retencoes-federais` · Retenções federais

**O que faz:** calcula IRRF, CSRF, INSS e ISS retidos em cada nota de serviço, com dispensas e regras do Simples, e prepara guias e linhas da EFD-Reinf.

**Arquivos para anexar:** notas de serviço tomadas ou emitidas (XML/PDF) · contratos de terceirização (PDF/DOCX) · consulta do fornecedor no Simples (PDF) · relatório de pagamentos (XLSX/CSV) · recibos da EFD-Reinf (XML/PDF)

```text
Use o agente fiscal-retencoes-federais para conferir as retenções das notas de [MM/AAAA] da [RAZÃO SOCIAL], CNPJ [00.000.000/0001-00].
Lado: [serviços tomados / serviços prestados / ambos]. Regime do cliente: [Simples / Presumido / Real].
Há contratos de limpeza, vigilância, obra ou mão de obra? [não / sim: quais]. Algum tomador é órgão público? [não / sim: federal, estadual ou municipal]
Arquivos: @entradas/notas/ @entradas/contratos/ @entradas/pagamentos.xlsx
Quero a nota a nota com bruto, retenções e líquido, os DARFs com vencimento e as linhas para R-2010 e R-4020.
```

#### `fiscal-auditoria-xml` · Auditoria de XML

**O que faz:** confere lotes de XML de NF-e e NFC-e (CFOP, CST/CSOSN, NCM, alíquotas e IBS/CBS de 2026) e aponta duplicadas, buracos de numeração e canceladas no faturamento, numa planilha de achados.

**Arquivos para anexar:** XMLs das notas, eventos e inutilizações (XML) · faturamento com chave de acesso (CSV/XLSX) · EFD ICMS/IPI do período, se houver (TXT do SPED) · cadastro de produtos com NCM (XLSX/CSV)

```text
Use o agente fiscal-auditoria-xml para auditar as notas de [MM/AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Regime: [Simples / Presumido / Real]. UF do estabelecimento: [UF].
Auditar: [emitidas / recebidas / ambas]. Atenção especial a: [canceladas no faturamento / numeração / IBS e CBS].
Arquivos: @entradas/xml/ @entradas/faturamento.csv @entradas/efd_icms_ipi.txt
Quero a planilha de achados com gravidade e correção sugerida e um resumo das pendências.
```

</details>

<details>
<summary><b>Obrigações acessórias e SPED</b> · 6 agentes</summary>

#### `obrigacoes-calendario` · Calendário de obrigações

**O que faz:** monta a agenda do mês por cliente e regime (guias, declarações, DP, SPED e anuais), já antecipando ou prorrogando cada prazo que cai em fim de semana ou feriado, e marca o que varia por UF e município.

**Arquivos para anexar:** carteira de clientes com regime e perfil (XLSX/CSV) · cartões CNPJ (PDF) · prazos locais de ICMS e ISS e feriados municipais (CSV, opcional)

```text
Use o agente obrigacoes-calendario para montar a agenda de [MÊS/AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00] (ou da carteira inteira).
Regime: [MEI / Simples / Presumido / Real trimestral / Real anual]. Tem empregados ou pró-labore? [sim/não]. Sofre ou faz retenções? [sim/não]
Contribuinte de: [ICMS na UF __ / ISS no município __ / IPI / nenhum]. Prazos locais que já sei: [ex.: ISS dia 10].
Feriados estaduais ou municipais no mês: [datas ou "não sei"].
Arquivos: @entradas/carteira-clientes.xlsx @entradas/cartoes-cnpj/
Quero o calendário em CSV por data, com o ajuste de cada prazo e a lista do que ficou [CONFIRMAR].
```

#### `obrigacoes-dctfweb-reinf` · DCTFWeb e EFD-Reinf

**O que faz:** prepara e confere a EFD-Reinf e a DCTFWeb (eSocial, Reinf e MIT), concilia retido nas notas × declarado × DARF pago e aponta o que corrigir na origem.

**Arquivos para anexar:** notas com retenção (XML/PDF/CSV) · pagamentos a pessoas físicas e jurídicas (XLSX/CSV) · relatórios da Reinf e do eSocial (PDF/CSV) · relatório da DCTFWeb (PDF/CSV) · DARFs pagos (PDF/CSV)

```text
Use o agente obrigacoes-dctfweb-reinf para conferir a DCTFWeb e a EFD-Reinf de [MM/AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Regime: [Simples / Presumido / Real]. Tem folha no eSocial? [sim / não]. Recolhe CPRB? [sim / não].
Situação: [a declarar / já transmitida, só conferir / DARF pago com divergência].
Arquivos: @entradas/retencoes_notas.csv @entradas/reinf/ @entradas/dctfweb_debitos.csv @entradas/darf_pagos.csv
Quero a conciliação notas × Reinf × DCTFWeb × DARF por tributo e a lista de correções na origem.
```

#### `obrigacoes-efd-icms-ipi` · EFD ICMS/IPI (SPED Fiscal)

**O que faz:** confere e valida a EFD ICMS/IPI: documentos × XMLs, C190 × E110, ST, IPI, CIAP, inventário e bloco K, com plano de correção dos erros do PVA.

**Arquivos para anexar:** arquivo da EFD (TXT do SPED) · relatório de erros do PVA ou recibo (PDF/TXT/PNG) · XMLs do período (XML) · livro de apuração do ICMS e do IPI (PDF/XLSX) · inventário (XLSX/CSV)

```text
Use o agente obrigacoes-efd-icms-ipi para conferir a EFD ICMS/IPI de [MM/AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
UF: [UF]. Perfil: [A/B/C]. Atividade: [indústria / comércio / misto]. Entrega bloco K? [sim / não / não sei].
Situação: [arquivo original / retificação de período entregue em DD/MM/AAAA].
Arquivos: @entradas/efd_icms_ipi.txt @entradas/relatorio_pva.pdf @entradas/xml/
Quero a conferência C190 × E110, a lista de pendências do PVA com a correção e o que falta para transmitir.
```

#### `obrigacoes-efd-contribuicoes` · EFD-Contribuições

**O que faz:** confere a EFD-Contribuições (blocos A, C, D, F, M, P e 1): documentos × bloco M, saldos de crédito (1100/1500), regime de caixa do Presumido, prazo e dispensa.

**Arquivos para anexar:** arquivo da EFD-Contribuições (TXT do SPED) · EFD do mês anterior (TXT do SPED) · memória de PIS/COFINS (XLSX/PDF) · relatório da DCTFWeb e DARFs (PDF) · balancete (XLSX/PDF)

```text
Use o agente obrigacoes-efd-contribuicoes para conferir a EFD-Contribuições de [MM/AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Regime: [Lucro Real (não cumulativo) / Presumido (cumulativo) / misto]. Se Presumido, regime de [caixa / competência].
Recolhe CPRB? [sim / não]. Saldo de crédito do mês anterior: R$ [valor ou "ver EFD anterior"].
Arquivos: @entradas/efd_contribuicoes.txt @entradas/efd_contribuicoes_mes_anterior.txt @entradas/apuracao_pis_cofins.xlsx
Quero a conferência do bloco M contra os documentos, as divergências com o MIT e o DARF e o que corrigir antes de transmitir.
```

#### `obrigacoes-ecd-ecf` · ECD e ECF

**O que faz:** confere a ECD (saldos do I155, lançamentos, demonstrações, assinaturas e substituição) e a ECF por forma de tributação, com cruzamentos e prazos.

**Arquivos para anexar:** ECD (TXT do SPED) · ECD e ECF do ano anterior (TXT do SPED) · balancete anual (XLSX/PDF) · DARFs de IRPJ e CSLL (PDF) · informes de rendimentos recebidos (PDF) · distribuições a sócios (XLSX)

```text
Use o agente obrigacoes-ecd-ecf para conferir a ECD e a ECF do ano-calendário [AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Forma de tributação: [Lucro Real anual / Real trimestral / Presumido / imune ou isenta]. Distribuiu lucro acima da presunção? [sim / não].
Situação: [primeira entrega / substituição da ECD transmitida em DD/MM/AAAA]. Evento especial no ano: [não / qual e data].
Arquivos: @entradas/ecd.txt @entradas/ecd_ano_anterior.txt @entradas/balancete_anual.xlsx @entradas/darfs/
Quero o relatório do I155, os cruzamentos ECD × ECF × DARF e a lista do que corrigir antes de transmitir.
```

#### `obrigacoes-declaracoes-anuais` · Declarações anuais

**O que faz:** monta o checklist anual por cliente (DEFIS, DASN-SIMEI, DIMOB, DMED, comprovantes de rendimentos, situação de DIRF e RAIS, declarações estaduais e municipais), com prazos e pendências.

**Arquivos para anexar:** carteira de clientes com regime e CNAE (XLSX/CSV) · extratos do PGDAS-D ou DAS-MEI do ano (PDF) · dados de sócios e rendimentos (XLSX) · recebimentos por CPF para a DMED (XLSX/CSV) · contratos e repasses para a DIMOB (XLSX/PDF)

```text
Use o agente obrigacoes-declaracoes-anuais para montar as declarações anuais do ano-calendário [AAAA] da [EMPRESA/CARTEIRA], CNPJ [00.000.000/0001-00].
Regime: [MEI / Simples / Presumido / Real]. Atividades: [CNAEs; imobiliária? saúde? imóvel rural?].
UF e município: [UF / MUNICÍPIO]. Teve empregados, pró-labore ou pagamentos com retenção? [sim/não].
Arquivos: @entradas/carteira.xlsx @entradas/pgdas/ @entradas/recebimentos-saude.csv
Quero o checklist com prazos, as bases conferidas e a lista do que falta.
```

</details>

<details>
<summary><b>Departamento Pessoal</b> · 7 agentes</summary>

#### `dp-admissao` · Admissão de empregados

**O que faz:** confere documentos, escolhe o tipo de contrato, calcula as datas da experiência e confere piso, ASO, vale-transporte e dependentes, com o S-2200 e seu prazo.

**Arquivos para anexar:** ficha de admissão (XLSX/PDF) · documento com foto e CPF (PDF/JPG) · ASO admissional (PDF) · convenção coletiva (PDF) · certidões dos dependentes (PDF/JPG) · declaração de vale-transporte (PDF)

```text
Use o agente dp-admissao para preparar a admissão de um empregado da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Cargo: [cargo e CBO, se souber]. Salário: R$ [valor]. Jornada: [44 h semanais / outra]. Início: [DD/MM/AAAA].
Contrato: [experiência de 45 + 45 dias / indeterminado / parcial / intermitente / aprendiz / estágio].
Dependentes: [quantidade e idades]. Usa vale-transporte? [sim/não; custo diário R$ valor].
Arquivos: @entradas/ficha_admissao.xlsx @entradas/convencao.pdf @entradas/documentos/
Quero o checklist de documentos, as datas da experiência, a conferência do piso e o resumo do S-2200 com prazo.
```

#### `dp-folha-mensal` · Folha mensal

**O que faz:** calcula e confere a folha do mês (extras, DSR, adicionais, INSS, IRRF 2026 com a redução, FGTS e líquido) e cruza o resultado com S-1200, S-1210 e S-1299.

**Arquivos para anexar:** cadastro dos empregados (XLSX/CSV) · espelho de ponto (PDF/XLSX) · variáveis do mês (XLSX/CSV) · convenção coletiva (PDF) · ofícios de pensão (PDF) · folha do sistema para conferência (PDF/XLSX)

```text
Use o agente dp-folha-mensal para calcular e conferir a folha de [MM/AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Empregados: [quantidade]. Convenção: [sindicato/categoria]. Adicional de hora extra na convenção: [50% / outro].
Data prevista de pagamento: [DD/MM/AAAA]. Houve admissões, desligamentos, férias ou afastamentos no mês? [quais]
Arquivos: @entradas/cadastro.xlsx @entradas/ponto/ @entradas/convencao.pdf @entradas/folha_sistema.pdf
Quero a memória por empregado em CSV, o resumo com totais e divergências e a conferência dos eventos do eSocial.
```

#### `dp-ferias-13` · Férias e 13º salário

**O que faz:** controla os períodos de férias, calcula férias (terço, abono, médias, fracionamento) e as parcelas do 13º, com INSS, IRRF, FGTS e as datas de aviso e pagamento.

**Arquivos para anexar:** cadastro com admissão e salário (XLSX/CSV) · histórico de férias e afastamentos (XLSX/PDF) · variáveis dos últimos 12 meses (XLSX/CSV) · pedidos de abono ou de 1ª parcela (PDF) · convenção coletiva (PDF)

```text
Use o agente dp-ferias-13 para [programar e calcular férias / calcular a 1ª ou a 2ª parcela do 13º] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Empregados: [todos / matrículas]. Início das férias: [DD/MM/AAAA]. Dias: [30 / outro]. Abono pecuniário: [sim/não]. Fracionamento: [períodos].
Data prevista de pagamento: [DD/MM/AAAA]. Empregados com salário variável: [quais].
Arquivos: @entradas/cadastro.xlsx @entradas/historico_ferias.xlsx @entradas/variaveis_12m.xlsx
Quero os recibos com memória de cálculo, a programação com datas-limite e os alertas de férias perto de vencer.
```

#### `dp-rescisao` · Rescisão do contrato de trabalho

**O que faz:** calcula a rescisão por tipo de desligamento, com aviso proporcional e projeção, férias, 13º, multa do FGTS, incidências por verba, prazos, TRCT e S-2299.

**Arquivos para anexar:** dados do contrato (XLSX/PDF) · carta de dispensa, pedido ou termo de acordo (PDF) · histórico de férias (XLSX/PDF) · extrato do FGTS (PDF/CSV) · variáveis dos últimos 12 meses (XLSX/CSV) · convenção coletiva (PDF)

```text
Use o agente dp-rescisao para calcular a rescisão de um empregado da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Tipo: [sem justa causa / pedido de demissão / justa causa / acordo do art. 484-A / fim de experiência / falecimento].
Admissão: [DD/MM/AAAA]. Último dia trabalhado: [DD/MM/AAAA]. Aviso: [trabalhado / indenizado / dispensado].
Salário: R$ [valor]. Férias em aberto: [períodos]. 1ª parcela do 13º já paga: R$ [valor]. Data-base da categoria: [mês].
Arquivos: @entradas/contrato.pdf @entradas/comunicado_desligamento.pdf @entradas/extrato_fgts.pdf @entradas/variaveis.xlsx
Quero o cálculo verba a verba com incidências, o resumo no formato do TRCT e os prazos de pagamento, S-2299 e FGTS.
```

#### `dp-afastamentos-sst` · Afastamentos e SST

**O que faz:** define quem paga cada dia de afastamento, aplica a regra dos 60 dias, trata acidente e CAT, maternidade e estabilidades e lista S-2230, S-2210, S-2220 e S-2240 com prazo.

**Arquivos para anexar:** atestados médicos (PDF/JPG) · histórico de afastamentos (XLSX/CSV) · relato do acidente (PDF/DOCX) · decisão do INSS (PDF) · atestado de gravidez ou certidão de nascimento (PDF/JPG) · ASOs, PCMSO e LTCAT (PDF)

```text
Use o agente dp-afastamentos-sst para analisar afastamentos e pendências de SST da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Situação: [atestado / acidente de trabalho / gravidez ou parto / alta do INSS / revisão geral de SST].
Empregado (matrícula): [número]. Datas: [início e fim ou previsão]. Afastamentos nos últimos 60 dias: [datas].
Empresa Cidadã: [sim/não]. Regime tributário: [Lucro Real / outro].
Arquivos: @entradas/atestados/ @entradas/historico_afastamentos.xlsx @entradas/sst/
Quero o quadro de quem paga cada dia, as estabilidades com data final e os eventos do eSocial com prazo.
```

#### `dp-encargos-fgts` · Encargos patronais e FGTS Digital

**O que faz:** calcula CPP, RAT × FAP, terceiros e FGTS, aplica a reoneração da CPRB do ano e confere DCTFWeb e GFD, entregando o custo total da folha com memória de cálculo.

**Arquivos para anexar:** resumo da folha por rubrica (PDF/XLSX) · totalizadores S-5011 e S-5013 do eSocial (XML/PDF) · extrato do FAP (PDF) · receita por atividade, se houver CPRB (XLSX/CSV) · GFD e recibo da DCTFWeb (PDF)

```text
Use o agente dp-encargos-fgts para conferir os encargos da folha de [MM/AAAA] da [EMPRESA], CNPJ [00.000.000/0001-00].
Regime: [Simples (anexo) / Presumido / Real]. FPAS: [código]. RAT: [1/2/3]%. FAP de [AAAA]: [0,0000].
Optou pela CPRB em [AAAA]? [sim/não; se sim, setor e receita desonerada do mês R$ valor].
Desligamentos no mês: [quantidade e datas de término].
Arquivos: @entradas/resumo-folha.pdf @entradas/fap.pdf @entradas/esocial/ @entradas/gfd.pdf
Quero a memória dos encargos, a conferência com DCTFWeb e GFD e o custo total da folha.
```

#### `dp-pro-labore-autonomos` · Pró-labore, autônomos e MEI

**O que faz:** calcula pró-labore, RPA de autônomo, frete de transportador autônomo e encargo sobre MEI de obra ou oficina, com INSS, IRRF de 2026, SEST/SENAT e efeito no fator R.

**Arquivos para anexar:** contrato social (PDF) · valores pagos no mês por beneficiário (XLSX/CSV) · declaração de INSS de outras fontes (PDF) · notas do MEI ou CT-e e recibos de frete (PDF/XML) · receita e folha dos últimos 12 meses (XLSX/PDF)

```text
Use o agente dp-pro-labore-autonomos para calcular os pagamentos a pessoas físicas de [MM/AAAA] da [EMPRESA], CNPJ [00.000.000/0001-00].
Regime: [Simples (anexo) / Presumido / Real]. Pró-labore por sócio: [SÓCIO 1: R$ valor; SÓCIO 2: R$ valor]; dependentes para IR: [quantidade].
Autônomos, fretes e MEI no mês: [beneficiário, atividade e valor bruto de cada um].
Algum beneficiário contribui ao INSS em outra fonte? [sim/não; base já contribuída R$ valor].
Arquivos: @entradas/contrato-social.pdf @entradas/pagamentos.xlsx @entradas/notas-mei/
Quero os recibos (RPA/pró-labore), a memória de cálculo e o fator R com o pró-labore mínimo para 28%.
```

</details>

<details>
<summary><b>Contabilidade</b> · 7 agentes</summary>

#### `contabil-plano-e-lancamentos` · Plano de contas e lançamentos

**O que faz:** monta ou revisa o plano de contas pela norma do porte, mapeia as contas ao plano referencial da ECD e transforma operações em lançamentos padrão e lote CSV validado.

**Arquivos para anexar:** plano de contas atual (XLSX/CSV) · balancete (XLSX/PDF) · lote ou planilha de operações (CSV/XLSX) · manual de importação do sistema (PDF/TXT) · última ECD (TXT do SPED)

```text
Use o agente contabil-plano-e-lancamentos para revisar o plano de contas e validar o lote de [MM/AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Regime: [Simples / Presumido / Real]. Atividade: [comércio / serviços / indústria]. Receita bruta do ano anterior: R$ [valor].
Sistema contábil: [nome do sistema]; importa contas por [código reduzido / classificação completa].
Eventos recorrentes para o roteiro: [ex.: vendas a prazo, compras com ICMS, folha, empréstimo, distribuição de lucros].
Arquivos: @entradas/plano_de_contas.xlsx @entradas/balancete.xlsx @entradas/lote_lancamentos.csv
Quero o plano revisado com de-para e códigos referenciais, o roteiro de lançamentos e o lote validado com a lista de pendências.
```

#### `contabil-conciliacoes` · Conciliação de bancos, clientes e fornecedores

**O que faz:** concilia extratos OFX ou CSV com o razão (inclusive muitos-para-um), prova o saldo e concilia clientes e fornecedores com aging, saldos invertidos e adiantamentos.

**Arquivos para anexar:** extrato bancário (OFX/CSV/PDF) · razão dos bancos (CSV/XLSX) · informe de aplicações (PDF) · títulos a receber e a pagar em aberto (XLSX/CSV) · balancete (XLSX/PDF)

```text
Use o agente contabil-conciliacoes para conciliar [MM/AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Contas: [banco, agência e conta de cada uma]. Saldo conciliado em [DD/MM/AAAA]: R$ [valor].
Tolerância de datas: [3] dias. Incluir clientes e fornecedores? [sim/não]. Data-base do aging: [DD/MM/AAAA].
Arquivos: @entradas/extratos/ @entradas/razao_bancos.csv @entradas/titulos_em_aberto.xlsx
Quero a conciliação com a prova do saldo, as pendências classificadas, o CSV de lançamentos sugeridos e o aging.
```

#### `contabil-conciliacao-cartoes` · Cartões, PIX e recebíveis

**O que faz:** confere as vendas da maquininha com as notas, as taxas do contrato, a agenda de recebíveis e o extrato; aponta cobrança a maior, chargebacks e antecipações e propõe os lançamentos.

**Arquivos para anexar:** relatório de vendas da adquirente (XLSX/CSV/EDI TXT) · recebimentos e ajustes (XLSX/CSV) · extrato da conta de domicílio (OFX/CSV) · contrato ou tabela de taxas (PDF/JPG) · XMLs de NFC-e e NF-e (XML)

```text
Use o agente contabil-conciliacao-cartoes para conciliar as vendas em cartão e PIX de [MM/AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Adquirentes e estabelecimentos: [nomes e números]. Conta de domicílio: [banco/agência/conta].
Taxas contratadas: [tabela anexa por bandeira e modalidade]. Há antecipação automática ou trava de recebíveis? [sim/não].
Arquivos: @entradas/cartoes/ @entradas/extrato.ofx @entradas/xml_nfce/
Quero vendas × notas, taxa cobrada × contratada, agenda × extrato, saldo a receber por adquirente e os lançamentos.
```

#### `contabil-estoques-cmv` · Estoques e CMV

**O que faz:** valoriza a movimentação por custo médio móvel ou PEPS, apura CMV e CPV, confere inventário, Bloco H e balancete e trata perdas, quebras e valor realizável líquido.

**Arquivos para anexar:** movimentação de estoque por item (CSV/XLSX) · XMLs de compra e venda (XML) · inventário e contagem física (XLSX/PDF) · Bloco H ou Registro de Inventário (TXT do SPED/PDF) · balancete (XLSX/PDF)

```text
Use o agente contabil-estoques-cmv para apurar o CMV de [MM/AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Regime: [Simples / Presumido / Real]. Atividade: [comércio / indústria]. Método: [custo médio móvel / PEPS].
Estoque inicial: [inventário de DD/MM/AAAA]. Perdas, furtos ou contagem física no período: [descreva ou "não houve"].
Arquivos: @entradas/movimentacao_estoque.csv @entradas/xml_compras/ @entradas/inventario.xlsx @entradas/balancete.xlsx
Quero a ficha de estoque, o CMV com a prova do estoque final, os alertas e os lançamentos.
```

#### `contabil-imobilizado` · Imobilizado e depreciação

**O que faz:** organiza o cadastro de bens e calcula depreciação contábil (CPC 27) e fiscal, ajustes no e-Lalur, baixas, intangível e impairment, conferindo o cadastro com o CIAP.

**Arquivos para anexar:** planilha patrimonial (XLSX/CSV) · NF-e de compra dos bens (XML/PDF) · razão do imobilizado (CSV/XLSX) · Parte B do e-Lalur (TXT do SPED/PDF) · Bloco G/CIAP (TXT do SPED) · documentos de baixa (PDF)

```text
Use o agente contabil-imobilizado para atualizar o imobilizado e a depreciação de [AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Regime: [Simples / Presumido / Real]. Bens comprados no ano: [lista ou "ver NF-e"]. Baixas no ano: [bem, data e valor].
Vidas úteis: [laudo anexo / estimativa da administração]. Contribuinte do ICMS com CIAP? [sim/não].
Arquivos: @entradas/patrimonio.xlsx @entradas/nfe_bens/ @entradas/razao_imobilizado.csv
Quero o cadastro atualizado, a tabela de depreciação contábil e fiscal, os ajustes no e-Lalur e os lançamentos.
```

#### `contabil-fechamento-mensal` · Fechamento mensal

**O que faz:** fecha a competência na ordem certa (importações, conciliações, provisões, apropriações, depreciação e tributos), testa o balancete em busca de anomalias e deixa o período pronto para travar.

**Arquivos para anexar:** balancete do mês e do anterior (XLSX/CSV) · razão de caixa e bancos (XLSX/CSV) · extratos bancários (OFX/PDF) · resumo da folha e relatório de férias (PDF/XLSX) · guias da competência (PDF) · mapa de depreciação (XLSX)

```text
Use o agente contabil-fechamento-mensal para fechar a competência [MM/AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Regime: [Simples (anexo) / Presumido / Real]. Empregados: [quantidade ou sem folha]. Sistema contábil: [nome].
Etapas já feitas: [importações / conciliação bancária / nenhuma]. Materialidade do escritório: R$ [valor].
Arquivos: @entradas/balancete.xlsx @entradas/razao-caixa.csv @entradas/folha/ @entradas/guias/
Quero o roteiro com o status de cada etapa, a lista de anomalias do balancete e os ajustes em CSV de importação.
```

#### `contabil-demonstracoes` · Demonstrações contábeis

**O que faz:** monta BP, DRE, DRA, DMPL ou DLPA e DFC pela norma do porte da entidade, com notas explicativas, amarração ao balancete e carta de responsabilidade da administração.

**Arquivos para anexar:** balancetes encerrados do exercício e do anterior (XLSX/CSV) · razões do PL, do imobilizado e dos empréstimos (XLSX/CSV) · demonstrações do ano anterior (PDF) · contrato social e atas (PDF) · carta do advogado e contratos de empréstimo (PDF/DOCX)

```text
Use o agente contabil-demonstracoes para elaborar as demonstrações de [31/12/AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Natureza jurídica: [LTDA / SLU / S.A. fechada]. Regime: [Simples / Presumido / Real]. Receita bruta do ano anterior: R$ [valor].
Finalidade: [aprovação das contas / banco / licitação / ECD]. Dividendos pagos no ano: R$ [valor].
Arquivos: @entradas/balancete-AAAA.xlsx @entradas/balancete-anterior.xlsx @entradas/razoes/ @entradas/societario/
Quero as demonstrações em XLSX, as notas explicativas em DOCX e a minuta da carta de responsabilidade.
```

</details>

<details>
<summary><b>Consultoria e planejamento</b> · 6 agentes</summary>

#### `consultoria-planejamento-tributario` · Planejamento tributário (escolha de regime)

**O que faz:** compara a carga anual completa no Simples, no Presumido e no Real, com folha, LC 224/2025, dividendos da Lei 15.270/2025 e CBS/IBS de 2027, e recomenda o regime com ponto de virada e prazo de opção.

**Arquivos para anexar:** DRE e balancete de 12 meses (XLSX/PDF) · faturamento por atividade e tipo de cliente (XLSX/CSV) · resumo anual da folha (XLSX/PDF) · guias pagas no ano, PGDAS-D ou DARFs (PDF)

```text
Use o agente consultoria-planejamento-tributario para comparar regimes para [AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Regime atual: [Simples (anexo) / Presumido / Real]. Receita prevista: R$ [valor]. Folha anual com pró-labore: R$ [valor]. Margem: [%].
Clientes: [%] pessoas físicas e [%] empresas do regime regular. Sócios: [quantidade]; retirada de lucros prevista: R$ [valor por ano].
Tem decisão judicial sobre a LC 224/2025? [sim/não]
Arquivos: @entradas/dre_12m.xlsx @entradas/faturamento.xlsx @entradas/folha_anual.xlsx @entradas/guias/
Quero o comparativo em cenários, a recomendação com o ponto de virada e o calendário de opção.
```

#### `consultoria-reforma-tributaria` · Reforma tributária (CBS, IBS e IS)

**O que faz:** compara a carga atual com a carga estimada de CBS e IBS ano a ano até 2033, mapeia créditos e split payment e decide, para optante do Simples, entre DAS e regime regular.

**Arquivos para anexar:** faturamento ou DRE de 12 meses (XLSX/CSV) · compras com o regime de cada fornecedor (XLSX/CSV) · apurações atuais (PDF/TXT do SPED) · amostra de XMLs de venda e compra (XML) · contratos de longo prazo (PDF/DOCX)

```text
Use o agente consultoria-reforma-tributaria para simular o impacto da reforma tributária na [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Regime atual: [Simples/Presumido/Real]. Atividade e NCM/NBS principais: [descrever].
Clientes: [% contribuintes do regime regular × % consumidores finais]. Tem redução ou regime específico? [sim/não/não sei].
Arquivos: @entradas/faturamento_12m.xlsx @entradas/compras_12m.xlsx @entradas/apuracoes/ @entradas/xml/
Quero o quadro 2026–2033 em cenários, a decisão DAS × regime regular (se for Simples) e os contratos a revisar.
```

#### `consultoria-lucros-dividendos` · Lucros, dividendos e JCP

**O que faz:** calcula o lucro distribuível, simula as retiradas mensais por sócio com a retenção de 10% da Lei 15.270/2025, avalia JCP e IRPFM e minuta a ata de distribuição.

**Arquivos para anexar:** contrato social (PDF) · balanço, DRE e balancete (PDF/XLSX) · apurações do período (PDF) · atas de distribuição de 2025 (PDF) · relatório de situação fiscal (PDF) · retiradas do ano por sócio (XLSX/CSV)

```text
Use o agente consultoria-lucros-dividendos para planejar a distribuição de lucros de [AAAA] da [EMPRESA], CNPJ [00.000.000/0001-00].
Regime: [Simples / Presumido / Real]. Tem escrituração contábil (Diário/ECD)? [sim/não].
Sócios e percentuais: [SÓCIO A xx% / SÓCIO B xx%]; o contrato permite distribuição desproporcional? [sim/não].
Valor pretendido por mês: [R$ valor ou cronograma]. Lucros de 2025 aprovados até 31/12/2025: [R$ valor e datas previstas na ata].
Arquivos: @entradas/contrato-social.pdf @entradas/balanco.pdf @entradas/situacao-fiscal.pdf @entradas/atas/
Quero o lucro distribuível, o calendário por sócio com as retenções e a minuta da ata.
```

#### `consultoria-gestao-financeira` · Gestão financeira e fluxo de caixa

**O que faz:** transforma a contabilidade em DRE gerencial, indicadores com fórmula e fluxo de caixa de 13 semanas e 12 meses em cenários, com uma página pronta para a reunião com o cliente.

**Arquivos para anexar:** balancetes ou DRE dos últimos 12 meses (XLSX/CSV) · balanço do período e do anterior (XLSX/PDF) · extratos bancários (OFX/CSV) · contas a receber e a pagar por vencimento (XLSX/CSV) · agenda de recebíveis de cartão (CSV) · contratos de empréstimo (PDF)

```text
Use o agente consultoria-gestao-financeira para preparar a reunião de resultados de [MM/AAAA] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Regime: [Simples / Presumido / Real]. Saldo bancário conciliado em [DD/MM/AAAA]: R$ [valor]. Caixa mínimo desejado: R$ [valor].
Preocupação do cliente: [falta de caixa / margem / crédito bancário / retirada de lucros]. Eventos previstos: [contratações, investimentos, 13º].
Arquivos: @entradas/balancetes-12m.xlsx @entradas/extratos/ @entradas/contas-a-receber.xlsx @entradas/contas-a-pagar.xlsx
Quero a planilha com DRE gerencial, indicadores e fluxos em três cenários, e a pauta de uma página para a reunião.
```

#### `consultoria-precificacao` · Formação de preço de venda

**O que faz:** calcula o preço por markup divisor com a carga tributária efetiva do regime, a margem de contribuição e os pontos de equilíbrio, e simula a venda B2B com a CBS em 2027.

**Arquivos para anexar:** custos por produto ou ficha técnica do serviço (XLSX/CSV) · notas de compra (XML/PDF) · DRE ou balancete dos últimos 12 meses (XLSX/PDF) · extrato do PGDAS-D ou apuração do regime (PDF) · tabela de preços atual (XLSX/PDF)

```text
Use o agente consultoria-precificacao para formar o preço de [PRODUTOS/SERVIÇOS] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Regime: [Simples (anexo e RBT12 de R$ [valor]) / Presumido / Real]. UF e município: [UF/município]. Vende para: [consumidor / empresas / ambos].
Despesas variáveis: comissão [x]%, cartão [x]%, frete [x]%. Despesas fixas mensais: R$ [valor]. Lucro desejado: [x]% do preço.
Arquivos: @entradas/custos.xlsx @entradas/dre-12m.xlsx @entradas/pgdas.pdf @entradas/xml-compras/
Quero a planilha de preços com margem de contribuição, pontos de equilíbrio e a simulação de 2027 para clientes empresas.
```

#### `consultoria-due-diligence-valuation` · Due diligence e valuation

**O que faz:** levanta passivos e riscos (contábil, fiscal, trabalhista, previdenciário, societário e contratos), classifica contingências e avalia a empresa por DCF, múltiplos e patrimônio ajustado, inclusive para apuração de haveres.

**Arquivos para anexar:** balancetes e demonstrações de 3 a 5 anos (XLSX/PDF) · declarações e apurações fiscais (PDF/TXT do SPED) · folha, eSocial e FGTS (PDF/XLSX) · contrato social, alterações e acordo de sócios (PDF) · contratos relevantes e relatório de processos (PDF/DOCX) · projeções da administração (XLSX)

```text
Use o agente consultoria-due-diligence-valuation para [due diligence / valuation / apuração de haveres] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Operação: [compra de quotas / compra de estabelecimento / entrada de sócio / saída de sócio]. Data-base: [DD/MM/AAAA]. Participação negociada: [x]%.
Regime: [Simples / Presumido / Real]. Cláusula de haveres no contrato social: [transcrever ou informar que é omisso].
Arquivos: @entradas/contabil/ @entradas/fiscal/ @entradas/trabalhista/ @entradas/societario/ @entradas/projecoes.xlsx
Quero o relatório de red flags com as contingências em R$, a faixa de valor por método e a sensibilidade do DCF.
```

</details>

<details>
<summary><b>Imposto de Renda Pessoa Física</b> · 5 agentes</summary>

#### `irpf-declaracao-anual` · Declaração anual do IRPF

**O que faz:** monta e revisa a declaração de ajuste anual, compara simplificada × completa em Python e aplica a redução anual e o teste do IRPF mínimo da Lei 15.270/2025.

**Arquivos para anexar:** declaração do ano anterior (PDF) · informes de rendimentos (PDF) · recibos de saúde e de educação (PDF/JPG) · contratos e escrituras de bens e dívidas (PDF) · dados dos dependentes (XLSX) · demonstrativos do Carnê-Leão Web e do GCAP (PDF)

```text
Use o agente irpf-declaracao-anual para preparar a declaração de [AAAA] (ano-calendário [AAAA]) do cliente [NOME], CPF [000.000.000-00].
Dependentes: [nome, CPF e se têm rendimentos]. Casal declara junto? [sim/não]
Mudanças no ano: [compra ou venda de bens, novo emprego, aluguel recebido, previdência privada, dividendos].
Arquivos: @entradas/declaracao-anterior.pdf @entradas/informes/ @entradas/recibos/
Quero o comparativo simplificada × completa, a conferência ficha a ficha e a lista de pendências.
```

#### `irpf-ganho-capital` · Ganho de capital (GCAP)

**O que faz:** apura o imposto sobre a venda de imóveis, quotas e outros bens fora de bolsa, testando isenções e fatores de redução, com um DARF 4600 por recebimento.

**Arquivos para anexar:** escrituras ou contratos de compra e de venda (PDF) · ficha de bens da última declaração (PDF) · notas de benfeitorias, ITBI e corretagem (PDF/JPG) · cronograma de recebimentos (XLSX) · contrato do novo imóvel residencial (PDF)

```text
Use o agente irpf-ganho-capital para apurar o ganho de capital na venda de [imóvel/quotas/veículo] do cliente [NOME], CPF [000.000.000-00].
Aquisição em [DD/MM/AAAA] por R$ [valor]. Venda em [DD/MM/AAAA] por R$ [valor], recebida [à vista / sinal e parcelas: detalhe].
É o único imóvel do cliente? [sim/não] Vendeu outro imóvel nos últimos 5 anos? [sim/não]
Vai comprar outro imóvel residencial em até 180 dias? [sim/não, valor previsto]
Arquivos: @entradas/escritura-compra.pdf @entradas/contrato-venda.pdf @entradas/benfeitorias/
Quero a memória de cálculo, as isenções testadas e o calendário de DARF 4600.
```

#### `irpf-investimentos` · Investimentos, bolsa, exterior e cripto

**O que faz:** apura o IR mensal de bolsa com prejuízo por modalidade e DARF 6015 e organiza renda fixa, exterior (Lei 14.754/2023) e criptoativos para a declaração.

**Arquivos para anexar:** notas de corretagem (PDF) · extratos de negociação e de posição da B3 (XLSX/CSV) · informes de corretoras e bancos (PDF) · controle de preço médio e prejuízos anterior (XLSX) · extratos de corretora no exterior (PDF/CSV) · relatórios de exchanges (CSV)

```text
Use o agente irpf-investimentos para apurar a renda variável de [MM/AAAA] a [MM/AAAA] do cliente [NOME], CPF [000.000.000-00].
Prejuízo acumulado até [MM/AAAA]: operações comuns R$ [valor] · day trade R$ [valor] · FII R$ [valor].
Tem investimentos no exterior, offshore ou criptoativos? [onde: corretora ou exchange, país]
Arquivos: @entradas/notas-corretagem/ @entradas/b3-negociacao.xlsx @entradas/informes/
Quero a apuração mensal com DARF 6015, o preço médio em 31/12 e o quadro para a declaração.
```

#### `irpf-carne-leao` · Carnê-leão e livro-caixa

**O que faz:** calcula o carnê-leão mensal de rendimentos de pessoas físicas, aluguéis e exterior, com livro-caixa, redução de 2026 e DARF 0190 com vencimento.

**Arquivos para anexar:** recibos emitidos ou controle de atendimentos (PDF/XLSX) · extrato da imobiliária (PDF) · IPTU e condomínio pagos (PDF) · planilha do livro-caixa (XLSX/CSV) · comprovantes de recebimento do exterior (PDF) · guias de INSS (PDF)

```text
Use o agente irpf-carne-leao para calcular o carnê-leão de [MM/AAAA] do cliente [NOME], CPF [000.000.000-00].
Atividade: [profissão] · recebido de pessoas físicas R$ [valor] · aluguel de pessoa física R$ [valor] · exterior: [país, moeda, valor].
Paga INSS como autônomo? [sim/não, valor] · Dependentes: [quantidade] · Mantém livro-caixa? [sim/não]
Arquivos: @entradas/recibos/ @entradas/extrato-imobiliaria.pdf @entradas/livro-caixa.xlsx
Quero o DARF 0190 com vencimento, a memória do mês e a lista de despesas recusadas no livro-caixa.
```

#### `irpf-malha-fina` · Malha fina e pendências do IRPF

**O que faz:** lê o extrato de pendências do IRPF, cruza informes com a declaração em Python e indica retificadora, entrega de documentos ou pagamento com redução de multa.

**Arquivos para anexar:** extrato e tela de pendências do e-CAC (PDF/PNG) · declaração entregue e recibo (PDF) · informes de rendimentos (PDF/CSV) · recibos das deduções (PDF/JPG) · termo de intimação ou notificação de lançamento (PDF)

```text
Use o agente irpf-malha-fina para analisar a pendência da declaração de [AAAA] do cliente [NOME], CPF [000.000.000-00].
Situação no e-CAC: [com pendências / retida em malha / intimado em DD/MM/AAAA / notificação com ciência em DD/MM/AAAA].
Motivo indicado: [omissão de rendimentos / IRRF / despesas médicas / dependentes / outro].
Arquivos: @entradas/extrato-ecac.pdf @entradas/declaracao.pdf @entradas/informes/ @entradas/recibos/
Quero o diagnóstico da causa, o custo de cada caminho e o roteiro da retificadora ou o dossiê de documentos.
```

</details>

<details>
<summary><b>Societário</b> · 3 agentes</summary>

#### `societario-abertura` · Abertura de empresa

**O que faz:** testa se o MEI basta, escolhe o tipo jurídico, define CNAEs e capital, redige a minuta do contrato social e monta o roteiro da Redesim com inscrições, licenças e opção pelo Simples.

**Arquivos para anexar:** descrição das atividades (TXT/DOCX) · documentos dos sócios (PDF/JPG) · IPTU ou contrato de locação da sede (PDF) · plano de capital e previsão do 1º ano (XLSX) · documentos dos bens a integralizar (PDF)

```text
Use o agente societario-abertura para planejar a abertura da [NOME PRETENDIDO DA EMPRESA], CNPJ [a emitir].
Atividades: [o que vai vender ou prestar, para quem e onde]. Sede: [cidade/UF], imóvel [próprio/alugado/residencial/coworking].
Sócios: [quantidade e % de cada]. Capital: R$ [valor], integralizado em [dinheiro/bens; descreva os bens].
Previsão do 1º ano: faturamento R$ [valor], empregados [nº], folha mensal com pró-labore R$ [valor].
Arquivos: @entradas/atividades.docx @entradas/socios/ @entradas/iptu_sede.pdf @entradas/plano_1o_ano.xlsx
Quero o parecer de tipo jurídico e CNAEs, a minuta do contrato social e o roteiro da Redesim.
```

#### `societario-alteracao` · Alteração contratual

**O que faz:** prepara a alteração do contrato social (sócios, cessão de quotas, capital, endereço, CNAE, administrador, transformação) com quórum, riscos tributários e do Simples, minuta e checklist.

**Arquivos para anexar:** contrato social consolidado e alterações (PDF) · certidão simplificada da Junta (PDF) · cartão CNPJ e QSA (PDF) · documentos do novo sócio (PDF/JPG) · balancete recente e custo das quotas (PDF/XLSX)

```text
Use o agente societario-alteracao para preparar a alteração contratual da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
O que muda: [entrada/saída de sócio, cessão de quotas, capital, endereço, CNAE, administrador].
Quem cede e quem recebe: [nomes, nº de quotas, preço ou doação]. Custo das quotas do cedente: R$ [valor].
O novo sócio tem outras empresas? [CNPJ, % e faturamento anual]. Nova sede ou CNAEs: [se houver].
Arquivos: @entradas/contrato_consolidado.pdf @entradas/certidao_junta.pdf @entradas/novo_socio/
Quero o parecer (quórum, Simples, tributos), a minuta com a consolidação e o checklist pós-registro.
```

#### `societario-baixa` · Encerramento de empresa

**O que faz:** decide entre baixa com ou sem débitos, prepara o distrato, o roteiro de baixa de CNPJ, IE e IM, o calendário das declarações de extinção e a tabela de guarda de documentos.

**Arquivos para anexar:** contrato social consolidado (PDF) · relatório de situação fiscal e certidões (PDF) · balancete de encerramento (PDF/XLSX) · inventário de estoque e imobilizado (XLSX/CSV) · relação de empregados (XLSX) · recibos das últimas declarações (PDF)

```text
Use o agente societario-baixa para encerrar a [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Regime: [Simples/MEI/Presumido/Real]. Data pretendida do encerramento: [DD/MM/AAAA].
Empregados ativos: [nº, com estabilidade? sim/não]. Estoque e bens: [descrever ou "não há"].
Débitos conhecidos: [federal/estadual/municipal/FGTS, valores]. O cliente prefere [regularizar antes/baixar com débito].
Arquivos: @entradas/contrato_consolidado.pdf @entradas/situacao_fiscal.pdf @entradas/balancete_final.xlsx @entradas/empregados.xlsx
Quero o parecer, a minuta do distrato, o calendário de declarações de extinção e a tabela de guarda de documentos.
```

</details>

<details>
<summary><b>Regularidade, defesa e créditos</b> · 3 agentes</summary>

#### `regularidade-fiscal` · Regularidade fiscal e certidões

**O que faz:** lê o relatório de situação fiscal e as consultas da PGFN, estado, município, FGTS e CNDT, diz o que impede cada certidão, conta os prazos do termo de exclusão e compara parcelamento e transação.

**Arquivos para anexar:** Relatório de Situação Fiscal do e-CAC (PDF) · consulta da PGFN/Regularize (PDF) · certidões ou extratos estaduais e municipais (PDF) · CRF e CNDT (PDF) · termo de exclusão com a data de ciência (PDF) · guias e comprovantes pagos (PDF)

```text
Use o agente regularidade-fiscal para analisar as pendências e o caminho até a certidão da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Regime: [MEI / Simples / Presumido / Real]. Para que precisa da certidão: [licitação / financiamento / venda / outro], até [DD/MM/AAAA].
Recebeu termo de exclusão do Simples? [sim/não]; ciência em [DD/MM/AAAA]. Caixa disponível por mês para acordo: R$ [valor].
Débitos que o cliente diz já ter pago: [quais, com comprovante].
Arquivos: @entradas/relatorio-situacao-fiscal.pdf @entradas/pgfn-regularize.pdf @entradas/certidoes/
Quero a lista de pendências classificada, o que impede cada certidão, os prazos e a comparação entre parcelar e transacionar.
```

#### `regularidade-defesa-fiscal` · Defesa fiscal e intimações

**O que faz:** calcula o prazo a partir da ciência, avalia espontaneidade e redução de multa e redige a resposta à intimação, a impugnação, a manifestação de inconformidade ou o recurso, com provas indexadas.

**Arquivos para anexar:** termo, auto ou despacho completo (PDF) · comprovante de ciência no DTE ou AR (PDF/PNG) · escrituração do período (TXT do SPED/XML/XLSX) · declarações e guias do período (PDF) · procuração (PDF)

```text
Use o agente regularidade-defesa-fiscal para tratar o [termo de intimação/auto de infração/despacho decisório] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Órgão: [Receita Federal/SEFAZ-UF/Prefeitura]. Data de ciência: [DD/MM/AAAA] por [DTE/AR/pessoal]. Nº do processo ou TDPF: [número].
Tributo, período e valor exigido: [descrever]. O cliente concorda com alguma parte? [sim/não/qual].
Arquivos: @entradas/auto_infracao.pdf @entradas/ciencia_dte.png @entradas/sped/ @entradas/guias/
Quero o prazo seguro, a comparação pagar com redução × defender e a minuta da resposta ou da impugnação com o índice de provas.
```

#### `regularidade-recuperacao-creditos` · Recuperação de créditos

**O que faz:** revisa os últimos 5 anos, estima pelos XMLs o crédito de monofásico e ICMS-ST no Simples, ICMS-ST pago a maior, insumos e retenções, e indica o caminho de recuperação com os riscos.

**Arquivos para anexar:** XMLs de vendas dos últimos 5 anos (XML) · extratos do PGDAS-D por competência (PDF/CSV) · XMLs de compras com ST (XML) · EFD-Contribuições e EFD ICMS/IPI (TXT do SPED) · comprovantes de retenção e DARFs (PDF)

```text
Use o agente regularidade-recuperacao-creditos para levantar créditos dos últimos 5 anos da [EMPRESA], CNPJ [00.000.000/0001-00].
Regime em cada ano: [AAAA: Simples/Presumido/Real; ...]. Atividade e UF: [comércio de ... / UF].
Produtos principais: [medicamentos, cosméticos, autopeças, bebidas ...]. Data prevista do pedido: [DD/MM/AAAA].
Tem ação judicial ou PER/DCOMP anterior? [sim/não; qual].
Arquivos: @entradas/xml-vendas/ @entradas/pgdas/ @entradas/sped/ @entradas/retencoes.pdf
Quero o crédito estimado por competência e tributo, a classificação de risco e o caminho para recuperar.
```

</details>

<details>
<summary><b>Escritório e atendimento</b> · 2 agentes</summary>

#### `escritorio-novo-cliente` · Novo cliente

**O que faz:** calcula a proposta de honorários (regime, folha, notas, complexidade), redige o contrato exigido pelo CFC e monta o checklist de transferência e o onboarding, sem pedir senha nem certificado ao cliente.

**Arquivos para anexar:** cartão CNPJ e contrato social (PDF) · perfil operacional do cliente (XLSX/CSV) · tabela de preços e custo-hora do escritório (XLSX) · modelo de contrato da casa (DOCX)

```text
Use o agente escritorio-novo-cliente para preparar proposta, contrato e implantação da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Regime: [MEI / Simples / Presumido / Real]. Funcionários: [nº]. Sócios com pró-labore: [nº]. Notas por mês: [nº emitidas + recebidas].
Contas bancárias: [nº]. Filiais: [nº]. Complexidade: [baixa / média / alta: ex. ST, importação, bloco K].
Escopo: [contábil, fiscal, DP, IRPF dos sócios, consultoria]. Contador anterior: [nome do escritório]; assumimos a partir de [MM/AAAA].
Arquivos: @entradas/cartao-cnpj.pdf @entradas/contrato-social.pdf @entradas/tabela-honorarios.xlsx
Quero a proposta com a memória de cálculo, a minuta do contrato e os checklists de transferência e onboarding.
```

#### `escritorio-comunicacao-cliente` · Comunicação com o cliente

**O que faz:** escreve rascunhos de WhatsApp e e-mail (pedido de documentos, envio de guias, imposto explicado em linguagem simples, mudança na lei, cobrança respeitosa) para o contador revisar. Nunca envia nada.

**Arquivos para anexar:** guias do mês (PDF) · lista de pendências ou documentos faltantes (CSV/XLSX) · planilha de guias para lote (CSV) · contrato de honorários, se for cobrança (PDF/DOCX)

```text
Use o agente escritorio-comunicacao-cliente para redigir [pedido de documentos / envio de guias / explicação de imposto / aviso de mudança na lei / cobrança] da [EMPRESA/CLIENTE], CNPJ [00.000.000/0001-00].
Quem recebe: [NOME], por [WhatsApp / e-mail]. Tom: [formal / próximo].
Assunto em uma frase: [ex.: DAS de outubro subiu; faltam extratos de 2 contas; honorário de setembro em atraso].
Prazo ou data que precisa aparecer: [DD/MM]. Cláusula do contrato, se for cobrança: [nº].
Arquivos: @entradas/guias-outubro.pdf @entradas/pendencias.csv
Quero o rascunho pronto para revisar, com os campos que faltam destacados. Não envie nada.
```

</details>

## Fluxos prontos

Peça uma sequência inteira em um prompt só. O Claude chama os agentes em ordem e para entre as etapas se você pedir.

| Fluxo | Sequência de agentes |
|---|---|
| **Fechamento mensal (Simples)** | `triagem-documentos` → `fiscal-auditoria-xml` → `fiscal-simples-nacional` → `dp-folha-mensal` → `obrigacoes-dctfweb-reinf` → `contabil-conciliacoes` → `contabil-fechamento-mensal` → `escritorio-comunicacao-cliente` |
| **Fechamento trimestral (Presumido)** | `fiscal-auditoria-xml` → `fiscal-retencoes-federais` → `fiscal-lucro-presumido` → `obrigacoes-efd-contribuicoes` → `obrigacoes-dctfweb-reinf` |
| **Temporada de IRPF** | `triagem-documentos` → `irpf-investimentos` / `irpf-ganho-capital` / `irpf-carne-leao` → `irpf-declaracao-anual` → `irpf-malha-fina` |
| **Cliente novo** | `escritorio-novo-cliente` → `regularidade-fiscal` → `consultoria-planejamento-tributario` → `obrigacoes-calendario` |
| **Abrir empresa** | `consultoria-planejamento-tributario` → `societario-abertura` → `obrigacoes-calendario` |
| **Fiscalização ou intimação** | `regularidade-defesa-fiscal` → agente do tributo envolvido → `regularidade-fiscal` |
| **Fim de ano** | `contabil-fechamento-mensal` → `contabil-demonstracoes` → `consultoria-lucros-dividendos` → `consultoria-planejamento-tributario` |

Exemplo de prompt de fluxo:

```text
Faça o fechamento de [MM/AAAA] do cliente [NOME], que é do Simples Nacional, usando em ordem os agentes
triagem-documentos, fiscal-auditoria-xml, fiscal-simples-nacional, dp-folha-mensal e contabil-conciliacoes.
Arquivos: @clientes/[cliente]/[AAAA-MM]/entradas/
Pare depois de cada agente, me mostre o resumo e espere meu ok para seguir.
```

## Segurança e LGPD

- Os arquivos ficam no seu computador, mas o conteúdo que o Claude lê é processado pela Anthropic conforme os termos da sua conta. Antes de usar dados reais de clientes, confira a política de dados do seu plano e o que o seu contrato com o cliente permite (LGPD).
- Os agentes mascaram CPF e evitam repetir dados pessoais sem necessidade.
- Os agentes não pedem senha, certificado digital nem código de acesso. Desconfie de qualquer resposta que peça isso.
- Nada é enviado à Receita, à prefeitura ou ao cliente pelos agentes: eles só preparam arquivos e rascunhos. Quem transmite e assina é você.

## Atualizar, personalizar e desinstalar

- **Atualizar:** baixe o ZIP novo e rode o instalador de novo. Ele sobrescreve só os arquivos deste pacote e não mexe nos seus outros agentes. Veja o que mudou no [CHANGELOG](CHANGELOG.md).
- **Personalizar:** cada agente é um arquivo de texto. Abra o `.md`, ajuste as instruções (por exemplo, o layout de importação do seu sistema) e reinicie o Claude Code.
- **Trocar o modelo:** os agentes usam `model: inherit`, o mesmo modelo da sua sessão. Para economizar, troque por `model: sonnet` ou `model: haiku` no topo do arquivo.
- **Desinstalar:** `bash instalar.sh --remover` (macOS/Linux) ou `.\instalar.ps1 -Remover` (Windows). Para remover de uma pasta específica, acrescente `--projeto <pasta>` ou `-Projeto <pasta>`.

## Perguntas frequentes

<details>
<summary><b>Os agentes não aparecem no /agents. E agora?</b></summary>

1. Feche e abra o Claude Code de novo: os agentes só carregam no início da sessão.
2. Confira se os arquivos `.md` estão direto em `~/.claude/agents/` (ou `.claude/agents/` do projeto), e não em uma subpasta como `~/.claude/agents/agents/`.
3. No Windows, confira se a extensão é `.md`, e não `.md.txt`.

</details>

<details>
<summary><b>Funciona no app desktop e no VS Code?</b></summary>

Sim. Os agentes instalados em `~/.claude/agents/` valem para o Claude Code no terminal, no app desktop e nas extensões de IDE.

</details>

<details>
<summary><b>Preciso saber programar?</b></summary>

Não. Os agentes escrevem e rodam o Python sozinhos. Você só precisa ter o Python instalado (e `pandas` e `openpyxl` para Excel).

</details>

<details>
<summary><b>A legislação está atualizada?</b></summary>

A base é a legislação vigente em outubro de 2026, incluindo a Lei 15.270/2025 (IR e dividendos), a LC 224/2025 (Lucro Presumido) e a reforma tributária (EC 132/2023 e LC 214/2025). Como alíquotas, tabelas e prazos mudam, os agentes conferem fontes oficiais na internet quando podem e marcam **[CONFIRMAR]** quando não conseguem confirmar.

</details>

<details>
<summary><b>O agente pode errar?</b></summary>

Pode. Por isso todo resultado vem com memória de cálculo, premissas declaradas e checklist. Trate como trabalho de um assistente competente: revise antes de usar.

</details>

<details>
<summary><b>Posso usar no meu escritório e adaptar?</b></summary>

Pode. A licença MIT permite usar, modificar e compartilhar, inclusive comercialmente, desde que o aviso de autoria seja mantido. Veja [Autor e licença](#autor-e-licença).

</details>

## Autor e licença

Criado e mantido por **Kelvin Rocha** · [github.com/adrianokelvio](https://github.com/adrianokelvio)

Distribuído sob a [licença MIT](LICENSE). Você pode usar, copiar, modificar e redistribuir, desde que mantenha o aviso de copyright de Kelvin Rocha.

**Avisos legais**

- Os agentes refletem a legislação e a jurisprudência conhecidas em outubro de 2026 e não substituem a consulta à norma vigente.
- Os resultados são rascunhos operacionais. A revisão, a assinatura e a responsabilidade técnica são do contador responsável (CFC/CRC).
- Exemplos e modelos usam dados fictícios.
