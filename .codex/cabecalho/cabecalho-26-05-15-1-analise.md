# Análise da tarefa

## Pedido original
- Tornar os dados do cabeçalho editáveis e persistidos com `SharedPreferences`.
- Permitir selecionar uma imagem para o logo, persistindo a imagem como `String` base64 em `SharedPreferences`.
- Quando não houver imagem selecionada, manter o componente visual atual do logo.
- Criar cadastro de cliente com `id`, `nome` e `telefone`.
- Aplicar máscara de telefone no formato `(xx) x xxxx-xxxx`.
- Impedir telefone duplicado e permitir encontrar cliente pelo cadastro.
- Persistir clientes no banco embarcado SQLite.

## Feature correspondente
- Feature real: `pedido_page`.
- Caminho provável: `lib/features/pedido_page/`.
- Justificativa: o cabeçalho, o recibo, o formulário de cliente e a persistência SQLite já estão concentrados na composição da `PedidoPage`. Criar uma feature paralela `cabecalho` ou `recibo` duplicaria o fluxo atual.

## Arquivos relacionados
- Produção:
  - `pubspec.yaml`
  - `lib/main.dart`
  - `lib/features/pedido_page/pedido_page.dart`
  - `lib/features/pedido_page/domain/models/cabecalho_empresa.dart`
  - `lib/features/pedido_page/domain/models/recibo.dart`
  - `lib/features/pedido_page/domain/repositories/recibo_repository.dart`
  - `lib/features/pedido_page/data/datasources/recibo_database.dart`
  - `lib/features/pedido_page/data/repositories/recibo_repository_sqlite.dart`
  - `lib/features/pedido_page/presentation/pages/pedido_page.dart`
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
  - `lib/features/pedido_page/presentation/widgets/cabecalho_app.dart`
  - `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
  - `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
  - `lib/observable/rx.dart`
  - `lib/observable/obx.dart`
- Arquivos prováveis a criar:
  - `lib/features/pedido_page/domain/models/cliente.dart`
  - `lib/features/pedido_page/domain/repositories/cliente_repository.dart`
  - `lib/features/pedido_page/data/dtos/cliente_dto.dart`
  - `lib/features/pedido_page/data/repositories/cliente_repository_sqlite.dart`
  - `lib/features/pedido_page/data/repositories/cabecalho_preferencias_repository.dart`
  - `lib/features/pedido_page/presentation/widgets/cabecalho_editor_dialog.dart`
  - `lib/features/pedido_page/presentation/widgets/clientes_painel.dart`
  - `lib/features/pedido_page/presentation/input_formatters/telefone_input_formatter.dart`
- Testes:
  - `test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`
  - `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
  - `test/features/pedido_page/data/datasources/recibo_database_test.dart`
  - `test/features/pedido_page/data/repositories/recibo_repository_sqlite_test.dart`
  - `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
  - Novos testes prováveis para clientes, cabeçalho editável e máscara.

## Estado atual
- `CabecalhoEmpresa` é um modelo puro com dados estáticos padrão da System Card - RS.
- `PedidoPageViewModel` recebe `CabecalhoEmpresa` no construtor e expõe o cabeçalho com estados de ação, mas não permite editar nem persistir os dados.
- `CabecalhoApp` renderiza identidade, contatos e ações. Quando não há logo real, exibe o fallback textual `SC`.
- Não há persistência de dados do cabeçalho em `SharedPreferences`.
- `shared_preferences` já existe no `pubspec.yaml`, usado pela infraestrutura de tema.
- O SQLite atual está no `ReciboDatabase`, versão `1`, com tabelas `recibos` e `recibo_itens`.
- Não há tabela, model, repository ou UI de cliente.
- O formulário de recibo contém campos livres de cliente e telefone, sem máscara e sem vínculo com cadastro.

## Estado esperado
- O cabeçalho deve carregar dados persistidos em `SharedPreferences`, caindo para `CabecalhoEmpresa.systemCardRs()` quando não houver configuração salva.
- O usuário deve poder editar nome da empresa, subtítulo, Instagram, WhatsApp, telefone e endereço.
- O usuário deve poder selecionar/remover uma imagem de logo; a imagem deve ser armazenada como base64 em `SharedPreferences`.
- Quando não houver logo base64 salvo, `CabecalhoApp` deve manter o fallback visual atual.
- A seleção de imagem deve ficar na camada de UI, entregando bytes/base64 ao estado; ViewModel não deve acessar `BuildContext`.
- Clientes devem ter `id`, `nome` e `telefone`.
- O telefone deve ser normalizado para comparação e persistência, com máscara visual `(xx) x xxxx-xxxx`.
- O banco SQLite deve ganhar uma tabela de clientes com índice único para telefone normalizado.
- A UI deve permitir cadastrar, listar, pesquisar, carregar e selecionar clientes, preferencialmente sem criar uma nova Page.
- Ao selecionar um cliente, o recibo em edição deve receber nome e telefone do cliente.

## Riscos e dependências
- Persistir imagem em base64 no `SharedPreferences` pode gerar valor grande; o slice deve limitar tipos e tamanho da imagem ou registrar uma pendência explícita se não houver limite.
- Seleção de arquivo/imagem pode exigir nova dependência compatível com Desktop/Web/Mobile; o executor deve escolher uma abordagem compatível e atualizar `pubspec.yaml` apenas se necessário.
- A migração SQLite deve preservar dados existentes, incrementando a versão do banco e implementando `onUpgrade`.
- Telefone duplicado deve ser barrado no banco por índice único e refletido como erro amigável na ViewModel.
- Máscara visual não deve impedir a persistência normalizada nem quebrar busca por dígitos.
- `PedidoPageViewModel` já concentra muitas responsabilidades; as mudanças devem ser pequenas e, se necessário, delegar persistência a repositories/services.
- A tela deve continuar sem `setState` local para estado compartilhado, priorizando `Rx`/`Obx`.
- O contrato público de `PedidoPage`, `CabecalhoApp` e `PedidoPageViewModel` deve ser preservado sempre que possível.
- O worktree já possui alterações não comitadas; os slices devem preservar tudo e evitar refatorações fora do escopo.

## Contratos de tela
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md` apenas como legado de referência, sem criar `ReciboPage`.
- Contratos que precisam ser criados:
  - Nenhum novo contrato de Page/View/Tela é necessário se a solução permanecer dentro da `PedidoPage` com dialogs/painéis.
- Contratos que precisam ser atualizados:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Há impacto em UI porque o cabeçalho passa a ter edição, seleção de logo e cadastro/seleção de clientes dentro da experiência da `PedidoPage`.

## Estratégia
- Primeiro separar persistência e modelo editável do cabeçalho sem alterar UI.
- Depois conectar o estado do cabeçalho à `PedidoPageViewModel`, mantendo `CabecalhoApp` compatível.
- Em seguida criar a UI de edição do cabeçalho e seleção de logo, preservando o fallback atual.
- Depois criar domínio, DTO, schema SQLite e repository de clientes.
- Por fim integrar cadastro/pesquisa/seleção de clientes ao formulário do recibo e revisar a tela completa.

## Decisão sobre slices
- Haverá slices.
- Motivos:
  - a tarefa altera múltiplas responsabilidades: persistência local, SQLite, ViewModel, widgets, input formatter e testes;
  - há duas fontes de persistência diferentes: `SharedPreferences` e SQLite;
  - há impacto visual relevante na `PedidoPage`;
  - a migração SQLite precisa de validação intermediária;
  - a seleção de imagem e base64 adiciona risco de integração e responsividade.

## Validações recomendadas
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`
- `flutter test test/features/pedido_page/data/datasources/recibo_database_test.dart`
- `flutter test test/features/pedido_page/data/repositories/cliente_repository_sqlite_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test`
