# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 2/9 derivado de `docs/codex/recibo/recibo-26-05-14-1.md`.

## Análise da tarefa
- `docs/codex/recibo/recibo-26-05-14-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/recibo/recibo-26-05-14-1-parte_1-resumo.md`

## Arquivos
- `lib/features/recibo/domain/models/recibo.dart`
- `lib/features/recibo/domain/models/item_recibo.dart`
- `lib/features/recibo/domain/models/resumo_recibo.dart`
- `lib/features/recibo/recibo.dart`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `test/features/recibo/domain/models/recibo_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Revisar o contrato para registrar os dados e regras de cálculo que a tela deve preservar.
- Este slice tem impacto indireto em UI porque define os dados que a `ReciboPage` renderizará.

## Protocolo do orquestrador
- Iniciar este slice em uma sessão limpa na raiz do projeto.
- Ler o resumo do slice 1 antes de qualquer alteração.
- Executar somente as atividades deste arquivo.
- Ao finalizar, criar `docs/codex/recibo/recibo-26-05-14-1-parte_2-resumo.md`.
- Parar após criar o resumo. O orquestrador deve encerrar a sessão e limpar o contexto antes do slice 3.

## Regras
- Criar modelos de domínio sem dependência de Flutter, SQLite ou widgets.
- Representar valores monetários em centavos inteiros.
- Criar cálculo de:
  - total do item;
  - total do pedido;
  - valor a pagar na entrega.
- Validar regras mínimas:
  - número do recibo obrigatório;
  - cliente obrigatório;
  - quantidade maior que zero;
  - descrição de produto/serviço obrigatória;
  - valor unitário maior ou igual a zero;
  - valor de entrada maior ou igual a zero;
  - valor de entrada não deve ultrapassar total do pedido, salvo decisão explícita registrada.
- Exportar os modelos pelo barrel da feature.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente SQLite neste slice.
- Não implemente ViewModel ou UI editável neste slice.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Modelos de domínio criados.
2. Regras de cálculo implementadas.
3. Testes de domínio criados.
4. Contrato de tela revisado.
5. Validações executadas.
6. Resumo salvo em `docs/codex/recibo/recibo-26-05-14-1-parte_2-resumo.md`.

# Descrição
- Criar a base de dados e cálculos da feature antes de qualquer persistência ou UI complexa.

## Objetivo
- Ao final deste slice, a feature deve ter domínio testado para recibo, itens e resumo financeiro.
