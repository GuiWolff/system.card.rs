# Resumo do slice 1/6 - Persistência do cabeçalho

## Escopo executado
- Preparada a persistência dos dados editáveis do cabeçalho sem alterar a interface.
- `CabecalhoEmpresa` agora representa `logoBase64` opcional, preservando `CabecalhoEmpresa.systemCardRs()` como fallback padrão.
- Criado `CabecalhoPreferenciasRepository` baseado em `SharedPreferences`.
- As chaves de preferências foram definidas com prefixo isolado `pedido_page.cabecalho.*`.
- O repository carrega dados salvos, salva dados editáveis, remove somente o logo e restaura o padrão.
- Dados ausentes, vazios ou inválidos caem para os valores padrão da System Card - RS.
- Logo base64 inválido é tratado como ausente, preservando o fallback visual atual para os próximos slices.

## Arquivos alterados
- `lib/features/pedido_page/domain/models/cabecalho_empresa.dart`
- `lib/features/pedido_page/data/repositories/cabecalho_preferencias_repository.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `test/features/pedido_page/data/repositories/cabecalho_preferencias_repository_test.dart`

## Contratos de tela
- Contrato revisado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Nenhum novo contrato de tela foi criado.
- A revisão registra que a persistência foi preparada, mas ainda não está conectada à `PedidoPageViewModel` nem à UI.

## Validações
- `flutter analyze`: passou, sem issues.
- `flutter test test/features/pedido_page/data/repositories/cabecalho_preferencias_repository_test.dart test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`: passou, 22 testes.

## Fora do escopo preservado
- Não houve alteração de UI.
- Não foi implementado editor visual do cabeçalho.
- Não foi implementada seleção de imagem.
- Não foi implementado cadastro de clientes.
- Não foi feito commit.
