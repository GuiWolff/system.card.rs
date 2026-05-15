# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 1/5 derivado de `docs/codex/cabecalho/cabecalho-26-05-14-1.md`.

## Análise da tarefa
- `docs/codex/cabecalho/cabecalho-26-05-14-1-analise.md`

## Continuidade
- Este é o primeiro slice. Não há resumo anterior.

## Arquivos
- `AGENTS.md`
- `pubspec.yaml`
- `lib/main.dart`
- `test/widget_test.dart`
- `lib/resources/cabecalho.png`
- `lib/resources/tema.jpeg`
- `lib/features/recibo/presentation/pages/recibo_page.dart`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Revisar `recibo_page-contrato.md` após criar a tela base.

## Regras
- Criar a feature em `lib/features/recibo/`, seguindo arquitetura vertical feature-first.
- Criar uma `ReciboPage` mínima como tela inicial do app.
- Substituir o contador do template apenas no necessário para o app abrir na tela real.
- Registrar `lib/resources/` em `pubspec.yaml` se os assets ainda não estiverem registrados.
- Manter a tela mínima, com estrutura suficiente para receber o cabeçalho nos próximos slices.
- Usar português pt-BR em textos visíveis.
- Usar `const` quando possível.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente ainda o layout final do cabeçalho.
- Não implemente PDF, impressão, formulário de recibo completo ou pré-visualização neste slice.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Estrutura inicial de `lib/features/recibo/`.
2. `ReciboPage` mínima integrada ao `MaterialApp`.
3. Assets registrados em `pubspec.yaml`, quando necessário.
4. Teste inicial atualizado para a nova tela, sem dependência do contador.
5. Criar ou atualizar `[nome-da-tela]-contrato.md` quando houver alteração em Page/View/Tela.
6. Registrar no resumo do slice quais contratos de tela foram criados, atualizados ou revisados.
7. Rodar validações específicas.
8. Salvar resumo em `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_1-resumo.md`.

# Descrição
- Preparar a base real da tela de recibo para receber o cabeçalho responsivo em slices posteriores.

## Objetivo
- Ao final deste slice, o app deve abrir em `ReciboPage`, com estrutura de feature criada, teste inicial coerente e contrato revisado.
