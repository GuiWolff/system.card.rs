# Contexto
Você é um desenvolvedor sênior em Dart/Flutter.
Leia a análise desta tarefa antes de executar qualquer alteração.
Esta tarefa foi dividida em 5 slices.

## Análise da tarefa
- `.codex/funcionalidade/funcionalidade-26-05-18-3-analise.md`

## Regras e skills aplicáveis
- Leia `AGENTS.md`.
- Leia `.codex/rules/RULE.md`.
- Leia as skills e referências listadas na análise antes de alterar código.
- Para Dart/Flutter, siga `.codex/skills/argo-flutter-dev/SKILL.md`.
- Para tema, superfícies, textos, ações visuais e mensagens, siga `.codex/skills/argo-flutter-dev/references/tema.md`.
- Se houver conflito entre este prompt e uma regra ou skill aplicável, pare e reporte o bloqueio.

## Objetivo geral
- Ajustar a experiência de edição e emissão de recibos na feature `pedido_page`, mantendo a arquitetura vertical atual:
  - inputs monetários com digitação por centavos;
  - remoção automática do último item acidental vazio ao salvar;
  - autocomplete de clientes no campo de cliente;
  - ações de imprimir e compartilhar concentradas na prévia do PDF;
  - correção do `Scrollbar` sem `ScrollController` anexado.

## Arquivos principais envolvidos
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `lib/features/pedido_page/presentation/widgets/pedido_page_layout.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
- `lib/features/pedido_page/presentation/widgets/resumo_pedido.dart`
- `lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pdf_preview_dialog.dart`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/input_formatters/`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Leia o contrato antes de executar qualquer slice.
- Cada slice que alterar comportamento visual, fluxo público da `PedidoPage`, prévia do PDF ou interação do formulário deve atualizar esse contrato.
- Nenhum contrato novo é esperado, porque a tarefa não cria nova Page/View/Tela.

## Slices da tarefa

### Slice 1/5 - Inputs monetários por centavos
Arquivo: `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_1.md`
Resumo esperado: `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_1-resumo.md`

Atividades:
1. Criar ou reaproveitar um formatter/helper único para campos monetários de reais em centavos.
2. Aplicar a regra em `ReciboFormulario`, `ResumoPedido` e `ProdutosServicosTabela`.
3. Garantir que `235` seja interpretado e exibido como `2,35`, enviando `235` centavos para a ViewModel.
4. Atualizar testes de formatter e widgets monetários.
5. Atualizar o contrato da `PedidoPage`.

Validações:
- `dart format lib/features/pedido_page/presentation/input_formatters lib/features/pedido_page/presentation/widgets/recibo_formulario.dart lib/features/pedido_page/presentation/widgets/resumo_pedido.dart lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart test/features/pedido_page/presentation`
- `flutter test test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter analyze`

### Slice 2/5 - Remoção do último item acidental
Arquivo: `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_2.md`
Resumo esperado: `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_2-resumo.md`

Atividades:
1. Ajustar `PedidoPageViewModel.salvarRecibo()` para remover somente o último item quando a descrição estiver vazia e o valor unitário for `0`.
2. Preservar validações de itens intermediários e itens finais preenchidos.
3. Garantir que a persistência receba o recibo já normalizado.
4. Cobrir o comportamento em testes de ViewModel e, se necessário, de página.
5. Atualizar o contrato da `PedidoPage`.

Validações:
- `dart format lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter analyze`

### Slice 3/5 - Autocomplete de clientes no formulário
Arquivo: `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_3.md`
Resumo esperado: `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_3-resumo.md`

Atividades:
1. Substituir o campo simples de cliente por uma experiência estilo combobox/autocomplete no formulário do recibo.
2. Reaproveitar `PedidoPageViewModel.pesquisarClientes()` e `PedidoPageViewModel.selecionarCliente()`.
3. Exibir sugestões no formato `Nome - Telefone - E-mail`, omitindo telefone ou e-mail quando ausentes.
4. Preservar o painel `ClientesPainel` e o fluxo de cadastro/seleção já existente.
5. Atualizar testes de ViewModel/widgets/página e o contrato da `PedidoPage`.

Validações:
- `dart format lib/features/pedido_page/presentation/widgets/recibo_formulario.dart lib/features/pedido_page/presentation/widgets/recibo_pedido.dart lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart test/features/pedido_page/presentation`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter analyze`

### Slice 4/5 - Ações de PDF na prévia
Arquivo: `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_4.md`
Resumo esperado: `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_4-resumo.md`

Atividades:
1. Remover as ações visuais `Imprimir` e `Compartilhar` da linha de ações rápidas do recibo.
2. Adicionar ação `Imprimir` em `ReciboPdfPreviewDialog`, junto das ações de compartilhar, salvar arquivo e fechar.
3. Fazer a impressão da prévia reutilizar `pdfBytes` e `nomeArquivo` já gerados.
4. Preservar o compartilhamento da prévia com `ReciboCompartilhamentoService.compartilharGenerico`.
5. Atualizar testes e o contrato da `PedidoPage`.

Validações:
- `dart format lib/features/pedido_page/presentation/pages/pedido_page.dart lib/features/pedido_page/presentation/widgets/recibo_pedido.dart lib/features/pedido_page/presentation/widgets/recibo_pdf_preview_dialog.dart test/features/pedido_page/presentation`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter analyze`

### Slice 5/5 - Scrollbar e validação final
Arquivo: `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_5.md`
Resumo esperado: `.codex/funcionalidade/funcionalidade-26-05-18-3-parte_5-resumo.md`

Atividades:
1. Corrigir `PedidoPageLayout` para usar `ScrollController` explícito compartilhado entre `Scrollbar` e `SingleChildScrollView`.
2. Preservar `SafeArea`, responsividade, largura máxima e ordem visual dos blocos.
3. Adicionar ou ajustar teste que garanta montagem/rolagem sem exceção.
4. Atualizar o contrato da `PedidoPage`.
5. Rodar validação final ampla dos arquivos impactados.

Validações:
- `dart format lib/features/pedido_page/presentation/widgets/pedido_page_layout.dart test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter analyze`

## Regras gerais
- Executar apenas um slice por vez.
- Nunca executar slices em paralelo.
- Nunca avançar para o próximo slice sem o resumo do slice atual.
- Se um resumo de slice já existir e estiver válido, não repetir esse slice.
- Cada slice deve considerar o estado atualizado do código produzido pelo slice anterior.
- Cada slice que alterar UI deve atualizar `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Cada slice deve ler as regras e skills aplicáveis antes de alterar código.
- Cada slice deve rodar validações conforme a skill aplicável.
- Preservar alterações existentes no worktree.
- Não fazer commit automaticamente.
- Não remover código legado de compartilhamento, impressão ou clientes sem confirmação explícita.

## Resultado esperado
- A digitação monetária passa a trabalhar por centavos nos campos de valor de entrada e valor unitário.
- O salvamento ignora o último item vazio criado acidentalmente por Enter no valor unitário.
- O campo de cliente passa a sugerir clientes cadastrados durante a digitação.
- A linha de ações rápidas fica mais enxuta, com `Gerar PDF` como entrada para prévia.
- A prévia do PDF concentra `Imprimir`, `Compartilhar`, `Salvar arquivo` e `Fechar`.
- A rolagem da `PedidoPage` não dispara mais a exceção de `Scrollbar` sem `ScrollPosition`.
