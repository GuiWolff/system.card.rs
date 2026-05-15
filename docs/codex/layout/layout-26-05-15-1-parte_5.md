# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 5/5 derivado de `docs/codex/layout/layout-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/layout/layout-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/layout/layout-26-05-15-1-parte_4-resumo.md`
- Leia todos os resumos anteriores para consolidar a linguagem visual sem refazer etapas já concluídas.

## Arquivos
- `lib/features/pedido_page/presentation/widgets/resumo_pedido.dart`
- `lib/features/pedido_page/presentation/widgets/visualizacao_recibo.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_compartilhamento_dialog.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pdf_preview_dialog.dart`
- `lib/features/pedido_page/services/recibo_pdf_service.dart`, somente se a saída PDF precisar acompanhar a nova aparência.
- `test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`
- `test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `test/features/pedido_page/services/recibo_pdf_service_test.dart`, se `ReciboPdfService` for alterado.
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`

## Contratos de tela
- Ler antes de alterar:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Atualizar ou revisar neste slice:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Não criar novo contrato de tela.

## Regras
- Usar `lib/resources/resumo.png` como referência para o resumo financeiro.
- Usar `lib/resources/visualizacao.png` como referência para a visualização do documento.
- O valor a pagar na entrega deve continuar com destaque visual claro.
- A visualização do recibo deve preservar leitura de documento, linhas, tabela, observações e totais.
- Dialogs de compartilhamento e prévia de PDF devem ficar coerentes com o tema, sem perder acessibilidade e ações atuais.
- Só alterar `ReciboPdfService` se a diferença visual entre prévia na tela e PDF gerado ficar inconsistente para o usuário.
- Consolidar o contrato de tela com o estado final da tarefa.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não execute automaticamente o próximo slice.
- Não faça commit.
- Não alterar cálculo financeiro no widget.
- Não alterar fluxo de geração, impressão ou compartilhamento de PDF.
- Não criar nova tela ou feature.

## Entregáveis
1. `ResumoPedido` modernizado e responsivo.
2. `VisualizacaoRecibo` modernizada e coerente com a referência de documento.
3. Dialogs relacionados harmonizados.
4. `ReciboPdfService` ajustado apenas se necessário e com testes preservados.
5. `pedido_page-contrato.md` consolidado com a aparência final.
6. Testes específicos e validação geral executados.
7. Salvar resumo em `docs/codex/layout/layout-26-05-15-1-parte_5-resumo.md`.
8. Atualizar `docs/codex/layout/layout-26-05-15-1-resumo.md` se houver mudança relevante no plano durante a execução.

# Descrição
- Este slice fecha a experiência visual: resumo financeiro, documento renderizado, dialogs e validação final.
- Também é o ponto correto para verificar se a saída PDF precisa acompanhar a modernização visual da tela.

## Objetivo
- Ao final deste slice, a interface deve estar visualmente consistente de ponta a ponta, com contrato atualizado e validações executadas.

## Validações
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test test/features/pedido_page/services/recibo_pdf_service_test.dart`, se o serviço for alterado.
- `flutter test`
