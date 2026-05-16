# Resumo do slice 1/3 - Ícones Font Awesome no cabeçalho

## Alterações feitas
- Adicionada a dependência `font_awesome_flutter` ao `pubspec.yaml` com lockfile atualizado pelo Flutter.
- `CabecalhoApp` passou a usar `FaIcon` e `FontAwesomeIcons` no cabeçalho.
- Instagram e WhatsApp usam, respectivamente, `FontAwesomeIcons.instagram` e `FontAwesomeIcons.whatsapp`.
- Telefone, endereço e edição usam equivalentes Font Awesome: `phone`, `locationDot` e `penToSquare`.
- Removido o uso de `SvgPicture` e o import de `flutter_svg` do cabeçalho e do teste alterado neste slice.
- O teste `cabecalho_app_test.dart` foi ajustado para validar os `FaIcon` renderizados, sem depender de SVG.
- O contrato `pedido_page-contrato.md` foi atualizado com o novo contrato visual do cabeçalho.

## Validações executadas
- `flutter pub get`: passou.
- `flutter analyze`: passou, sem issues.
- `flutter test test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`: passou, 5 testes.
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`: passou, 22 testes.

## Impacto em UI
- Sim. Os ícones visíveis do cabeçalho mudaram de SVG/Material Icons para Font Awesome.
- A identidade, textos, callbacks, feedback, chave de teste do botão de edição e responsividade do `CabecalhoApp` foram preservados.
- Os arquivos `lib/resources/icon_instagram.svg` e `lib/resources/icon_whatsapp.svg` não foram removidos neste slice.

## Contrato atualizado
- Atualizado `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- O contrato agora registra que Instagram, WhatsApp, telefone, localização e edição do cabeçalho usam `FaIcon`/`FontAwesomeIcons`.

## Pendências e bloqueios
- Não houve bloqueios.
- Os slices 2 e 3 não foram executados.
- O pacote `flutter_svg` permanece no projeto porque a remoção global não faz parte deste slice e pode haver uso legado ou decisão futura de limpeza.
