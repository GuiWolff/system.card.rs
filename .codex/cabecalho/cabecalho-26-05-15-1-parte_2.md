# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 2/6 derivado de `docs/codex/cabecalho/cabecalho-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/cabecalho/cabecalho-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_1-resumo.md`
- Antes de iniciar, leia o resumo do slice 1 e preserve as decisões de persistência do cabeçalho.

## Arquivos
- `lib/features/pedido_page/domain/models/cabecalho_empresa.dart`
- `lib/features/pedido_page/data/repositories/cabecalho_preferencias_repository.dart`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Atualizar `pedido_page-contrato.md` com estados e comandos do cabeçalho editável.

## Regras
- Conectar o repository/service de cabeçalho à `PedidoPageViewModel`.
- Expor estado reativo para o cabeçalho editável.
- Preservar a API atual de `cabecalhoEmpresa` sempre que possível.
- Criar comandos para carregar, editar, salvar, restaurar padrão, definir logo base64 e remover logo.
- Não acessar `BuildContext` na ViewModel.
- Falhas de persistência devem ser expostas como estado/erro, sem quebrar a UI.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture etapas de outros slices.
- Não implemente ainda o editor visual.
- Não implemente cadastro de clientes.
- Não execute automaticamente o próximo slice.
- Não faça commit.

## Entregáveis
1. Estado do cabeçalho editável exposto pela `PedidoPageViewModel`.
2. Comandos testáveis para alterar e persistir dados do cabeçalho.
3. Testes de ViewModel cobrindo carregar, salvar, restaurar padrão e logo base64.
4. Atualizar `pedido_page-contrato.md`.
5. Registrar no resumo do slice quais contratos de tela foram criados, atualizados ou revisados.
6. Rodar validações específicas.
7. Salvar resumo em `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_2-resumo.md`.

# Descrição
- Conectar os dados persistentes do cabeçalho ao estado da tela.

## Objetivo
- Ao final deste slice, a `PedidoPageViewModel` deve ser a fonte de verdade reativa do cabeçalho editável, pronta para ser usada pela UI.
