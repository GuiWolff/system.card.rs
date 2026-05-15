# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 2/4 derivado de `docs/codex/resumo/resumo-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/resumo/resumo-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/resumo/resumo-26-05-15-1-parte_1-resumo.md`
- Antes de iniciar, leia o resumo do slice 1 e preserve as decisões de cálculo já registradas.

## Arquivos
- `AGENTS.md`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `lib/features/recibo/presentation/viewmodels/recibo_page_view_model.dart`
- `lib/features/recibo/domain/models/item_recibo.dart`
- `lib/features/recibo/domain/models/resumo_pedido.dart`
- `test/features/recibo/presentation/viewmodels/recibo_page_view_model_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Atualizar `recibo_page-contrato.md` com estados e regras de interação do resumo.

## Regras
- Expor o resumo financeiro pelo `ReciboPageViewModel`, controller ou estrutura equivalente já adotada na feature.
- Sempre que produtos, quantidades, valores unitários ou entrada mudarem, o saldo de entrega deve ser recalculado.
- Se existir estado reativo no projeto, priorize esse padrão em vez de `setState` local para regra de tela.
- O ViewModel/controller não deve acessar `BuildContext`.
- A UI futura deve receber valores prontos ou observáveis, sem refazer regra de cálculo no `build`.
- A formatação monetária deve ser consistente e testável.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente ainda o widget visual do resumo.
- Não altere fluxos de impressão, PDF ou visualização do recibo.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Estado do resumo financeiro exposto pelo ViewModel/controller.
2. Métodos ou propriedades para atualizar `Valor Entrada`.
3. Recalculo do resumo quando itens/produtos mudarem.
4. Testes de ViewModel/controller para atualização reativa e formatação.
5. `recibo_page-contrato.md` atualizado com regras de estado e interação.
6. Registrar no resumo do slice quais contratos de tela foram criados, atualizados ou revisados.
7. Rodar validações específicas.
8. Salvar resumo em `docs/codex/resumo/resumo-26-05-15-1-parte_2-resumo.md`.

# Descrição
- Conectar os cálculos do resumo ao estado da tela, preparando os dados para o widget visual.

## Objetivo
- Ao final deste slice, a tela deve ter um estado testável capaz de atualizar o resumo financeiro conforme o usuário altera produtos ou valor de entrada.
