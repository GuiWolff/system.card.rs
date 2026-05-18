# Contexto
Você é um desenvolvedor sênior em Dart/Flutter.
Leia a análise da tarefa e o resumo do slice anterior.
Este é o slice 4/5 derivado de `.codex/funcionalidade/funcionalidade-26-05-18-3.md`.

## Análise da tarefa
- `.codex/funcionalidade/funcionalidade-26-05-18-3-analise.md`

## Regras e skills aplicáveis
- Leia `AGENTS.md`.
- Leia `.codex/rules/RULE.md`.
- Leia as skills e referências listadas na análise antes de alterar código.
- Se houver conflito entre este slice e uma regra ou skill aplicável, pare e reporte o bloqueio.

## Continuidade
- Slice anterior: `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_3-resumo.md`
- Se o resumo anterior existir e estiver válido, não refaça os slices anteriores.

## Arquivos
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pdf_preview_dialog.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_compartilhamento_dialog.dart`, apenas se a execução confirmar que ainda há uso direto.
- `lib/features/pedido_page/services/recibo_impressao_service.dart`, apenas como consumidor existente.
- `lib/features/pedido_page/services/recibo_compartilhamento_service.dart`, apenas como consumidor existente.
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`

## Contratos de tela
- Leia e atualize `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Este slice impacta UI e fluxo público de PDF.
- Nenhum contrato novo deve ser criado.

## Regras
- Remover as ações visuais `Imprimir` e `Compartilhar` da linha de ações rápidas do recibo.
- Manter `Gerar PDF` como entrada para a prévia.
- Adicionar ação `Imprimir` em `ReciboPdfPreviewDialog`.
- A ação `Imprimir` da prévia deve reutilizar os `pdfBytes` e o `nomeArquivo` já gerados, sem gerar novo PDF.
- A ação `Compartilhar` da prévia deve continuar usando o fluxo genérico atual com o PDF já gerado.
- Preservar os serviços existentes; não remover `ReciboCompartilhamentoDialog` ou métodos legados sem confirmação explícita.
- Evitar quebrar API pública exportada por `lib/features/pedido_page/pedido_page.dart`; se remover parâmetro público, justificar no resumo.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit automaticamente.
- Não alterar payload de compartilhamento além do necessário para reorganizar o ponto de entrada visual.

## Entregáveis
1. Ações rápidas sem `Imprimir` e sem `Compartilhar`.
2. Prévia do PDF com ações `Imprimir`, `Compartilhar`, `Salvar arquivo` e `Fechar`.
3. Impressão usando bytes já gerados na prévia.
4. Testes atualizados para a nova localização das ações.
5. Atualização de `pedido_page-contrato.md`.
6. Resumo em `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_4-resumo.md`.

# Descrição
- Concentrar ações de saída do PDF dentro da visualização do PDF.

## Objetivo
- O usuário deve gerar a prévia do PDF e, dentro dela, escolher imprimir, compartilhar ou salvar arquivo.
