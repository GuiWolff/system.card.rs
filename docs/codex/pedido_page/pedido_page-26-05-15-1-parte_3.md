# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 3/5 derivado de `docs/codex/pedido_page/pedido_page-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/pedido_page/pedido_page-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_2-resumo.md`
- Leia os resumos dos slices anteriores antes de alterar arquivos.

## Arquivos
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `lib/features/pedido_page/presentation/widgets/pedido_page_layout.dart`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`

## Contratos de tela
- Contratos relacionados:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Atualizar `pedido_page-contrato.md` com a integração real ou temporária dos blocos.
  - Atualizar `recibo_page-contrato.md` somente se a implementação mover responsabilidades da `ReciboPage`.

## Regras
- Integrar os componentes reais de Cabeçalho, Recibo e Resumo se eles já existirem.
- Se algum componente ainda não existir, criar apenas um encaixe mínimo local, claramente provisório, para manter a Page compilando.
- Não reimplementar internamente:
  - layout visual completo do cabeçalho;
  - formulário de recibo;
  - cálculo do resumo.
- Preservar a ordem visual:
  1. Cabeçalho;
  2. Recibo;
  3. Resumo abaixo do recibo.
- Registrar no resumo quais componentes reais foram usados e quais ficaram pendentes.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente persistência, PDF ou impressão.
- Não crie uma nova Page para cada bloco.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Blocos Cabeçalho, Recibo e Resumo integrados à `PedidoPage` quando disponíveis.
2. Encaixes provisórios documentados quando componentes ainda não existirem.
3. Testes de composição atualizados.
4. Contratos revisados conforme impacto.
5. Validações específicas executadas.
6. Salvar resumo em `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_3-resumo.md`.

# Descrição
- Conectar a `PedidoPage` aos blocos planejados, mantendo separação de responsabilidades.

## Objetivo
- Ao final deste slice, a `PedidoPage` deve apresentar a composição dos três blocos ou indicar claramente as dependências ainda pendentes.
