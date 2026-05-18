# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 3/3 derivado de `docs/codex/layout/layout-26-05-15-3.md`.

## Análise da tarefa
- `docs/codex/layout/layout-26-05-15-3-analise.md`

## Continuidade
- Slice anterior: `docs/codex/layout/layout-26-05-15-3-parte_2-resumo.md`
- Antes de iniciar, leia os resumos dos slices 1 e 2 para preservar decisões de mapeamento visual já adotadas.

## Arquivos
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
- `lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart`
- `lib/features/pedido_page/presentation/widgets/visualizacao_recibo.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`

## Contratos de tela
- Ler e atualizar:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Não criar contrato novo.
- Impacto em UI: sim, por alteração dos ícones do recibo editável e da prévia visual.

## Regras
- Migrar ícones de `ReciboPedido`, `ReciboFormulario`, `ProdutosServicosTabela` e `VisualizacaoRecibo` para `FaIcon`/`FontAwesomeIcons`.
- Usar ícones de marca para Instagram e WhatsApp também na `VisualizacaoRecibo`, quando esses contatos estiverem representados por ícone.
- Não alterar cálculos, validações, persistência, geração de PDF nem compartilhamento.
- Não tentar usar `FontAwesomeIcons` dentro de `ReciboPdfService`; esta tarefa cobre widgets Flutter de apresentação.
- Fazer varredura final em `lib/features/pedido_page/presentation` por:
  - `Icons.`;
  - `SvgPicture`;
  - `flutter_svg`;
  - imports não utilizados.
- Se ainda houver `Icons.*` fora do escopo deste slice, registrar no resumo a justificativa técnica.
- Não remover SVGs legados sem confirmação explícita.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas já concluídas.
- Não execute automaticamente outra tarefa.
- Não faça commit.
- Não alterar APIs públicas sem necessidade.

## Entregáveis
1. Recibo, formulário, tabela e visualização usando `font_awesome_flutter`.
2. Varredura final documentada no resumo.
3. Testes relacionados ajustados quando necessário.
4. `pedido_page-contrato.md` atualizado com o estado final da migração.
5. Rodar validações específicas e `flutter test`.
6. Salvar resumo em `docs/codex/layout/layout-26-05-15-3-parte_3-resumo.md`.

# Descrição
- Este slice fecha a migração dos ícones na área principal do recibo e valida se a apresentação da feature ficou consistente com `font_awesome_flutter`.

## Objetivo
- Ao final deste slice, a apresentação da feature `pedido_page` deve estar migrada para Font Awesome, com testes e contrato atualizados.

## Validações obrigatórias
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test`
