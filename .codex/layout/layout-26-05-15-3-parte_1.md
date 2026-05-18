# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 1/3 derivado de `docs/codex/layout/layout-26-05-15-3.md`.

## Análise da tarefa
- `docs/codex/layout/layout-26-05-15-3-analise.md`

## Continuidade
- Este é o primeiro slice; não há resumo anterior.

## Arquivos
- `pubspec.yaml`
- `pubspec.lock`
- `lib/features/pedido_page/presentation/widgets/cabecalho_app.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`

## Contratos de tela
- Ler e atualizar:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Não criar contrato novo.
- Impacto em UI: sim, por alteração dos ícones visíveis do cabeçalho.

## Regras
- Adicionar `font_awesome_flutter` como dependência do projeto.
- Preferir executar `flutter pub add font_awesome_flutter`; se editar manualmente o `pubspec.yaml`, rodar `flutter pub get` em seguida.
- Em `CabecalhoApp`, substituir `SvgPicture` por `FaIcon`/`FontAwesomeIcons`.
- Usar:
  - `FontAwesomeIcons.instagram` para Instagram;
  - `FontAwesomeIcons.whatsapp` para WhatsApp;
  - equivalentes Font Awesome para telefone, localização e edição.
- Remover imports de `flutter_svg` do código e dos testes alterados neste slice quando deixarem de ser usados.
- Não excluir `lib/resources/icon_instagram.svg` nem `lib/resources/icon_whatsapp.svg` neste slice.
- Preservar callbacks, chaves de teste, responsividade e APIs públicas do `CabecalhoApp` sempre que possível.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas dos outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit.
- Não alterar regras da `PedidoPageViewModel`, persistência, PDF, compartilhamento ou formulário de recibo.

## Entregáveis
1. Dependência `font_awesome_flutter` adicionada e lockfile atualizado.
2. `CabecalhoApp` usando `FaIcon`/`FontAwesomeIcons` no cabeçalho.
3. Teste do cabeçalho ajustado para não depender de `SvgPicture`.
4. `pedido_page-contrato.md` atualizado com o novo contrato visual do cabeçalho.
5. Rodar validações específicas.
6. Salvar resumo em `docs/codex/layout/layout-26-05-15-3-parte_1-resumo.md`.

# Descrição
- Este slice introduz a dependência e migra o cabeçalho, que concentra os ícones de marca solicitados explicitamente: Instagram e WhatsApp.

## Objetivo
- Ao final deste slice, o cabeçalho da `PedidoPage` não deve mais depender de SVG para Instagram/WhatsApp e deve renderizar seus ícones visíveis com `font_awesome_flutter`.

## Validações obrigatórias
- `flutter pub get`
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
