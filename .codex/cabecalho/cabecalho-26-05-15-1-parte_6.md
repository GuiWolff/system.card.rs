# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise da tarefa e o resumo do slice anterior, se houver.
Este é o slice 6/6 derivado de `docs/codex/cabecalho/cabecalho-26-05-15-1.md`.

## Análise da tarefa
- `docs/codex/cabecalho/cabecalho-26-05-15-1-analise.md`

## Continuidade
- Slice anterior: `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_5-resumo.md`
- Antes de iniciar, leia todos os resumos anteriores e preserve o estado produzido.

## Arquivos
- `pubspec.yaml`
- `lib/main.dart`
- `lib/features/pedido_page/pedido_page.dart`
- `lib/features/pedido_page/domain/models/cabecalho_empresa.dart`
- `lib/features/pedido_page/domain/models/cliente.dart`
- `lib/features/pedido_page/data/datasources/recibo_database.dart`
- `lib/features/pedido_page/data/repositories/cabecalho_preferencias_repository.dart`
- `lib/features/pedido_page/data/repositories/cliente_repository_sqlite.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/widgets/cabecalho_app.dart`
- `lib/features/pedido_page/presentation/widgets/cabecalho_editor_dialog.dart`
- `lib/features/pedido_page/presentation/widgets/clientes_painel.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `test/widget_test.dart`
- `test/features/pedido_page/...`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos que este slice deve criar, atualizar ou revisar:
  - Revisar e atualizar `pedido_page-contrato.md` com o estado final do cabeçalho editável e cadastro de clientes.

## Regras
- Revisar a integração completa sem criar nova Page.
- Garantir que cabeçalho editável, logo base64 e fallback funcionam no mesmo fluxo.
- Garantir que o cadastro de clientes persiste no SQLite e bloqueia telefone duplicado.
- Garantir que busca por nome/telefone funciona com telefone mascarado ou normalizado.
- Garantir que seleção de cliente preenche o recibo em edição.
- Remover expectativas de testes antigos que não representem mais o app.
- Registrar pendências reais no resumo.

## Restrições
- Não reescreva arquivos inteiros sem necessidade.
- Não misture novas funcionalidades fora do cabeçalho editável e clientes.
- Não implemente impressão real, PDF real ou exportação/importação de clientes.
- Não execute automaticamente outro prompt.
- Não faça commit.

## Entregáveis
1. Ajustes finais de integração, responsividade e acessibilidade.
2. Testes finais coerentes com a tela atual.
3. `pedido_page-contrato.md` revisado.
4. Resumo do slice com validações executadas e resultado.
5. Salvar resumo em `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_6-resumo.md`.

# Descrição
- Fechar a implementação do cabeçalho editável e cadastro de clientes com validações e contrato atualizado.

## Objetivo
- Ao final deste slice, cabeçalho editável, logo base64 e cadastro de clientes devem estar integrados à `PedidoPage`, persistidos localmente e cobertos por testes.
