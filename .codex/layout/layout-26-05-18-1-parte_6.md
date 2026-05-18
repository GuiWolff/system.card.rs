# Contexto
Você é um desenvolvedor sênior em Dart/Flutter.
Leia a análise da tarefa e o resumo do slice anterior.
Este é o slice 6/7 derivado de `.codex/layout/layout-26-05-18-1.md`.

## Análise da tarefa
- `.codex/layout/layout-26-05-18-1-analise.md`

## Regras e skills aplicáveis
- Leia `AGENTS.md`.
- Leia `.codex/rules/RULE.md`.
- Leia as skills e referências listadas na análise antes de alterar código.
- Use `.codex/skills/argo-flutter-dev/SKILL.md`.
- Use `.codex/skills/argo-flutter-dev/references/tema.md`.
- Se houver conflito entre este slice e uma regra ou skill aplicável, pare e reporte o bloqueio.

## Continuidade
- Slice anterior: `.codex/layout/layout-26-05-18-1-parte_5-resumo.md`.
- Leia os resumos anteriores e preserve as áreas já modernizadas.

## Arquivos
- `lib/features/pedido_page/presentation/widgets/visualizacao_recibo.dart`.
- `lib/features/pedido_page/presentation/widgets/clientes_painel.dart`.
- `lib/features/pedido_page/presentation/widgets/historico_recibos_painel.dart`.
- `lib/features/pedido_page/presentation/widgets/recibo_compartilhamento_dialog.dart`.
- `lib/features/pedido_page/presentation/widgets/recibo_pdf_preview_dialog.dart`.
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- `test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`.
- `test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`.
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`.

## Contratos de tela
- Ler antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Atualizar neste slice:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Não criar contrato novo; visualização, painéis e dialogs pertencem à `PedidoPage`.

## Regras
- Modernizar a visualização do recibo, preservando fidelidade aos dados do formulário.
- Modernizar painéis auxiliares e dialogs com superfícies, espaçamentos e estados coerentes com o tema.
- Manter `FaIcon` apenas para Instagram e WhatsApp.
- Migrar telefone, localização, busca, fechar, carregar, duplicar, excluir, compartilhar, e-mail, PDF e salvar para `Icon` com `Icons.*`.
- Não alterar `ReciboPdfService`; a tarefa é UI Flutter, não geração do PDF.
- Atualizar testes correspondentes.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit automaticamente.
- Não alterar payload de compartilhamento, impressão, geração de PDF, repository ou SQLite.
- Não remover `font_awesome_flutter`, porque WhatsApp e Instagram ainda podem depender dele.

## Entregáveis
1. `VisualizacaoRecibo` modernizada, mantendo `FaIcon` apenas para WhatsApp e Instagram.
2. `ClientesPainel`, `HistoricoRecibosPainel`, `ReciboCompartilhamentoDialog` e `ReciboPdfPreviewDialog` modernizados com ícones nativos.
3. Testes relacionados atualizados.
4. Contrato `pedido_page-contrato.md` atualizado.
5. Registrar no resumo do slice quais contratos de tela foram atualizados.
6. Rodar validações específicas conforme a skill aplicável.
7. Salvar resumo em `.codex/layout/layout-26-05-18-1-parte_6-resumo.md`.

# Descrição
- Este slice fecha as superfícies auxiliares da experiência: prévia, clientes, histórico, compartilhamento e PDF.

## Objetivo
- Ao final deste slice, painéis e dialogs devem seguir a linguagem visual moderna do app, com `FaIcon` restrito a WhatsApp e Instagram.
