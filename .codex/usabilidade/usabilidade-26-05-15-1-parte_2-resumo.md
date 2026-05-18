# Resumo - Usabilidade 2026-05-15 - Parte 2/3

## Slice executado
- `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_2.md`

## O que foi feito
- Criada a intenção `PedidoPageViewModel.solicitarNovoItem`, centralizando a guarda de criação de nova linha.
- O botão `Adicionar item` agora usa a mesma regra aplicada ao Enter.
- O campo `Valor unitário` passa a enviar a linha com `TextInputAction.done`/Enter.
- Enter cria novo item quando o valor unitário da linha atual é maior que zero.
- Enter e botão bloqueiam nova linha quando o item de referência está com valor unitário zero.
- Em lista vazia, o botão continua criando a primeira linha de rascunho.
- Quando o bloqueio acontece por Enter, o foco volta para o campo `Valor unitário`.
- O feedback de bloqueio usa o fluxo existente de erro do `ReciboPedido`, sem diálogo.

## Arquivos alterados
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`

## Impacto em UI
- Sim. A tabela de produtos/serviços ganhou atalho por Enter no campo `Valor unitário` e feedback visível quando a criação é bloqueada por valor zero.
- O contrato revisado foi `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Não foi criada nova Page/View/Tela.

## Validações executadas
- `flutter analyze` passou.
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart` passou.
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart` passou.
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart` passou.

## Continuidade
- Próximo slice: `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_3.md`.
- A parte 3 deve bloquear edição direta de recibos carregados do histórico.
- A parte 3 deve preservar `solicitarNovoItem`, as chaves estáveis e os controladores locais criados nas partes anteriores.
