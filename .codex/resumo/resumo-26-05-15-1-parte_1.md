# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 1/4 derivado de `docs/codex/resumo/resumo-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/resumo/resumo-26-05-15-1-analise.md`

## Continuidade
- Este é o primeiro slice. Não há resumo anterior.
- Antes de alterar código, verifique se os slices de base da `ReciboPage` já foram executados. Se ainda não foram, evite duplicar estrutura já planejada em `docs/codex/cabecalho/`.

## Arquivos
- `AGENTS.md`
- `lib/resources/resumo.png`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `lib/features/recibo/domain/models/item_recibo.dart`
- `lib/features/recibo/domain/models/resumo_pedido.dart`
- `lib/features/recibo/presentation/viewmodels/recibo_page_view_model.dart`
- `test/features/recibo/presentation/viewmodels/recibo_page_view_model_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Revisar e atualizar `recibo_page-contrato.md` com os dados necessários para renderização do resumo.

## Regras
- Tratar `lib/resources/resumo.png` como referência visual e funcional do bloco de resumo.
- Centralizar cálculo monetário fora do widget visual.
- Calcular `total do pedido` a partir dos itens/produtos do recibo.
- Calcular `valor a pagar na entrega` a partir de `total do pedido - valor entrada`.
- Definir comportamento para entrada vazia, entrada zero, valor negativo e entrada maior que o total.
- Usar duas casas decimais e formato pt-BR nos valores exibidos.
- Preservar nomes e APIs já existentes, se a feature `recibo` já tiver sido criada.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente ainda o widget visual do resumo.
- Não integre ainda o resumo na `ReciboPage`.
- Não implemente PDF, impressão ou visualização final do recibo.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Modelo ou estrutura equivalente para representar os dados do resumo financeiro.
2. Cálculo testável de total, entrada e saldo de entrega.
3. Testes cobrindo cenários principais do cálculo.
4. `recibo_page-contrato.md` revisado com dados necessários para o resumo.
5. Registrar no resumo do slice quais contratos de tela foram criados, atualizados ou revisados.
6. Rodar validações específicas.
7. Salvar resumo em `docs/codex/resumo/resumo-26-05-15-1-parte_1-resumo.md`.

# Descrição
- Preparar a base de dados e cálculo do bloco de resumo financeiro antes de criar UI.

## Objetivo
- Ao final deste slice, o projeto deve ter uma fonte testável para `Total do Pedido`, `Valor Entrada` e `Valor a pagar na Entrega`, pronta para ser exposta pelo estado da tela.
