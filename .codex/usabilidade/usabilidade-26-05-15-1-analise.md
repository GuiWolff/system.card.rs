# Análise da tarefa

## Pedido original
- Corrigir os campos de texto e número que perdem foco a cada dígito digitado.
- Permitir adicionar item ao pressionar Enter no campo `Valor unitário`.
- Impedir criação de novo item quando o valor unitário usado como referência for zero.
- Impedir edição de pedido/recibo carregado a partir do histórico.

## Feature correspondente
- Feature: `pedido_page`.
- Caminho principal: `lib/features/pedido_page/`.
- A tarefa impacta a tela agregadora `PedidoPage`, o bloco `ReciboPedido`, o formulário de recibo, a tabela de produtos/serviços, o resumo financeiro, o painel de histórico e a `PedidoPageViewModel`.

## Arquivos relacionados
- Produção:
  - `lib/features/pedido_page/presentation/pages/pedido_page.dart`
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
  - `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
  - `lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart`
  - `lib/features/pedido_page/presentation/widgets/resumo_pedido.dart`
  - `lib/features/pedido_page/presentation/widgets/historico_recibos_painel.dart`
  - `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
  - `lib/features/pedido_page/domain/models/item_recibo.dart`
  - `lib/features/pedido_page/domain/models/recibo.dart`
- Testes:
  - `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
  - `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
  - `test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`
  - `test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`
  - `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`

## Estado atual
- `ReciboPedido` é renderizado dentro de `Obx`; qualquer alteração na `PedidoPageViewModel` reconstrói o bloco.
- `ReciboFormulario`, `ProdutosServicosTabela` e `ResumoPedido` usam `TextFormField` com `initialValue` e chaves dependentes do valor atual, como `ValueKey('$label-$valorInicial')`, `ValueKey('descricao-$indice-${item.descricao}')`, `ValueKey('valor-unitario-$indice-${item.valorUnitarioCentavos}')` e `ValueKey('resumo-valor-entrada-$valor')`.
- Ao digitar, o `onChanged` atualiza a ViewModel, o `Obx` reconstrói a árvore, a chave muda, o campo é remontado e o foco é perdido.
- O botão `Adicionar item` em `ReciboPedido` cria um item vazio com `valorUnitarioCentavos: 0` sem qualquer guarda.
- O campo `Valor unitário` em `ProdutosServicosTabela` não possui `onFieldSubmitted`/`onSubmitted`, então Enter não adiciona nova linha.
- `PedidoPageViewModel.carregarRecibo` carrega o recibo do histórico e marca `reciboAtualSalvo` como `true`, mas os métodos de atualização continuam podendo alterar campos, itens, entrada e salvar novamente o mesmo registro.
- `HistoricoRecibosPainel` já diferencia ações de `Carregar` e `Duplicar`, o que permite usar `Carregar` como visualização somente leitura e `Duplicar` como caminho para edição de uma cópia.

## Estado esperado
- Campos de texto e número devem manter foco enquanto o usuário digita, sem exigir recuperar foco com o mouse a cada dígito.
- A UI deve usar chaves estáveis e estado local controlado por `TextEditingController`/`FocusNode` apenas na camada de apresentação, sem mover regra visual para a ViewModel.
- Pressionar Enter no campo `Valor unitário` deve solicitar a criação de um novo item quando o valor unitário da linha atual for maior que zero.
- Não deve ser criado novo item quando o valor unitário da linha atual, ou do último item no fluxo de adição pelo formulário, for zero.
- Em lista vazia, o botão `+ Adicionar item` pode criar a primeira linha de rascunho para permitir digitação; depois disso, uma nova linha só deve ser criada quando o item de referência tiver valor unitário maior que zero.
- Recibo carregado pelo histórico deve entrar em modo somente leitura: campos, itens e valor de entrada não devem ser editáveis; salvar/atualizar o mesmo registro deve ser bloqueado; `Duplicar` deve continuar sendo o caminho para criar uma cópia editável.
- `Novo recibo` e `Duplicar` devem sair do modo somente leitura.

## Riscos e dependências
- A correção de foco exige cuidado para não sobrescrever o texto em edição durante `didUpdateWidget`, principalmente quando valores externos mudarem por carregar histórico, duplicar recibo ou iniciar novo recibo.
- Testes atuais localizam campos por chaves que incluem o valor; essas chaves deverão ser estabilizadas e os testes atualizados.
- Guardas de item com valor zero não devem impedir a criação da primeira linha vazia, senão o usuário não terá onde digitar o primeiro item.
- A regra de histórico deve ser aplicada tanto na UI quanto na ViewModel, porque somente desabilitar campos não impede chamadas diretas em testes ou fluxos futuros.
- Bloquear edição de recibo carregado do histórico pode afetar `salvarRecibo`, `atualizarItem`, `removerItem`, `atualizarValorEntradaCentavos`, `atualizarCliente`, datas e observações.
- O worktree já possui alterações em vários arquivos da feature; preservar esse estado e evitar reescritas amplas é obrigatório.

## Contratos de tela
- Contrato existente que deve ser lido antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos que precisam ser criados:
  - Nenhum. A tarefa não cria nova Page/View/Tela.
- Contratos que precisam ser atualizados:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`, porque a `PedidoPage` e seus blocos internos terão comportamento visual e de interação alterado.

## Estratégia
- Dividir a tarefa em três slices sequenciais para reduzir regressão:
  1. estabilizar foco e chaves/controladores dos campos;
  2. adicionar fluxo de Enter em valor unitário com guarda contra valor zero;
  3. implementar modo somente leitura para recibos carregados do histórico.
- Manter as alterações dentro da feature `pedido_page`, preservando modelos, repositories e serviços salvo necessidade direta.
- Atualizar testes no mesmo slice em que o comportamento muda.
- Atualizar o contrato da `PedidoPage` em cada slice que alterar interação de tela.

## Decisão sobre slices
- Haverá slices.
- Justificativa: a tarefa altera múltiplas responsabilidades, incluindo widgets de formulário, tabela, resumo, ViewModel, histórico e testes. Também envolve estado reativo, foco de teclado, validação de item e modo somente leitura, com risco de regressão em fluxos de edição e persistência.

## Validações recomendadas
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`
- `flutter test` no fechamento, se os slices alterarem comportamento compartilhado de recibo/histórico.
