# Resumo do slice 2/2 - Integração na ViewModel e UI do recibo

## O que foi feito
- `PedidoPageViewModel` passou a expor `prepararProximoNumeroRecibo()`.
- A `PedidoPage` dispara a preparação inicial do número pela ViewModel, mantendo widgets sem acesso direto ao SQLite.
- `iniciarNovoRecibo` recria o recibo em edição e recalcula o próximo número quando há repository configurado.
- `salvarRecibo` prepara o próximo número antes da validação quando o recibo novo ainda não tem número.
- `duplicarRecibo` agora cria uma cópia sem ids e recebe novo número incremental antes de salvar.
- `ReciboFormulario` mantém o campo `Número do recibo` visível como somente leitura.
- O campo de número comunica `Gerado automaticamente pelo sistema`.
- Carregamento e edição de recibos existentes preservam o número salvo.

## Arquivos alterados
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`

## Contratos de tela
- Atualizado: `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Não foi criado novo contrato de tela.
- Houve impacto visual direto na `PedidoPage`: o campo `Número do recibo` do formulário passou a ser somente leitura e exibir a indicação de geração automática.
- A alteração visual permanece dentro da composição real da `PedidoPage`, sem criação de `ReciboPage`.

## Validações executadas
- `flutter analyze`: passou, sem issues.
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`: passou.
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`: passou.
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`: passou.

## Continuidade
- Rodar `flutter test` completo no fechamento.
- Conferir se não há imports não utilizados após a validação completa.
