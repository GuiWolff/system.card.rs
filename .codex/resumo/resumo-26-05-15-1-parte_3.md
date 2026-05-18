# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 3/4 derivado de `docs/codex/resumo/resumo-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/resumo/resumo-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/resumo/resumo-26-05-15-1-parte_2-resumo.md`
- Antes de iniciar, leia os resumos dos slices anteriores e use o estado já criado para alimentar a UI.

## Arquivos
- `AGENTS.md`
- `lib/resources/resumo.png`
- `lib/resources/tema.jpeg`
- `lib/resources/recibo.png`
- `lib/features/recibo/presentation/pages/recibo_page.dart`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `lib/features/recibo/presentation/widgets/resumo_pedido.dart`
- `lib/features/recibo/presentation/widgets/recibo_form.dart`
- `lib/features/recibo/presentation/widgets/produtos_servicos.dart`
- `lib/features/recibo/presentation/viewmodels/recibo_page_view_model.dart`
- `test/features/recibo/presentation/widgets/resumo_pedido_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Atualizar `recibo_page-contrato.md` com o posicionamento e os estados visuais do `ResumoPedido`.

## Regras
- Criar o widget `ResumoPedido` como componente visual composto.
- Posicionar `ResumoPedido` abaixo do widget de recibo/produtos dentro da coluna da `ReciboPage`.
- Seguir a referência de `resumo.png` para:
  - título `RESUMO`;
  - rótulo `Total do Pedido:`;
  - rótulo `Valor Entrada:`;
  - rótulo `Valor a pagar na Entrega:`;
  - destaque verde no valor a pagar na entrega;
  - campos com aparência de entrada/caixa de valor.
- Em telas largas, manter os três campos distribuídos como na referência visual quando houver espaço.
- Em telas estreitas, empilhar ou quebrar os campos sem overflow horizontal.
- O campo `Valor Entrada` deve refletir a regra de edição definida no slice anterior.
- Usar cores e estilos do tema existente quando disponíveis; se o tema customizado ainda não existir, usar `Theme.of(context)` sem criar dependência falsa.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não renderize `resumo.png` como widget final único.
- Não recorte assets sem autorização explícita.
- Não coloque regra de cálculo monetário dentro do `build`.
- Não altere o layout da visualização do recibo além do necessário para posicionar o resumo.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. `ResumoPedido` criado e integrado abaixo do widget de recibo/produtos.
2. Layout responsivo sem overflow nos breakpoints relevantes.
3. Testes de widget para textos, valores e estrutura visual principal.
4. `recibo_page-contrato.md` atualizado com o comportamento visual do resumo.
5. Registrar no resumo do slice quais contratos de tela foram criados, atualizados ou revisados.
6. Rodar validações específicas.
7. Salvar resumo em `docs/codex/resumo/resumo-26-05-15-1-parte_3-resumo.md`.

# Descrição
- Criar e integrar o bloco visual de resumo financeiro abaixo do widget de recibo.

## Objetivo
- Ao final deste slice, a `ReciboPage` deve exibir o resumo financeiro abaixo do recibo, com valores alimentados pelo estado da tela e layout compatível com desktop, tablet e mobile.
