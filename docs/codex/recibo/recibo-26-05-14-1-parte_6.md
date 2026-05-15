# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 6/9 derivado de `docs/codex/recibo/recibo-26-05-14-1.md`.

## Análise da tarefa
- `docs/codex/recibo/recibo-26-05-14-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/recibo/recibo-26-05-14-1-parte_5-resumo.md`

## Arquivos
- `lib/features/recibo/presentation/pages/recibo_page.dart`
- `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- `lib/features/recibo/presentation/widgets/recibo_formulario.dart`
- `lib/features/recibo/presentation/widgets/produtos_servicos_tabela.dart`
- `lib/features/recibo/presentation/widgets/resumo_recibo_card.dart`
- `lib/features/recibo/presentation/viewmodels/recibo_page_view_model.dart`
- `test/features/recibo/presentation/widgets/recibo_page_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Atualizar o contrato com formulário, tabela, resumo e responsividade.

## Protocolo do orquestrador
- Iniciar este slice em uma sessão limpa na raiz do projeto.
- Ler o resumo do slice 5 antes de qualquer alteração.
- Executar somente as atividades deste arquivo.
- Ao finalizar, criar `docs/codex/recibo/recibo-26-05-14-1-parte_6-resumo.md`.
- Parar após criar o resumo. O orquestrador deve encerrar a sessão e limpar o contexto antes do slice 7.

## Regras
- Implementar o formulário editável inspirado em `lib/resources/recibo.png`.
- Campos mínimos:
  - número do recibo;
  - recebido;
  - entrega;
  - cliente;
  - telefone;
  - valor de entrada;
  - observações, se já estiver no estado.
- Implementar tabela de produtos/serviços com builder quando a lista puder crescer.
- A tabela deve permitir adicionar, editar e remover itens.
- Implementar resumo com:
  - total do pedido;
  - valor de entrada;
  - valor a pagar na entrega.
- A UI deve observar o estado da ViewModel sem lógica pesada no build.
- Usar layout responsivo para desktop redimensionado.
- Evitar overflow horizontal nos campos e botões.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente visualização do recibo neste slice.
- Não implemente histórico completo neste slice.
- Não implemente PDF ou impressão.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Formulário de dados do recibo implementado.
2. Tabela de produtos/serviços implementada.
3. Resumo financeiro implementado.
4. Testes de widget criados ou atualizados.
5. Contrato de tela atualizado.
6. Validações executadas.
7. Resumo salvo em `docs/codex/recibo/recibo-26-05-14-1-parte_6-resumo.md`.

# Descrição
- Implementar a parte editável da tela de recibo, mantendo integração com a ViewModel e cálculos do domínio.

## Objetivo
- Ao final deste slice, o usuário deve conseguir preencher dados do recibo, manipular produtos/serviços e ver o resumo calculado.
