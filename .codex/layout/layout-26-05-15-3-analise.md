# Análise da tarefa

## Pedido original
- Utilizar o pacote `font_awesome_flutter` para os ícones da interface, incluindo Instagram, WhatsApp e os demais ícones hoje renderizados com `Icons.*` ou SVGs na feature de pedido.

## Feature correspondente
- Feature principal: `pedido_page`.
- Caminho provável: `lib/features/pedido_page/`.
- A tarefa é visual e deve permanecer dentro da arquitetura vertical da feature, sem criar estrutura horizontal global.

## Arquivos relacionados
- `pubspec.yaml`
- `pubspec.lock`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `lib/features/pedido_page/presentation/widgets/cabecalho_app.dart`
- `lib/features/pedido_page/presentation/widgets/cabecalho_editor_dialog.dart`
- `lib/features/pedido_page/presentation/widgets/clientes_painel.dart`
- `lib/features/pedido_page/presentation/widgets/historico_recibos_painel.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_compartilhamento_dialog.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pdf_preview_dialog.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
- `lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart`
- `lib/features/pedido_page/presentation/widgets/visualizacao_recibo.dart`
- `test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`
- `test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`

## Estado atual
- `font_awesome_flutter` ainda não está declarado em `pubspec.yaml`.
- `CabecalhoApp` usa `flutter_svg` para renderizar `lib/resources/icon_instagram.svg` e `lib/resources/icon_whatsapp.svg`.
- `CabecalhoApp` ainda usa `Icons.call_outlined`, `Icons.location_on_outlined` e `Icons.edit_outlined`.
- `CabecalhoEditorDialog`, `ClientesPainel`, `HistoricoRecibosPainel`, `ReciboCompartilhamentoDialog`, `ReciboPdfPreviewDialog`, `ReciboFormulario`, `ProdutosServicosTabela`, `ReciboPedido` e `VisualizacaoRecibo` usam vários `Icons.*`.
- O teste `cabecalho_app_test.dart` importa `flutter_svg` e espera dois `SvgPicture`.
- O contrato da `PedidoPage` registra explicitamente que Instagram e WhatsApp usam SVGs via `flutter_svg`.
- Existem assets SVG de marca em `lib/resources/icon_instagram.svg` e `lib/resources/icon_whatsapp.svg`.
- O worktree já possui várias alterações em andamento; esta tarefa deve preservar essas alterações e trabalhar de forma localizada.

## Estado esperado
- A UI da feature `pedido_page` deve usar `FaIcon` e `FontAwesomeIcons` nos ícones migrados.
- Instagram e WhatsApp devem usar ícones de marca do Font Awesome:
  - `FontAwesomeIcons.instagram`;
  - `FontAwesomeIcons.whatsapp`.
- Os demais ícones visuais da feature devem usar equivalentes coerentes do Font Awesome sempre que houver mapeamento semântico adequado.
- A dependência `font_awesome_flutter` deve ser adicionada ao projeto por meio de `flutter pub add font_awesome_flutter` ou edição equivalente validada por `flutter pub get`.
- Testes que verificam presença de `SvgPicture` ou dependem de `Icons.*` devem ser ajustados para o novo contrato visual.
- O contrato `pedido_page-contrato.md` deve ser atualizado nos slices com impacto de UI para documentar a migração de ícones.
- Os SVGs existentes não devem ser removidos automaticamente sem confirmação explícita; eles podem ficar como legado não utilizado se a migração não exigir remoção.

## Riscos e dependências
- O pacote `font_awesome_flutter` adiciona uma nova dependência externa e atualiza `pubspec.lock`.
- Alguns ícones Material não possuem equivalente Font Awesome perfeito; a escolha deve priorizar intenção semântica, acessibilidade e consistência visual.
- `FontAwesomeIcons` tem tamanhos e proporções diferentes de `Icons.*`, então botões, prefix icons e linhas de contato podem exigir ajuste fino de tamanho.
- `FaIcon` deve ser usado em locais que recebem `Widget`, como `IconButton.icon`, `OutlinedButton.icon`, `ListTile.leading` e ícones soltos.
- Campos que hoje recebem `IconData` podem continuar aceitando `IconData`, desde que recebam `FontAwesomeIcons.*`, ou podem ser ajustados para receber `Widget` quando o controle visual exigir tamanho/cor por instância.
- O pacote `pdf` usado em `ReciboPdfService` não renderiza widgets Flutter; não tentar usar `FontAwesomeIcons` diretamente dentro da geração de PDF. Se o PDF precisar de ícones de marca no futuro, isso deve ser planejado com fonte/asset própria do pacote `pdf`.
- Não remover `flutter_svg` nem os assets SVG neste ciclo sem confirmar se não há uso restante e se a remoção é desejada.
- A migração toca vários widgets de apresentação e testes, então há risco de regressões visuais ou quebras por imports não utilizados.

## Contratos de tela
- Contrato existente que deve ser lido antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos que precisam ser criados:
  - Nenhum. A tarefa impacta a `PedidoPage` existente e widgets internos da mesma tela.
- Contratos que precisam ser atualizados:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Impacto em UI:
  - Sim. A tarefa altera ícones visíveis no cabeçalho, dialogs, painéis, formulário, ações do recibo e visualização do recibo.

## Estratégia
- Primeiro adicionar e validar a dependência `font_awesome_flutter`, migrando o cabeçalho e os ícones de marca de Instagram/WhatsApp.
- Depois migrar dialogs e painéis auxiliares, mantendo cada widget com responsabilidade própria.
- Por fim migrar formulário, ações do recibo, tabela e visualização, fazendo uma varredura final para evitar `Icons.*`, `SvgPicture` e imports não utilizados na apresentação da feature.
- Atualizar testes junto dos widgets alterados e manter o contrato da `PedidoPage` sincronizado em cada slice com impacto visual.

## Decisão sobre slices
- Haverá slices.
- Justificativa:
  - A tarefa altera múltiplos widgets e testes.
  - Há inclusão de dependência externa e atualização de lockfile.
  - A migração visual afeta cabeçalho, dialogs, painéis, formulário, tabela, ações e visualização do recibo.
  - A divisão reduz risco de regressão e permite validações intermediárias.

## Validações recomendadas
- `flutter pub get`
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test`
