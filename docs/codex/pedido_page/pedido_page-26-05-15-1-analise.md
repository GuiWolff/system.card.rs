# Análise da tarefa

## Pedido original
- Criar os slices necessários para a feature `pedido_page`.
- A `PedidoPage` será a Page responsável por juntar:
  - Cabeçalho;
  - Recibo;
  - Resumo.
- O usuário informou que começará por esta parte, portanto o planejamento deve preparar a tela agregadora antes da implementação final dos componentes internos.

## Feature correspondente
- Feature correspondente: `pedido_page`.
- Caminho provável: `lib/features/pedido_page/`.
- Justificativa: o pedido nomeia explicitamente a feature como `pedido_page`. A tela deve ser tratada como camada de composição/integração, não como lugar para duplicar regras internas de cabeçalho, recibo ou resumo.

## Arquivos relacionados
- Arquivos existentes que devem ser lidos:
  - `AGENTS.md`
  - `docs/codex/base-prompt-tarefas.md`
  - `docs/codex/orquestrador.md`
  - `docs/codex/cabecalho/cabecalho-26-05-14-1.md`
  - `docs/codex/cabecalho/cabecalho-26-05-14-1-resumo.md`
  - `docs/codex/recibo/recibo-26-05-14-1.md`
  - `docs/codex/recibo/recibo-26-05-14-1-resumo.md`
  - `docs/codex/resumo/resumo-26-05-15-1.md`
  - `docs/codex/resumo/resumo-26-05-15-1-resumo.md`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
  - `lib/main.dart`
  - `pubspec.yaml`
  - `test/widget_test.dart`
  - `lib/resources/cabecalho.png`
  - `lib/resources/recibo.png`
  - `lib/resources/resumo.png`
  - `lib/resources/tema.jpeg`
- Arquivos previstos para a execução:
  - `lib/features/pedido_page/pedido_page.dart`
  - `lib/features/pedido_page/presentation/pages/pedido_page.dart`
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/pedido_page/presentation/widgets/pedido_page_layout.dart`
  - `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
  - `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
  - `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`

## Estado atual
- O app ainda contém o template padrão Flutter em `lib/main.dart`.
- Não existe `PedidoPage`.
- Não existe `lib/features/pedido_page/`.
- Existe contrato de `ReciboPage` em `lib/features/recibo/presentation/pages/recibo_page-contrato.md`.
- Existem planejamentos separados para cabeçalho, recibo e resumo.
- A implementação real dos widgets `CabecalhoApp`, formulário de recibo e resumo financeiro ainda pode não existir quando a `PedidoPage` começar a ser implementada.
- Há planejamento recente de `resumo` que coloca o bloco de resumo abaixo do recibo dentro da coluna da tela; a `PedidoPage` deve respeitar essa intenção.

## Estado esperado
- A `PedidoPage` deve existir como tela agregadora da experiência de pedido/recibo.
- A tela deve compor, na ordem visual esperada:
  1. cabeçalho no topo;
  2. área de recibo/formulário;
  3. resumo financeiro abaixo do recibo;
  4. espaço futuro para visualização ou ações, se o fluxo da feature exigir.
- A tela deve ser responsiva para desktop e janelas redimensionadas.
- A `PedidoPage` não deve duplicar regras de cálculo, persistência ou renderização interna de componentes. Ela deve orquestrar composição, layout e passagem de estado/callbacks.
- Se algum componente ainda não existir no momento da execução, o slice deve criar apenas encaixes mínimos ou placeholders controlados, registrando a dependência no resumo, sem implementar o componente inteiro fora do slice adequado.

## Riscos e dependências
- Há risco de conflito conceitual com `ReciboPage`, porque o contrato atual dela também descreve uma tela principal completa. A execução deve decidir localmente se `ReciboPage` vira componente interno, se continua como tela separada ou se `PedidoPage` passa a ser a entrada principal, sem duplicar tela completa.
- Cabeçalho, recibo e resumo têm planejamentos próprios. A `PedidoPage` deve integrar os componentes existentes ou planejados, não reimplementar tudo.
- Se `ReciboPage` ainda não existir, a execução deve evitar criar uma implementação paralela completa apenas para satisfazer a `PedidoPage`.
- O app atual ainda é template Flutter; alterar `main.dart` deve ser feito com cuidado e em slice próprio.
- A responsividade é crítica: o conjunto cabeçalho + recibo + resumo pode gerar overflow em janelas menores.
- O estado do resumo deve ter uma fonte de verdade única, preferencialmente vindo do ViewModel/modelo do pedido/recibo.
- O contrato de `ReciboPage` deve ser lido antes de qualquer decisão que mova responsabilidade de tela para `PedidoPage`.

## Contratos públicos que não devem ser quebrados
- Após criada, a API pública `PedidoPage` deve ser preservada como entrada da feature.
- O contrato dos componentes internos deve permanecer desacoplado:
  - cabeçalho recebe dados e callbacks;
  - recibo edita dados do pedido/recibo;
  - resumo exibe totais calculados;
  - a Page integra, não calcula regra de negócio diretamente.
- `PedidoPageViewModel`, se criado, não deve acessar `BuildContext`.

## Telas modificadas ou impactadas
- Tela criada:
  - `PedidoPage`, em `lib/features/pedido_page/presentation/pages/pedido_page.dart`.
- Tela impactada indiretamente:
  - `ReciboPage`, por já existir um contrato que descreve responsabilidades próximas. Durante a implementação, se a responsabilidade visual for transferida para `PedidoPage`, o contrato de `ReciboPage` deve ser revisado no slice correspondente.

## Contratos de tela
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos criados nesta etapa de planejamento:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos que precisam ser atualizados:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`, em todos os slices que alterarem a tela.
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`, somente se a implementação mover ou redefinir responsabilidades da `ReciboPage`.
- Há impacto em UI porque será criada uma Page de composição visual.

## Estratégia
- Criar primeiro a `PedidoPage` como casca de composição e contrato público.
- Separar o layout responsivo em widget próprio para evitar uma Page grande.
- Integrar cabeçalho, recibo e resumo por slots ou componentes reais, conforme o estado atual da implementação no momento do slice.
- Criar ViewModel apenas se a tela precisar coordenar estado compartilhado entre recibo e resumo; caso o estado já exista em `ReciboPageViewModel`, reutilizar sem duplicar.
- Fechar com testes de widget que validem ordem visual, ausência de overflow e integração básica.

## Decisão sobre slices
- Haverá slices.
- Motivos:
  - cria uma nova Page;
  - integra múltiplos componentes principais;
  - envolve responsividade;
  - pode exigir coordenação de estado entre recibo e resumo;
  - pode impactar `main.dart`, testes e contratos de tela;
  - precisa preservar planejamentos anteriores sem duplicação.

## Validações recomendadas
- `flutter analyze`
- `flutter test`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- Verificação responsiva em larguras próximas de 390, 768, 1024 e 1366 pixels.
