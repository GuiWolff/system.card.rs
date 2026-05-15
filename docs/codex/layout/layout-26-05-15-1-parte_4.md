# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 4/5 derivado de `docs/codex/layout/layout-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/layout/layout-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/layout/layout-26-05-15-1-parte_3-resumo.md`
- Leia os resumos anteriores para respeitar tema, layout base e cabeçalho já aplicados.

## Arquivos
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
- `lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart`
- `lib/features/pedido_page/presentation/widgets/clientes_painel.dart`
- `lib/features/pedido_page/presentation/widgets/historico_recibos_painel.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`

## Contratos de tela
- Ler antes de alterar:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Atualizar ou revisar neste slice:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Não criar novo contrato de tela.

## Regras
- Usar `lib/resources/recibo.png` como referência para formulário e tabela de produtos/serviços.
- Manter campos, formatadores, callbacks e chaves de teste essenciais.
- Modernizar ações do recibo sem esconder comandos importantes: salvar, novo recibo, histórico, clientes, imprimir, gerar PDF e compartilhar.
- A tabela deve continuar usando builder/lista adequada e não gerar overflow em larguras menores.
- Painéis de clientes e histórico devem seguir o mesmo estilo de superfície, cabeçalho, busca, lista e ações.
- Evitar lógica pesada dentro de `build`.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit.
- Não alterar contratos de repositories, models ou services neste slice.
- Não migrar estado local dos painéis para ViewModel sem necessidade real.
- Não alterar a semântica de salvar, selecionar cliente, listar histórico, carregar, duplicar ou excluir recibos.

## Entregáveis
1. Ações e formulário do recibo modernizados.
2. Tabela de produtos/serviços alinhada ao estilo das referências.
3. Painéis de clientes e histórico harmonizados.
4. Testes atualizados para ações, edição, seleção de cliente e ausência de overflow.
5. Atualizar ou revisar `pedido_page-contrato.md` com as mudanças do recibo editável e painéis.
6. Registrar no resumo do slice quais contratos de tela foram atualizados ou revisados.
7. Salvar resumo em `docs/codex/layout/layout-26-05-15-1-parte_4-resumo.md`.

# Descrição
- Este slice cuida da área de trabalho principal do operador.
- A prioridade é melhorar clareza, densidade, agrupamento e leitura dos campos sem quebrar o fluxo reativo já existente.

## Objetivo
- Ao final deste slice, a edição do recibo deve parecer moderna e consistente com a identidade visual, mantendo comportamento e validações atuais.

## Validações
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
