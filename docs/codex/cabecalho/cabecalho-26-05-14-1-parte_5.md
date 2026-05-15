# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 5/5 derivado de `docs/codex/cabecalho/cabecalho-26-05-14-1.md`.

## Análise da tarefa
- `docs/codex/cabecalho/cabecalho-26-05-14-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_4-resumo.md`
- Antes de iniciar, leia todos os resumos anteriores e preserve o estado já produzido.

## Arquivos
- `pubspec.yaml`
- `lib/main.dart`
- `lib/features/recibo/presentation/pages/recibo_page.dart`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `lib/features/recibo/presentation/widgets/cabecalho_app.dart`
- `lib/features/recibo/presentation/viewmodels/recibo_page_view_model.dart`
- `lib/features/recibo/domain/models/cabecalho_empresa.dart`
- `test/widget_test.dart`
- `test/features/recibo/presentation/widgets/cabecalho_app_test.dart`
- `test/features/recibo/presentation/viewmodels/recibo_page_view_model_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Revisar e atualizar `recibo_page-contrato.md` com o estado final do cabeçalho.

## Regras
- Revisar a implementação completa do cabeçalho após os slices anteriores.
- Garantir que o layout não apresente overflow em larguras pequenas.
- Garantir que textos longos quebrem linha de forma controlada.
- Garantir que os botões tenham semântica, tooltips ou rótulos acessíveis quando necessário.
- Garantir que o teste antigo do contador não permaneça como contrato falso do app.
- Rodar validações finais.
- Registrar qualquer pendência real, como ausência de logomarca isolada ou fluxos de PDF/impressão ainda não implementados.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture novas funcionalidades fora do cabeçalho.
- Não implemente formulário completo de recibo, PDF real ou impressão real.
- Não execute automaticamente outro prompt.
- Não faça commit.

## Entregáveis
1. Ajustes finais de responsividade e acessibilidade do cabeçalho.
2. Testes finais coerentes com a tela atual.
3. `recibo_page-contrato.md` revisado.
4. Resumo do slice com validações executadas e resultado.
5. Salvar resumo em `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_5-resumo.md`.

# Descrição
- Fechar a implementação do cabeçalho com validações, contrato atualizado e registro de pendências.

## Objetivo
- Ao final deste slice, o cabeçalho deve estar pronto para ser usado como base da tela de recibo e validado por análise estática e testes.
