# Análise da tarefa

## Pedido original
- Planejar a feature de recibo do app System Card - RS.
- Usar `lib/resources/recibo.png` como referência do formulário editável da feature.
- Usar `lib/resources/visualizacao.png` para entender os dados renderizados no recibo final.
- O app deve rodar em Flutter Desktop.
- O histórico de recibos deve ser persistido localmente com SQLite embarcado.
- Criar slices para um orquestrador iniciar, executar, finalizar e limpar o contexto a cada slice.

## Feature correspondente
- Feature: `recibo`.
- Caminho provável: `lib/features/recibo/`.
- A feature deve seguir arquitetura vertical feature-first, concentrando telas, widgets, ViewModels, modelos, repositórios e infraestrutura SQLite dentro de `lib/features/recibo/`, salvo dependências de inicialização global inevitáveis em `lib/main.dart`.

## Arquivos relacionados
- Arquivos existentes que devem ser lidos:
  - `AGENTS.md`
  - `docs/codex/orquestrador.md`
  - `docs/codex/cabecalho/cabecalho-26-05-14-1.md`
  - `docs/codex/cabecalho/cabecalho-26-05-14-1-resumo.md`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
  - `lib/main.dart`
  - `pubspec.yaml`
  - `test/widget_test.dart`
  - `lib/resources/recibo.png`
  - `lib/resources/visualizacao.png`
  - `lib/resources/cabecalho.png`
  - `lib/resources/tema.jpeg`
- Arquivos prováveis de produção:
  - `lib/features/recibo/recibo.dart`
  - `lib/features/recibo/domain/models/recibo.dart`
  - `lib/features/recibo/domain/models/item_recibo.dart`
  - `lib/features/recibo/domain/models/resumo_recibo.dart`
  - `lib/features/recibo/domain/repositories/recibo_repository.dart`
  - `lib/features/recibo/data/datasources/recibo_database.dart`
  - `lib/features/recibo/data/dtos/recibo_dto.dart`
  - `lib/features/recibo/data/dtos/item_recibo_dto.dart`
  - `lib/features/recibo/data/repositories/recibo_repository_sqlite.dart`
  - `lib/features/recibo/presentation/pages/recibo_page.dart`
  - `lib/features/recibo/presentation/widgets/recibo_formulario.dart`
  - `lib/features/recibo/presentation/widgets/produtos_servicos_tabela.dart`
  - `lib/features/recibo/presentation/widgets/resumo_recibo_card.dart`
  - `lib/features/recibo/presentation/widgets/visualizacao_recibo.dart`
  - `lib/features/recibo/presentation/widgets/historico_recibos_painel.dart`
  - `lib/features/recibo/presentation/viewmodels/recibo_page_view_model.dart`
- Arquivos prováveis de teste:
  - `test/features/recibo/domain/models/recibo_test.dart`
  - `test/features/recibo/data/repositories/recibo_repository_sqlite_test.dart`
  - `test/features/recibo/presentation/viewmodels/recibo_page_view_model_test.dart`
  - `test/features/recibo/presentation/widgets/recibo_page_test.dart`
  - `test/features/recibo/presentation/widgets/visualizacao_recibo_test.dart`

## Estado atual
- O app ainda está no template padrão do Flutter.
- `lib/main.dart` contém `MyApp`, `MyHomePage`, contador e uso de `setState`.
- `test/widget_test.dart` ainda valida o contador do template.
- `pubspec.yaml` ainda não declara dependências de SQLite para Desktop.
- `pubspec.yaml` ainda não registra `lib/resources/` como assets.
- A pasta `lib/features/recibo/` existe apenas por causa do contrato de tela criado no planejamento anterior; a tela `ReciboPage` ainda não existe.
- Não há camada de domínio, repositório, datasource SQLite ou ViewModel para recibos.
- Não há `lib/observable/`, apesar de `AGENTS.md` recomendar `Rx`/`Obx`; a implementação deve verificar o estado real antes de depender dessa infraestrutura.
- Não há tema customizado implementado no worktree atual; as diretrizes de cor do `AGENTS.md` devem orientar o uso de `ThemeData`, `ColorScheme` e constantes semânticas locais quando necessário.

## Estado esperado
- O app deve iniciar na tela `ReciboPage`, voltada para Flutter Desktop.
- A tela deve permitir criar, editar e visualizar recibos com:
  - número do recibo;
  - data de recebimento;
  - data de entrega;
  - nome do cliente;
  - telefone do cliente;
  - observações;
  - lista de produtos/serviços;
  - quantidade;
  - descrição do produto/serviço;
  - valor unitário;
  - valor total por item;
  - total do pedido;
  - valor de entrada;
  - valor a pagar na entrega.
- A visualização do recibo deve ser derivada dos mesmos dados do formulário.
- O histórico deve ser persistido em SQLite embarcado no desktop, com operações de criar, atualizar, listar, carregar e excluir recibos.
- Os valores monetários devem ser persistidos como centavos inteiros para evitar erro de ponto flutuante.
- Cada slice deve poder ser executado isoladamente por um orquestrador em sessão limpa, lendo o prompt mestre, a análise e o resumo do slice anterior.

## Riscos e dependências
- A persistência SQLite em Flutter Desktop exige dependências específicas. Para Desktop, deve-se preferir `sqflite_common_ffi` ou solução equivalente compatível com Windows/Linux/macOS, e não assumir que `sqflite` móvel resolve desktop sozinho.
- Migrations precisam ser planejadas desde a primeira versão para evitar perda de histórico.
- Operações de salvar recibo e itens devem ser transacionais para evitar recibos sem itens ou itens órfãos.
- Valores monetários devem ser tratados em centavos para evitar inconsistência de cálculo e arredondamento.
- Datas devem ser armazenadas em formato estável, preferencialmente ISO-8601, e exibidas em `dd/MM/yyyy`.
- A tela tem risco alto de overflow em desktop redimensionado, porque há campos, tabela, botões, resumo e visualização lado a lado.
- A visualização e o formulário não devem manter estados duplicados divergentes.
- O histórico pode crescer; listas devem usar builder.
- O app atual ainda usa contador do template; testes e entrada do app precisam ser migrados com cuidado.
- O contrato de tela já existente foi criado para o cabeçalho e precisa ser atualizado para a feature completa de recibo.

## Contratos públicos que não devem ser quebrados
- Após criada, a API pública `ReciboPage` deve ser preservada como entrada da feature.
- O contrato `ReciboRepository` deve ser estável para permitir trocar a persistência SQLite por outra fonte no futuro.
- Os modelos de domínio devem evitar dependência de Flutter, widgets ou SQLite.
- A visualização do recibo deve consumir modelo/estado da feature, sem depender de DTOs da camada de dados.

## Telas modificadas ou impactadas
- `ReciboPage`, em `lib/features/recibo/presentation/pages/recibo_page.dart`.
- Não há necessidade inicial de criar outra Page. O histórico deve começar como painel/dialog/widget dentro da `ReciboPage`, para evitar contrato extra sem necessidade.

## Contratos de tela
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que precisam ser criados:
  - Nenhum contrato adicional, desde que o histórico seja implementado como painel/dialog/widget dentro da `ReciboPage`.
- Contratos que precisam ser atualizados:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Há impacto em UI porque a tarefa define a tela principal da feature, o formulário, a tabela de itens, o resumo, a visualização e o painel de histórico.

## Estratégia
- Dividir a implementação em slices pequenos e sequenciais, adequados ao orquestrador.
- Começar pela base da feature e entrada do app.
- Criar domínio e regras de cálculo antes de banco e UI.
- Criar infraestrutura SQLite e migrations antes de conectar ViewModel.
- Implementar repository com testes transacionais.
- Construir ViewModel como camada de estado entre UI e repositório.
- Implementar UI editável seguindo `recibo.png`.
- Implementar visualização do recibo seguindo `visualizacao.png`.
- Integrar histórico persistido, ações e validações finais.
- Cada slice deve gerar seu próprio resumo e parar, permitindo que o orquestrador encerre a sessão e abra outra sessão limpa.

## Decisão sobre slices
- Haverá slices.
- Motivos:
  - a tarefa envolve UI, domínio, estado, persistência SQLite, repository, testes e responsividade;
  - há fluxo transacional de salvar recibo com itens;
  - há histórico persistido e carregamento de registros;
  - há risco de regressão por substituir o template inicial;
  - a execução deve ser compatível com orquestrador e contexto limpo por slice.

## Validações recomendadas
- `flutter analyze`
- `flutter test`
- `flutter test test/features/recibo/domain/models/recibo_test.dart`
- `flutter test test/features/recibo/data/repositories/recibo_repository_sqlite_test.dart`
- `flutter test test/features/recibo/presentation/viewmodels/recibo_page_view_model_test.dart`
- `flutter test test/features/recibo/presentation/widgets/recibo_page_test.dart`
- `flutter test test/features/recibo/presentation/widgets/visualizacao_recibo_test.dart`
- Teste manual em Flutter Windows/Desktop com criação, salvamento, fechamento/reabertura e carregamento do histórico.
