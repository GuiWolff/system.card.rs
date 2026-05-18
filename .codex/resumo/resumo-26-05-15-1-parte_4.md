# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 4/4 derivado de `docs/codex/resumo/resumo-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/resumo/resumo-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/resumo/resumo-26-05-15-1-parte_3-resumo.md`
- Antes de iniciar, leia todos os resumos anteriores e preserve o estado já produzido.

## Arquivos
- `AGENTS.md`
- `pubspec.yaml`
- `lib/main.dart`
- `test/widget_test.dart`
- `lib/resources/tema.jpeg`
- `lib/resources/recibo.png`
- `lib/resources/resumo.png`
- `lib/features/recibo/presentation/pages/recibo_page.dart`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `lib/features/recibo/presentation/widgets/resumo_pedido.dart`
- `lib/features/recibo/presentation/viewmodels/recibo_page_view_model.dart`
- `lib/features/recibo/domain/models/resumo_pedido.dart`
- `test/features/recibo/presentation/widgets/resumo_pedido_test.dart`
- `test/features/recibo/presentation/viewmodels/recibo_page_view_model_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Revisar e atualizar `recibo_page-contrato.md` com o estado final do resumo financeiro.

## Regras
- Revisar a integração completa do resumo após os slices anteriores.
- Garantir que o resumo fica abaixo do widget de recibo/produtos na coluna da tela.
- Garantir que alterações em itens/produtos e entrada atualizam `Total do Pedido` e `Valor a pagar na Entrega`.
- Garantir que `Valor Entrada` esteja acessível por teclado, mouse e toque quando for editável.
- Garantir que textos e valores não gerem overflow em larguras pequenas.
- Garantir que os testes do template antigo não permaneçam como contrato falso do app.
- Registrar pendências reais, como dependência de widgets de recibo ainda não implementados ou regras de validação que precisem de confirmação de negócio.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture novas funcionalidades fora do resumo financeiro.
- Não implemente PDF real, impressão real ou visualização completa do recibo.
- Não execute automaticamente outro prompt.
- Não faça commit.

## Entregáveis
1. Ajustes finais de integração, responsividade e acessibilidade do resumo.
2. Testes finais coerentes com a tela atual.
3. `recibo_page-contrato.md` revisado.
4. Resumo do slice com validações executadas e resultado.
5. Salvar resumo em `docs/codex/resumo/resumo-26-05-15-1-parte_4-resumo.md`.

# Descrição
- Fechar a implementação do bloco de resumo financeiro com validações, contrato atualizado e registro de pendências.

## Objetivo
- Ao final deste slice, o resumo financeiro deve estar integrado à `ReciboPage`, abaixo do recibo, com cálculo confiável, UI responsiva e validações registradas.
