# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 1/4 derivado de `docs/codex/layout/layout-26-05-15-2.md`.

## Análise da tarefa
- `docs/codex/layout/layout-26-05-15-2-analise.md`

## Continuidade
- Este é o primeiro slice; não há resumo anterior.

## Arquivos
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `lib/features/pedido_page/presentation/widgets/cabecalho_app.dart`
- `lib/features/pedido_page/presentation/widgets/cabecalho_editor_dialog.dart`
- `lib/features/pedido_page/domain/models/cabecalho_empresa.dart`
- `test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `pubspec.yaml`, somente se for necessário adicionar dependência para ícones reais de Instagram/WhatsApp.

## Contratos de tela
- Ler antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Atualizar neste slice:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Não criar novo contrato. O impacto visual continua na `PedidoPage`.

## Regras
- Remover da experiência visual do cabeçalho os botões `Imprimir`, `Gerar PDF` e `MAIS OPÇÕES`.
- Preservar APIs públicas quando possível. Se callbacks ou tipos antigos ficarem sem uso, não removê-los sem necessidade; apenas não renderizar as ações removidas.
- Mover a ação `Editar cabeçalho` para dentro do `CabecalhoApp`, com parâmetro opcional como `onEditarCabecalho` e estado habilitado/desabilitado passado pela `PedidoPage`.
- Remover o botão externo `Editar cabeçalho` da `PedidoPage`.
- Manter `CabecalhoApp` responsivo em mobile, tablet e desktop.
- Usar ícones de marca para Instagram e WhatsApp. Como o projeto não possui pacote de ícones de marca no `pubspec.yaml` atual, escolha a menor solução consistente:
  - preferir pacote focado em ícones de marca, se adotado pelo projeto;
  - ou usar assets SVG pequenos e versionados, aproveitando `flutter_svg` já existente;
  - manter fallback Material Icons para telefone e endereço.
- Não hardcodar cores fora do padrão atual. Usar `Theme.of(context).colorScheme` e tokens já centralizados pelo tema.
- Modernizar `CabecalhoEditorDialog` com hierarquia visual melhor, prefix icons nos campos e organização mais clara, sem alterar as regras de persistência.
- Manter seleção, remoção e restauração de logo funcionando.
- Atualizar testes que hoje esperam as ações removidas no cabeçalho.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não altere cadastro de clientes, SQLite, tabela de produtos ou layout do recibo neste slice.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Cabeçalho sem os botões `Imprimir`, `Gerar PDF` e `MAIS OPÇÕES`.
2. Botão `Editar cabeçalho` dentro do `CabecalhoApp`.
3. Ícones adequados para Instagram, WhatsApp, telefone e endereço.
4. `CabecalhoEditorDialog` modernizado, mantendo comportamento existente.
5. Testes atualizados para o novo comportamento do cabeçalho.
6. Contrato `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md` atualizado.
7. Rodar validações específicas.
8. Salvar resumo em `docs/codex/layout/layout-26-05-15-2-parte_1-resumo.md`.

# Descrição
- Este slice concentra os ajustes do cabeçalho e do editor de cabeçalho. O objetivo é limpar as ações duplicadas ou indesejadas do cabeçalho, trazer a edição para o contexto correto e melhorar a leitura visual dos contatos.

## Objetivo
- Ao final deste slice, o cabeçalho deve ser uma área de identidade e contato, com edição contextual integrada, sem ações de recibo no topo da tela.
