# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 1/9 derivado de `docs/codex/recibo/recibo-26-05-14-1.md`.

## Análise da tarefa
- `docs/codex/recibo/recibo-26-05-14-1-analise.md`

## Continuidade
- Este é o primeiro slice. Não há resumo anterior.

## Arquivos
- `AGENTS.md`
- `pubspec.yaml`
- `lib/main.dart`
- `test/widget_test.dart`
- `lib/features/recibo/recibo.dart`
- `lib/features/recibo/presentation/pages/recibo_page.dart`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `lib/resources/recibo.png`
- `lib/resources/visualizacao.png`
- `lib/resources/cabecalho.png`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Atualizar `recibo_page-contrato.md` com a base real da `ReciboPage`.

## Protocolo do orquestrador
- Iniciar este slice em uma sessão limpa na raiz do projeto.
- Executar somente as atividades deste arquivo.
- Ao finalizar, criar `docs/codex/recibo/recibo-26-05-14-1-parte_1-resumo.md`.
- Parar após criar o resumo. O orquestrador deve encerrar a sessão e limpar o contexto antes do slice 2.

## Regras
- Criar a estrutura mínima da feature `recibo`.
- Criar `ReciboPage` como tela inicial simples, ainda sem implementar formulário completo, SQLite ou histórico.
- Atualizar `lib/main.dart` somente no necessário para iniciar pela `ReciboPage`.
- Registrar assets em `pubspec.yaml` se ainda não estiverem registrados.
- Substituir o teste do contador por teste que confirme abertura da tela real.
- Manter a tela base simples e preparada para os próximos slices.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente SQLite neste slice.
- Não implemente domínio, cálculos, histórico ou visualização final neste slice.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Estrutura base de `lib/features/recibo/`.
2. `ReciboPage` mínima integrada ao app.
3. Assets registrados, se necessário.
4. Teste inicial atualizado.
5. `recibo_page-contrato.md` atualizado.
6. Validações executadas.
7. Resumo salvo em `docs/codex/recibo/recibo-26-05-14-1-parte_1-resumo.md`.

# Descrição
- Preparar a base da feature para que os próximos slices possam adicionar domínio, persistência, estado e UI sem depender do template do Flutter.

## Objetivo
- Ao final deste slice, o app deve abrir na `ReciboPage` base e os testes não devem mais depender do contador do template.
