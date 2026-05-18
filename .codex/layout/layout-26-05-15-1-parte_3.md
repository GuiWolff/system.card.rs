# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 3/5 derivado de `docs/codex/layout/layout-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/layout/layout-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/layout/layout-26-05-15-1-parte_2-resumo.md`
- Leia também `docs/codex/layout/layout-26-05-15-1-parte_1-resumo.md` para confirmar a paleta aplicada no tema.

## Arquivos
- `lib/features/pedido_page/presentation/widgets/cabecalho_app.dart`
- `lib/features/pedido_page/presentation/widgets/cabecalho_editor_dialog.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`, somente se precisar ajustar encaixe do cabeçalho.
- `test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`

## Contratos de tela
- Ler antes de alterar:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Atualizar ou revisar neste slice:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Não criar novo contrato de tela.

## Regras
- Usar `lib/resources/cabecalho.png` e o topo de `lib/resources/tema.jpeg` como referência.
- Preservar identidade, contatos, ações e menu existentes.
- Botões devem manter ícones, estados desabilitados e feedback de carregamento.
- A hierarquia visual deve deixar a marca forte, contatos legíveis e ações fáceis de localizar.
- Em mobile, empilhar sem cortar textos importantes.
- `CabecalhoEditorDialog` deve seguir o mesmo vocabulário visual, sem mudar regras de persistência ou logo.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit.
- Não alterar `CabecalhoEmpresa`, repositories ou ViewModel neste slice, salvo se um ajuste visual exigir dado já inexistente e for justificado.
- Não remover callbacks existentes.

## Entregáveis
1. `CabecalhoApp` modernizado e responsivo.
2. Ações do cabeçalho visualmente alinhadas com a paleta de marca.
3. `CabecalhoEditorDialog` harmonizado com o novo tema.
4. Testes do cabeçalho atualizados sem perder cobertura de callbacks, menu, logo e overflow.
5. Atualizar ou revisar `pedido_page-contrato.md` com o estado visual do cabeçalho.
6. Registrar no resumo do slice quais contratos de tela foram atualizados ou revisados.
7. Salvar resumo em `docs/codex/layout/layout-26-05-15-1-parte_3-resumo.md`.

# Descrição
- Este slice foca apenas na região superior e nos pontos de entrada de ação mais importantes.
- O cabeçalho é a principal âncora de identidade visual, então ele deve definir o tom dos demais componentes sem concentrar lógica nova.

## Objetivo
- Ao final deste slice, o cabeçalho deve refletir claramente a identidade System Card - RS e continuar funcional em desktop, tablet e mobile.

## Validações
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
