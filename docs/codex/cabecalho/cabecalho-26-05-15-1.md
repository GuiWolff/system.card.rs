# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise desta tarefa antes de executar qualquer alteração.
Esta tarefa foi dividida em 6 slices.

## Análise da tarefa
- `docs/codex/cabecalho/cabecalho-26-05-15-1-analise.md`

## Objetivo geral
- Tornar o cabeçalho da `PedidoPage` editável e persistente em `SharedPreferences`, incluindo logo selecionado como base64.
- Criar cadastro de clientes com `id`, `nome` e `telefone`, com máscara `(xx) x xxxx-xxxx`, bloqueio de telefone duplicado, busca por cliente e persistência no SQLite embarcado.
- Preservar a `PedidoPage` como tela real da aplicação e evitar criar `ReciboPage` ou estrutura paralela.

## Arquivos principais envolvidos
- `pubspec.yaml`
- `lib/features/pedido_page/pedido_page.dart`
- `lib/features/pedido_page/domain/models/cabecalho_empresa.dart`
- `lib/features/pedido_page/domain/models/recibo.dart`
- `lib/features/pedido_page/domain/models/cliente.dart`
- `lib/features/pedido_page/domain/repositories/cliente_repository.dart`
- `lib/features/pedido_page/data/datasources/recibo_database.dart`
- `lib/features/pedido_page/data/dtos/cliente_dto.dart`
- `lib/features/pedido_page/data/repositories/cabecalho_preferencias_repository.dart`
- `lib/features/pedido_page/data/repositories/cliente_repository_sqlite.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/widgets/cabecalho_app.dart`
- `lib/features/pedido_page/presentation/widgets/cabecalho_editor_dialog.dart`
- `lib/features/pedido_page/presentation/widgets/clientes_painel.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `test/features/pedido_page/...`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md` apenas como referência legada.
- Contratos que cada slice deve criar, atualizar ou revisar:
  - Slice 1: revisar `pedido_page-contrato.md` com os dados persistentes do cabeçalho.
  - Slice 2: atualizar `pedido_page-contrato.md` com o estado exposto pela ViewModel.
  - Slice 3: atualizar `pedido_page-contrato.md` com o editor visual do cabeçalho e seleção de logo.
  - Slice 4: revisar `pedido_page-contrato.md` justificando ausência de UI direta no schema/repository de clientes.
  - Slice 5: atualizar `pedido_page-contrato.md` com cadastro, busca e seleção de clientes.
  - Slice 6: revisar `pedido_page-contrato.md` com o estado final da integração.

## Slices da tarefa

### Slice 1/6 - Persistência do cabeçalho
Arquivo: `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_1.md`
Resumo esperado: `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_1-resumo.md`

Atividades:
1. Ajustar o modelo de cabeçalho para representar dados editáveis e logo base64 sem quebrar o fallback atual.
2. Criar repository/service de `SharedPreferences` para carregar, salvar e restaurar o cabeçalho padrão.
3. Adicionar testes de serialização, fallback padrão, persistência e remoção de logo.
4. Revisar o contrato da `PedidoPage`.

Validações:
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`

### Slice 2/6 - Estado do cabeçalho na ViewModel
Arquivo: `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_2.md`
Resumo esperado: `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_2-resumo.md`

Atividades:
1. Conectar a persistência do cabeçalho à `PedidoPageViewModel` ou estrutura equivalente.
2. Expor comandos para carregar, editar, salvar, restaurar padrão, definir logo base64 e remover logo.
3. Garantir estado reativo para que `CabecalhoApp` reflita alterações sem `setState` local.
4. Adicionar testes de ViewModel para carregamento, edição, salvamento e fallback.
5. Atualizar o contrato da `PedidoPage`.

Validações:
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`

### Slice 3/6 - Editor visual do cabeçalho e logo
Arquivo: `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_3.md`
Resumo esperado: `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_3-resumo.md`

Atividades:
1. Criar fluxo visual para editar os dados do cabeçalho dentro da `PedidoPage`, preferencialmente por dialog/painel acionado no cabeçalho.
2. Permitir seleção e remoção do logo, convertendo a imagem para base64 antes de salvar.
3. Renderizar logo base64 em `CabecalhoApp`; se não houver imagem, manter o fallback visual `SC`.
4. Adicionar testes de widget para edição, fallback, logo em memória e responsividade.
5. Atualizar o contrato da `PedidoPage`.

Validações:
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`

### Slice 4/6 - Domínio e SQLite de clientes
Arquivo: `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_4.md`
Resumo esperado: `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_4-resumo.md`

Atividades:
1. Criar modelo `Cliente` com `id`, `nome`, `telefone` e telefone normalizado para comparação.
2. Criar contrato `ClienteRepository`.
3. Evoluir `ReciboDatabase` para nova versão com tabela `clientes` e índice único de telefone normalizado.
4. Criar DTO/repository SQLite de clientes com salvar, atualizar, buscar por id, pesquisar e excluir quando aplicável.
5. Adicionar testes de schema, migração, unicidade e busca.
6. Revisar o contrato da `PedidoPage` registrando que este slice não tem alteração visual direta.

Validações:
- `flutter analyze`
- `flutter test test/features/pedido_page/data/datasources/recibo_database_test.dart`
- `flutter test test/features/pedido_page/data/repositories/cliente_repository_sqlite_test.dart`

### Slice 5/6 - Cadastro, máscara e seleção de clientes
Arquivo: `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_5.md`
Resumo esperado: `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_5-resumo.md`

Atividades:
1. Expor estado e comandos de clientes na `PedidoPageViewModel` sem acessar `BuildContext`.
2. Criar máscara de telefone `(xx) x xxxx-xxxx` e manter persistência/busca por telefone normalizado.
3. Criar UI de cadastro, listagem, busca e seleção de clientes dentro da `PedidoPage`.
4. Ao selecionar um cliente, preencher nome e telefone no recibo em edição.
5. Tratar erro de telefone duplicado com mensagem clara.
6. Atualizar o contrato da `PedidoPage`.

Validações:
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`

### Slice 6/6 - Integração final e fechamento
Arquivo: `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_6.md`
Resumo esperado: `docs/codex/cabecalho/cabecalho-26-05-15-1-parte_6-resumo.md`

Atividades:
1. Revisar a integração final do cabeçalho editável e do cadastro de clientes na `PedidoPage`.
2. Garantir que o logo persistido em base64 sobrevive à recriação da ViewModel/app e que o fallback `SC` permanece quando não houver imagem.
3. Garantir que cliente duplicado por telefone é bloqueado e que a busca encontra por nome ou telefone.
4. Revisar responsividade, acessibilidade, imports e testes antigos.
5. Revisar e atualizar `pedido_page-contrato.md`.
6. Registrar pendências reais no resumo do slice.

Validações:
- `flutter analyze`
- `flutter test`

## Regras gerais
- Executar apenas um slice por vez.
- Nunca executar slices em paralelo.
- Nunca avançar para o próximo slice sem o resumo do slice atual.
- Se um resumo de slice já existir e estiver válido, não repetir esse slice.
- Cada slice deve considerar o estado atualizado do código produzido pelo slice anterior.
- Cada slice que alterar UI deve criar ou atualizar o respectivo `[nome-da-tela]-contrato.md`.
- Preservar alterações existentes no worktree.
- Não fazer commit automaticamente.
- Manter a implementação real dentro de `lib/features/pedido_page/`.
- Não criar `ReciboPage`, rota própria ou feature paralela para este escopo.
- ViewModel/controller não deve acessar `BuildContext`.
- Usar `Rx`/`Obx` para estado compartilhado quando houver atualização observável.

## Resultado esperado
- A `PedidoPage` deve permitir editar e persistir os dados do cabeçalho.
- O logo deve poder ser selecionado, salvo como base64 em `SharedPreferences`, removido e exibido no cabeçalho; sem logo salvo, o fallback atual deve permanecer.
- A tela deve permitir cadastrar, pesquisar e selecionar clientes persistidos em SQLite.
- Telefones de clientes devem usar máscara visual `(xx) x xxxx-xxxx`, persistência normalizada e bloqueio de duplicidade.
- Selecionar cliente deve preencher nome e telefone do recibo em edição.
- A implementação deve ter testes, contrato atualizado e validações registradas nos resumos dos slices.
