# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 3/6 derivado de `docs/codex/cabecalho/cabecalho-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/cabecalho/cabecalho-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_2-resumo.md`
- Antes de iniciar, leia os resumos anteriores e use o estado já criado para alimentar a UI.

## Arquivos
- `pubspec.yaml`
- `lib/features/pedido_page/domain/models/cabecalho_empresa.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/widgets/cabecalho_app.dart`
- `lib/features/pedido_page/presentation/widgets/cabecalho_editor_dialog.dart`
- `test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Atualizar `pedido_page-contrato.md` com editor visual de cabeçalho e seleção de logo.

## Regras
- Criar um fluxo de edição dentro da `PedidoPage`, preferencialmente via dialog/painel, sem criar nova Page.
- O usuário deve conseguir editar nome, subtítulo, Instagram, WhatsApp, telefone e endereço.
- O usuário deve conseguir selecionar e remover logo.
- A seleção de imagem deve acontecer na UI; a ViewModel deve receber bytes/base64 ou comando equivalente sem acessar `BuildContext`.
- Se for necessária nova dependência para selecionar arquivo/imagem, atualizar `pubspec.yaml` de forma localizada e compatível com Web/Desktop/Mobile.
- `CabecalhoApp` deve renderizar logo base64 quando existir e manter fallback `SC` quando não existir.
- Evitar overflow em larguras representativas.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente cadastro de clientes.
- Não implemente impressão real ou PDF real.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Editor visual de cabeçalho integrado à `PedidoPage`.
2. Seleção e remoção de logo com persistência via estado criado nos slices anteriores.
3. `CabecalhoApp` renderizando logo base64 ou fallback `SC`.
4. Testes de widget para edição, fallback, logo e responsividade.
5. Atualizar `pedido_page-contrato.md`.
6. Registrar no resumo do slice quais contratos de tela foram criados, atualizados ou revisados.
7. Rodar validações específicas.
8. Salvar resumo em `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_3-resumo.md`.

# Descrição
- Criar a interface para editar e persistir o cabeçalho, incluindo logo selecionado.

## Objetivo
- Ao final deste slice, o cabeçalho deve poder ser editado pela UI e refletir imediatamente os dados salvos, preservando o fallback visual quando não houver logo.
