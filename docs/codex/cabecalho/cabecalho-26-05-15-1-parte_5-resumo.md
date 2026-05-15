# Resumo do slice 5/6 - Cadastro, busca e seleção de clientes

## Escopo executado
- Integrado `ClienteRepository` à `PedidoPageViewModel` por injeção.
- Expostos estado, carregamento, erro, feedback, busca e lista de clientes pela ViewModel.
- Criados comandos para listar, pesquisar, salvar e selecionar clientes.
- Implementada seleção de cliente preenchendo `cliente` e `telefone` no recibo em edição.
- Mantida normalização de telefone no estado persistível do recibo.
- Criada máscara visual de telefone na apresentação.
- Criado painel de clientes com cadastro, busca, listagem via `ListView.builder` e seleção.
- Integrado o painel ao `ReciboPedido` por diálogo aberto pela ação `Clientes`.
- Conectada a criação padrão da `PedidoPage` ao `ClienteRepositorySqlite`, compartilhando o mesmo `ReciboDatabase` usado pelos recibos.
- Exportado `ClientesPainel` pelo barrel público da feature.

## Arquivos alterados
- `lib/features/pedido_page/pedido_page.dart`
- `lib/features/pedido_page/presentation/input_formatters/telefone_input_formatter.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/widgets/clientes_painel.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`

## Contratos de tela
- Contrato atualizado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Nenhum novo contrato de tela foi criado.
- O contrato registra que clientes permanecem dentro da composição da `PedidoPage`, sem criação de Page própria.

## Testes adicionados ou ajustados
- `PedidoPageViewModel` listando, pesquisando, salvando e selecionando clientes.
- `PedidoPageViewModel` expondo mensagem clara para telefone duplicado.
- `ClientesPainel` pesquisando, cadastrando, aplicando máscara e selecionando cliente.
- `ClientesPainel` exibindo erro e estado vazio.
- `ReciboPedido` abrindo o painel de clientes e selecionando cliente para preencher o recibo.

## Validações
- `flutter analyze`: passou, sem issues.
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart test/features/pedido_page/presentation/widgets/clientes_painel_test.dart test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart test/features/pedido_page/presentation/pages/pedido_page_test.dart test/features/pedido_page/data/datasources/recibo_database_test.dart test/features/pedido_page/data/repositories/cliente_repository_sqlite_test.dart`: passou, 46 testes.
- `flutter test`: passou, 79 testes.

## Fora do escopo preservado
- Não foi implementada importação/exportação de clientes.
- Não foram alteradas regras de cálculo do recibo.
- Não foi alterado o schema SQLite criado no slice anterior.
- Não foi implementada impressão real ou geração real de PDF.
- Não foi executado o próximo slice.
- Não foi feito commit.
