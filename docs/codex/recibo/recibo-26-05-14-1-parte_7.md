# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 7/9 derivado de `docs/codex/recibo/recibo-26-05-14-1.md`.

## Análise da tarefa
- `docs/codex/recibo/recibo-26-05-14-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/recibo/recibo-26-05-14-1-parte_6-resumo.md`

## Arquivos
- `lib/features/recibo/presentation/pages/recibo_page.dart`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `lib/features/recibo/presentation/widgets/visualizacao_recibo.dart`
- `lib/features/recibo/presentation/viewmodels/recibo_page_view_model.dart`
- `lib/resources/visualizacao.png`
- `test/features/recibo/presentation/widgets/visualizacao_recibo_test.dart`
- `test/features/recibo/presentation/widgets/recibo_page_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Atualizar o contrato com regras da visualização do recibo.

## Protocolo do orquestrador
- Iniciar este slice em uma sessão limpa na raiz do projeto.
- Ler o resumo do slice 6 antes de qualquer alteração.
- Executar somente as atividades deste arquivo.
- Ao finalizar, criar `docs/codex/recibo/recibo-26-05-14-1-parte_7-resumo.md`.
- Parar após criar o resumo. O orquestrador deve encerrar a sessão e limpar o contexto antes do slice 8.

## Regras
- Criar `VisualizacaoRecibo` inspirado em `lib/resources/visualizacao.png`.
- A visualização deve consumir os mesmos dados do formulário e não duplicar estado.
- Renderizar:
  - cabeçalho da empresa;
  - recebido;
  - entrega;
  - cliente;
  - telefone;
  - observações;
  - tabela com quantidade, produtos e valor total;
  - total do pedido;
  - valor de entrada;
  - valor a pagar na entrega.
- A visualização deve manter proporção e legibilidade em desktop.
- Usar widgets Flutter, não a imagem como visualização final.
- Tratar listas com muitos itens de forma estável, preservando rolagem da tela principal quando necessário.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente PDF ou impressão real neste slice.
- Não implemente histórico completo neste slice.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Widget `VisualizacaoRecibo` criado.
2. Integração da visualização à `ReciboPage`.
3. Testes de widget criados.
4. Contrato de tela atualizado.
5. Validações executadas.
6. Resumo salvo em `docs/codex/recibo/recibo-26-05-14-1-parte_7-resumo.md`.

# Descrição
- Implementar a visualização do recibo que será base futura para impressão e PDF.

## Objetivo
- Ao final deste slice, o usuário deve ver uma prévia do recibo coerente com os dados preenchidos no formulário.
