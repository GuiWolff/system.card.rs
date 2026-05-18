# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 2/3 derivado de `docs/codex/usabilidade/usabilidade-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/usabilidade/usabilidade-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_1-resumo.md`
- Antes de iniciar, confirme no resumo anterior quais chaves/campos foram estabilizados.

## Arquivos
- `lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Este slice deve atualizar o contrato para registrar Enter no campo `Valor unitário` e a regra de não criar novo item com valor unitário zero.

## Regras
- Adicionar item por Enter deve ocorrer no campo `Valor unitário`.
- O novo item só deve ser criado quando o valor unitário da linha atual for maior que zero.
- Em lista vazia, o botão `+ Adicionar item` pode criar a primeira linha de rascunho para digitação.
- Quando já houver itens, o botão e o Enter devem usar a mesma guarda para evitar nova linha se o último item de referência estiver com valor unitário zero.
- Ao bloquear a criação por valor zero, preservar o foco atual e registrar feedback visível pelo fluxo existente de erro/feedback da `PedidoPageViewModel`, sem abrir diálogo.
- Não alterar regras de cálculo de `ItemRecibo.totalCentavos`.
- Não mudar persistência, DTOs ou repository.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não refaça a correção de foco do slice 1, apenas adapte o novo fluxo às chaves/controladores já estabilizados.
- Não implemente bloqueio de edição do histórico neste slice.
- Não faça commit.

## Entregáveis
1. Campo `Valor unitário` com envio por Enter solicitando novo item.
2. Guarda de ViewModel/UI impedindo nova linha quando o valor unitário de referência for zero.
3. Testes cobrindo Enter com valor maior que zero.
4. Testes cobrindo bloqueio quando valor unitário for zero.
5. Atualizar `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
6. Rodar validações específicas.
7. Salvar resumo em `docs/codex/usabilidade/usabilidade-26-05-15-1-parte_2-resumo.md`.

# Descrição
- O fluxo atual adiciona item somente pelo botão e permite criar linhas vazias repetidas. Este slice adiciona o atalho de teclado e centraliza a regra de adição para impedir novas linhas quando o valor unitário ainda está zerado.

## Objetivo
- Ao final deste slice, o usuário poderá pressionar Enter em `Valor unitário` para avançar para um novo item, sem gerar linhas extras quando o valor unitário estiver zero.
