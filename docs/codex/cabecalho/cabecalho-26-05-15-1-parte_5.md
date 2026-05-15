# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 5/6 derivado de `docs/codex/cabecalho/cabecalho-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/cabecalho/cabecalho-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_4-resumo.md`
- Antes de iniciar, leia os resumos anteriores e use o repository SQLite de clientes já criado.

## Arquivos
- `lib/features/pedido_page/domain/models/cliente.dart`
- `lib/features/pedido_page/domain/repositories/cliente_repository.dart`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/widgets/clientes_painel.dart`
- `lib/features/pedido_page/presentation/input_formatters/telefone_input_formatter.dart`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Atualizar `pedido_page-contrato.md` com cadastro, busca e seleção de clientes.

## Regras
- Expor lista, carregamento, erro, busca e comandos de clientes pela `PedidoPageViewModel`.
- ViewModel não deve acessar `BuildContext`.
- Criar máscara de telefone `(xx) x xxxx-xxxx` na apresentação.
- Persistir e buscar por telefone normalizado, não pelo texto mascarado.
- Criar UI de cadastro/listagem/pesquisa/seleção de clientes usando lista com builder.
- Ao selecionar cliente, preencher `cliente` e `telefone` no recibo em edição.
- Telefone duplicado deve gerar feedback claro.
- Não duplicar estado de cliente entre widget e ViewModel além do estritamente local dos campos.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não alterar regras de cálculo do recibo.
- Não implementar importação/exportação de clientes.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Estado e comandos de clientes na ViewModel.
2. Máscara de telefone `(xx) x xxxx-xxxx`.
3. Painel/dialog de cadastro, busca, listagem e seleção de clientes.
4. Integração da seleção de cliente ao recibo em edição.
5. Testes de ViewModel e widget.
6. Atualizar `pedido_page-contrato.md`.
7. Registrar no resumo do slice quais contratos de tela foram criados, atualizados ou revisados.
8. Rodar validações específicas.
9. Salvar resumo em `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_5-resumo.md`.

# Descrição
- Integrar o cadastro de clientes ao estado e à UI da `PedidoPage`.

## Objetivo
- Ao final deste slice, o usuário deve conseguir cadastrar, pesquisar e selecionar clientes, com telefone mascarado e bloqueio de duplicidade.
