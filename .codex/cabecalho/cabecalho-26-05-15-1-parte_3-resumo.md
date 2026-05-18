# Resumo do slice 3/6 - Editor visual do cabeçalho e logo

## Escopo executado
- Integrado fluxo de edição do cabeçalho dentro da `PedidoPage`, sem criar nova Page.
- Criado `CabecalhoEditorDialog` para editar nome, subtítulo, Instagram, WhatsApp, telefone e endereço.
- Adicionada seleção de imagem pela UI com `file_picker`, convertendo bytes para base64 na camada de apresentação.
- Limitada a seleção de logo a arquivos `png`, `jpg`, `jpeg` e `webp` com até 768 KB.
- Conectado o salvamento do editor aos comandos reativos já existentes na `PedidoPageViewModel`.
- Conectada remoção de logo com persistência via `removerLogoCabecalho`.
- `CabecalhoApp` passou a renderizar `logoBase64` com `Image.memory` quando existir imagem válida.
- Preservado fallback visual `SC` quando não houver logo base64 ou quando a decodificação falhar.
- Exportado o novo widget pelo barrel da feature `pedido_page`.
- Adicionada a dependência `file_picker` no `pubspec.yaml` via `flutter pub add file_picker`.

## Arquivos alterados
- `pubspec.yaml`
- `pubspec.lock`
- `windows/flutter/generated_plugins.cmake`
- `lib/features/pedido_page/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `lib/features/pedido_page/presentation/widgets/cabecalho_app.dart`
- `lib/features/pedido_page/presentation/widgets/cabecalho_editor_dialog.dart`
- `test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`

## Contratos de tela
- Contrato atualizado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Nenhum novo contrato de tela foi criado.
- A atualização registra o editor visual do cabeçalho, seleção/remoção de logo, limite de arquivo e fallback `SC`.

## Testes adicionados ou ajustados
- `CabecalhoApp` renderizando logo base64.
- `PedidoPage` editando e salvando dados do cabeçalho pelo diálogo.
- `PedidoPage` removendo logo e preservando fallback `SC`.
- Ajuste no teste de histórico para garantir visibilidade do botão `Salvar` após o novo botão de edição do cabeçalho.

## Validações
- `flutter analyze`: passou, sem issues.
- `flutter test test/features/pedido_page/data/repositories/cabecalho_preferencias_repository_test.dart test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart test/features/pedido_page/presentation/pages/pedido_page_test.dart`: passou, 37 testes.
- `flutter test`: passou, 65 testes.

## Fora do escopo preservado
- Não foi implementado cadastro de clientes.
- Não foi implementada máscara de telefone.
- Não foi criado SQLite de clientes.
- Não foi implementada impressão real.
- Não foi implementada geração real de PDF.
- Não foi executado o próximo slice.
- Não foi feito commit.
