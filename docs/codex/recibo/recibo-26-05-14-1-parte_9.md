# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 9/9 derivado de `docs/codex/recibo/recibo-26-05-14-1.md`.

## Análise da tarefa
- `docs/codex/recibo/recibo-26-05-14-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/recibo/recibo-26-05-14-1-parte_8-resumo.md`

## Arquivos
- `pubspec.yaml`
- `lib/main.dart`
- `lib/features/recibo/`
- `test/widget_test.dart`
- `test/features/recibo/`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Revisar e atualizar `recibo_page-contrato.md` com o estado final da feature.

## Protocolo do orquestrador
- Iniciar este slice em uma sessão limpa na raiz do projeto.
- Ler todos os resumos dos slices anteriores antes de qualquer alteração.
- Executar somente as atividades deste arquivo.
- Ao finalizar, criar `docs/codex/recibo/recibo-26-05-14-1-parte_9-resumo.md`.
- Parar após criar o resumo. Como este é o último slice, o orquestrador deve encerrar a sessão, limpar o contexto e reportar o resultado final.

## Regras
- Revisar a integração completa da feature.
- Garantir que o app ainda roda em Flutter Desktop.
- Validar que o histórico persiste após fechar e reabrir o app manualmente, quando possível.
- Garantir que a tela não possui overflow em larguras desktop comuns e quando redimensionada.
- Garantir que listas usam builder.
- Garantir que ViewModel não acessa `BuildContext`.
- Garantir que modelos de domínio não dependem de Flutter ou SQLite.
- Remover imports não usados.
- Atualizar testes que ainda reflitam o template antigo.
- Registrar pendências reais, especialmente se impressão/PDF permanecerem como callbacks preparatórios.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não adicione funcionalidades novas fora da feature de recibo.
- Não faça refatorações amplas fora do escopo.
- Não faça commit.
- Não execute outro prompt automaticamente.

## Entregáveis
1. Ajustes finais de integração.
2. Contrato de tela revisado.
3. Validações finais executadas.
4. Pendências registradas.
5. Resumo salvo em `docs/codex/recibo/recibo-26-05-14-1-parte_9-resumo.md`.

# Descrição
- Fechar a implementação da feature com validações, revisão de contrato e conferência de persistência desktop.

## Objetivo
- Ao final deste slice, a feature deve estar integrada, validada e pronta para uso desktop com histórico SQLite persistente.
