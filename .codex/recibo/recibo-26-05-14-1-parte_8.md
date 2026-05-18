# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 8/9 derivado de `docs/codex/recibo/recibo-26-05-14-1.md`.

## Análise da tarefa
- `docs/codex/recibo/recibo-26-05-14-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/recibo/recibo-26-05-14-1-parte_7-resumo.md`

## Arquivos
- `lib/features/recibo/presentation/pages/recibo_page.dart`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `lib/features/recibo/presentation/widgets/historico_recibos_painel.dart`
- `lib/features/recibo/presentation/viewmodels/recibo_page_view_model.dart`
- `lib/features/recibo/domain/repositories/recibo_repository.dart`
- `test/features/recibo/presentation/widgets/recibo_page_test.dart`
- `test/features/recibo/presentation/viewmodels/recibo_page_view_model_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Atualizar o contrato com histórico, ações e regras de carregamento de recibos.

## Protocolo do orquestrador
- Iniciar este slice em uma sessão limpa na raiz do projeto.
- Ler o resumo do slice 7 antes de qualquer alteração.
- Executar somente as atividades deste arquivo.
- Ao finalizar, criar `docs/codex/recibo/recibo-26-05-14-1-parte_8-resumo.md`.
- Parar após criar o resumo. O orquestrador deve encerrar a sessão e limpar o contexto antes do slice 9.

## Regras
- Implementar histórico como painel, diálogo ou seção da `ReciboPage`, evitando criar nova Page sem necessidade.
- O histórico deve listar recibos persistidos com:
  - número;
  - cliente;
  - data de recebimento;
  - total;
  - data de atualização.
- Permitir pesquisar por número, cliente ou telefone.
- Conectar ações:
  - salvar recibo;
  - novo recibo;
  - carregar recibo do histórico;
  - duplicar recibo;
  - excluir recibo com confirmação;
  - limpar formulário, quando aplicável.
- Preparar ações de `IMPRIMIR` e `GERAR PDF` como callbacks/estado e feedback, sem implementar exportação completa se a dependência ainda não tiver sido definida.
- Usar builder para listas de histórico.
- Preservar o recibo em edição ao abrir/fechar histórico.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente PDF real se isso exigir nova decisão de dependência.
- Não implemente integração real com impressora neste slice.
- Não crie nova Page sem atualizar/criar o contrato correspondente.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Painel ou diálogo de histórico implementado.
2. Ações principais da tela conectadas.
3. Testes cobrindo salvar, listar e carregar recibo.
4. Contrato de tela atualizado.
5. Validações executadas.
6. Resumo salvo em `docs/codex/recibo/recibo-26-05-14-1-parte_8-resumo.md`.

# Descrição
- Integrar o histórico persistido e as ações operacionais da tela.

## Objetivo
- Ao final deste slice, o usuário deve conseguir salvar recibos, consultar histórico e carregar recibos persistidos.
