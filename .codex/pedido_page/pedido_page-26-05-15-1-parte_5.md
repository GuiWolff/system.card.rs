# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 5/5 derivado de `docs/codex/pedido_page/pedido_page-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/pedido_page/pedido_page-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_4-resumo.md`
- Leia todos os resumos anteriores antes de alterar arquivos.

## Arquivos
- `lib/main.dart`
- `test/widget_test.dart`
- `lib/features/pedido_page/`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `test/features/pedido_page/`

## Contratos de tela
- Contratos relacionados:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Revisar `pedido_page-contrato.md` com o estado final.
  - Revisar `recibo_page-contrato.md` apenas se a implementação tiver alterado responsabilidade da `ReciboPage`.

## Regras
- Revisar a integração final da `PedidoPage`.
- Garantir que os testes do template antigo não permaneçam como contrato falso, se a tela inicial já mudou.
- Garantir que a Page não duplicou implementação interna de Cabeçalho, Recibo ou Resumo.
- Garantir que o layout não gera overflow em larguras representativas.
- Garantir que widgets grandes foram quebrados quando necessário.
- Rodar validações finais.
- Registrar pendências reais no resumo, incluindo componentes ainda provisórios.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não adicionar funcionalidades novas fora da `PedidoPage`.
- Não implementar PDF, impressão, SQLite ou domínio de recibo neste slice.
- Não execute outro prompt automaticamente.
- Não faça commit.

## Entregáveis
1. Ajustes finais de integração.
2. Contratos revisados conforme impacto.
3. Validações finais executadas.
4. Pendências registradas.
5. Salvar resumo em `docs/codex/pedido_page/pedido_page-26-05-15-1-parte_5-resumo.md`.

# Descrição
- Fechar a primeira etapa da `PedidoPage` como tela agregadora de Cabeçalho, Recibo e Resumo.

## Objetivo
- Ao final deste slice, a `PedidoPage` deve estar validada como composição principal e pronta para continuidade dos componentes internos.
