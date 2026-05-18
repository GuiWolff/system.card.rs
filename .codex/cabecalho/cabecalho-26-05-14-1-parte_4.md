# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 4/5 derivado de `docs/codex/cabecalho/cabecalho-26-05-14-1.md`.

## Análise da tarefa
- `docs/codex/cabecalho/cabecalho-26-05-14-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_3-resumo.md`
- Antes de iniciar, leia os resumos dos slices anteriores e preserve o estado já produzido.

## Arquivos
- `lib/features/recibo/presentation/pages/recibo_page.dart`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `lib/features/recibo/presentation/widgets/cabecalho_app.dart`
- `lib/features/recibo/presentation/viewmodels/recibo_page_view_model.dart`
- `test/features/recibo/presentation/widgets/cabecalho_app_test.dart`
- `test/features/recibo/presentation/viewmodels/recibo_page_view_model_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Atualizar `recibo_page-contrato.md` com regras de interação dos botões e menu.

## Regras
- Conectar os botões do cabeçalho por callbacks explícitos.
- Botões mínimos:
  - `IMPRIMIR`;
  - `GERAR PDF`;
  - `MAIS OPÇÕES`.
- Para fluxos ainda não implementados, usar feedback controlado e testável, sem criar lógica falsa de impressão ou PDF.
- O widget do cabeçalho deve continuar sendo apresentacional. A decisão do que acontece ao clicar deve ficar na página ou ViewModel.
- Prever estado desabilitado quando uma ação não estiver disponível.
- Prever estado de carregamento quando uma ação assíncrona futura estiver em andamento, se isso couber no estado atual.
- O menu "MAIS OPÇÕES" deve ser acessível por teclado e toque.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente geração real de PDF.
- Não implemente integração real com impressora.
- Não altere o layout responsivo fora do necessário para comportar estados das ações.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Ações do cabeçalho conectadas por callbacks ou ViewModel.
2. Estados básicos de ação cobertos.
3. Testes para cliques nos botões e abertura do menu.
4. Atualização de `recibo_page-contrato.md`.
5. Registrar no resumo do slice quais contratos de tela foram criados, atualizados ou revisados.
6. Rodar validações específicas.
7. Salvar resumo em `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_4-resumo.md`.

# Descrição
- Tornar as ações do cabeçalho interativas e preparadas para integração futura com impressão e geração de PDF.

## Objetivo
- Ao final deste slice, os botões do cabeçalho devem responder de forma testável, sem expandir o escopo para os fluxos completos de PDF e impressão.
