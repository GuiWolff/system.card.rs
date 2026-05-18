# Resumo do slice 2/6 - Estado reativo do cabeçalho editável

## Escopo executado
- Conectado o cabeçalho editável à `PedidoPageViewModel` como fonte de verdade reativa.
- `cabecalhoEmpresa` foi preservado como getter público para manter a API consumida pela `PedidoPage` e pelo `CabecalhoApp`.
- O estado interno do cabeçalho passou a usar `Rx<CabecalhoEmpresa>`.
- A ViewModel passou a aceitar `CabecalhoPreferenciasRepository` por construtor ou por configuração posterior.
- A `PedidoPage` inicializa o repository padrão de cabeçalho quando cria sua própria ViewModel.
- Falhas de persistência do cabeçalho são expostas em `erroCabecalho`, sem lançar erro para a UI.

## Comandos adicionados à ViewModel
- `configurarCabecalhoRepository`
- `carregarCabecalho`
- `atualizarCabecalhoEmpresa`
- `salvarCabecalho`
- `restaurarCabecalhoPadrao`
- `definirLogoCabecalhoBase6l4`
- `removerLogoCabecalho`

## Estados adicionados à ViewModel
- `carregandoCabecalho`
- `salvandoCabecalho`
- `erroCabecalho`
- `cabecalhoEmpresa` reativo, mantendo a API pública existente

## Arquivos alterados
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`

## Contratos de tela
- Contrato atualizado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Nenhum novo contrato de tela foi criado.
- A atualização registra os estados e comandos públicos do cabeçalho editável.

## Validações
- `flutter test test/features/pedido_page/data/repositories/cabecalho_preferencias_repository_test.dart test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`: passou, 22 testes.
- `flutter analyze`: passou, sem issues.
- `flutter test`: passou, 62 testes.

## Fora do escopo preservado
- Não foi implementado editor visual do cabeçalho.
- Não foi implementada seleção de imagem.
- Não foi implementada prévia visual de logo base64.
- Não foi implementado cadastro de clientes.
- Não foi executado o próximo slice.
- Não foi feito commit.
