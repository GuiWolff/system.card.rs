# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 2/3 derivado de `docs/codex/layout/layout-26-05-15-3.md`.

## Análise da tarefa
- `docs/codex/layout/layout-26-05-15-3-analise.md`

## Continuidade
- Slice anterior: `docs/codex/layout/layout-26-05-15-3-parte_1-resumo.md`
- Antes de iniciar, leia o resumo do slice 1 e confirme que `font_awesome_flutter` já está disponível.

## Arquivos
- `lib/features/pedido_page/presentation/widgets/cabecalho_editor_dialog.dart`
- `lib/features/pedido_page/presentation/widgets/clientes_painel.dart`
- `lib/features/pedido_page/presentation/widgets/historico_recibos_painel.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_compartilhamento_dialog.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pdf_preview_dialog.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`

## Contratos de tela
- Ler e atualizar:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Não criar contrato novo.
- Impacto em UI: sim, por alteração dos ícones de dialogs e painéis acessados pela `PedidoPage`.

## Regras
- Migrar ícones de dialogs e painéis para `FaIcon`/`FontAwesomeIcons`.
- Priorizar equivalentes semânticos claros:
  - busca: `FontAwesomeIcons.magnifyingGlass`;
  - fechar/limpar: `FontAwesomeIcons.xmark`;
  - pessoa/cliente: `FontAwesomeIcons.user`;
  - telefone: `FontAwesomeIcons.phone`;
  - e-mail: `FontAwesomeIcons.envelope`;
  - histórico: `FontAwesomeIcons.clockRotateLeft`;
  - copiar: `FontAwesomeIcons.copy`;
  - excluir: `FontAwesomeIcons.trashCan`;
  - compartilhar: `FontAwesomeIcons.shareNodes`;
  - PDF: `FontAwesomeIcons.filePdf`;
  - salvar arquivo: `FontAwesomeIcons.floppyDisk` ou `FontAwesomeIcons.fileArrowDown`, conforme melhor encaixe visual.
- Onde o helper atual recebe `IconData`, pode continuar recebendo `IconData` se isso mantiver a mudança pequena.
- Manter chaves de teste e textos visíveis atuais.
- Não alterar regras de cadastro, pesquisa, histórico, compartilhamento ou preview.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit.
- Não alterar models, repositories, services ou ViewModel neste slice, exceto se algum teste expuser ajuste mínimo estritamente necessário.

## Entregáveis
1. Dialogs e painéis listados usando `font_awesome_flutter`.
2. Imports não utilizados removidos.
3. Testes relacionados ajustados quando necessário.
4. `pedido_page-contrato.md` atualizado com o novo contrato visual desses widgets.
5. Rodar validações específicas.
6. Salvar resumo em `docs/codex/layout/layout-26-05-15-3-parte_2-resumo.md`.

# Descrição
- Este slice migra os ícones de suporte da experiência: edição de cabeçalho, clientes, histórico, compartilhamento e preview de PDF.

## Objetivo
- Ao final deste slice, dialogs e painéis auxiliares da `PedidoPage` devem usar Font Awesome sem alterar comportamento funcional.

## Validações obrigatórias
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
