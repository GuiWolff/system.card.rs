# Resumo do slice 1/2 - Regra incremental e data de criação persistida

## O que foi feito
- `ReciboRepository` passou a expor `proximoNumero()`.
- `ReciboRepositorySqlite` calcula o próximo número usando os recibos persistidos no SQLite como fonte de verdade.
- A geração incremental ignora números legados não numéricos e considera apenas valores compostos por dígitos.
- O formato gerado usa preenchimento à esquerda com quatro posições, como `0001`, `0002` e `0003`.
- `salvar` agora atribui automaticamente o próximo número quando o recibo novo chega sem número preenchido.
- `salvar` preserva números já informados por fluxos legados ou testes.
- A garantia de `criadoEm` como `DateTime` no objeto retornado foi reforçada pelos testes de repository.
- `atualizar` preserva a data de criação original do recibo persistido.

## Arquivos alterados
- `lib/features/pedido_page/domain/repositories/recibo_repository.dart`
- `lib/features/pedido_page/data/repositories/recibo_repository_sqlite.dart`
- `test/features/pedido_page/data/repositories/recibo_repository_sqlite_test.dart`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`

## Contratos de tela
- Revisado: `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Não foi criado novo contrato de tela.
- Não houve impacto visual direto neste slice: nenhuma Page, widget, rota, layout ou formulário foi alterado.
- A integração visual do número incremental automático permanece para o slice 2.

## Validações executadas
- `flutter analyze`: passou, sem issues.
- `flutter test test/features/pedido_page/data/repositories/recibo_repository_sqlite_test.dart`: passou.
- `flutter test test/features/pedido_page/data/datasources/recibo_database_test.dart`: passou.

## Continuidade para o slice 2
- Conectar `ReciboRepository.proximoNumero()` à `PedidoPageViewModel`.
- Preparar recibos novos com número incremental quando houver repository configurado.
- Ajustar a UI do formulário para comunicar que o número é gerado automaticamente.
- Atualizar testes de ViewModel, widgets e Page.
- Atualizar novamente o contrato da `PedidoPage` com o comportamento visual final.
