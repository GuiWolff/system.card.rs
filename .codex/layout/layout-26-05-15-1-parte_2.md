# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 2/5 derivado de `docs/codex/layout/layout-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/layout/layout-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/layout/layout-26-05-15-1-parte_1-resumo.md`
- Se o resumo anterior existir e estiver válido, não refaça o slice 1.

## Arquivos
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/widgets/pedido_page_layout.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `test/widget_test.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`

## Contratos de tela
- Ler antes de alterar:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Atualizar ou revisar neste slice:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Não criar novo contrato de tela.

## Regras
- Remover texto técnico visível como `Bloco inicial real de recibo integrado à composição do pedido.` da experiência final.
- Modernizar a estrutura da `PedidoPage` mantendo os blocos reais: cabeçalho, recibo e resumo.
- Preservar rolagem vertical, largura máxima e ausência de overflow.
- Usar superfícies do tema (`backgroundPrimario`, `backgroundSecundario` via `ThemeData`) em vez de cores soltas.
- Manter a ordem visual esperada pelos testes ou atualizar testes quando a nova ordem for intencional e documentada.
- A `PedidoPage` não deve ganhar regra de negócio.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit.
- Não alterar aparência interna de `CabecalhoApp`, `ReciboFormulario`, `ProdutosServicosTabela`, `ResumoPedido` ou `VisualizacaoRecibo` além do necessário para encaixe.
- Não alterar APIs públicas sem necessidade.

## Entregáveis
1. `PedidoPage` sem textos técnicos de placeholder na UI final.
2. `PedidoPageLayout` modernizado com espaçamento, largura e superfícies consistentes.
3. Testes da página/layout atualizados para o comportamento visual esperado.
4. Atualizar ou revisar `pedido_page-contrato.md` com a nova composição.
5. Registrar no resumo do slice quais contratos de tela foram atualizados ou revisados.
6. Rodar validações específicas.
7. Salvar resumo em `docs/codex/layout/layout-26-05-15-1-parte_2-resumo.md`.

# Descrição
- Este slice moderniza o esqueleto da tela antes de mexer nos componentes internos.
- A referência principal é `lib/resources/tema.jpeg`: cabeçalho forte, áreas de trabalho bem separadas e leitura rápida em desktop, com empilhamento seguro em telas menores.

## Objetivo
- Ao final deste slice, a tela principal deve parecer uma ferramenta finalizada, ainda que os componentes internos sejam modernizados nos próximos slices.

## Validações
- `flutter analyze`
- `flutter test test/widget_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
