# Análise da tarefa

## Pedido original
- Inspirar-se nas imagens em `lib/resources/*` para aplicar o estilo visual nos componentes do projeto.
- Usar as cores do estilo encontrado nos recursos existentes, modernizando o layout.

## Feature correspondente
- Feature principal: `pedido_page`.
- Caminho provável: `lib/features/pedido_page/`.
- A tela real do app hoje é `PedidoPage`, aberta por `lib/main.dart`.

## Arquivos relacionados
- Referências visuais:
  - `lib/resources/tema.jpeg`
  - `lib/resources/cabecalho.png`
  - `lib/resources/recibo.png`
  - `lib/resources/resumo.png`
  - `lib/resources/visualizacao.png`
- Tema e entrada do app:
  - `lib/main.dart`
  - `lib/utils/tema.dart`
- Tela e composição:
  - `lib/features/pedido_page/presentation/pages/pedido_page.dart`
  - `lib/features/pedido_page/presentation/widgets/pedido_page_layout.dart`
- Componentes visuais principais:
  - `lib/features/pedido_page/presentation/widgets/cabecalho_app.dart`
  - `lib/features/pedido_page/presentation/widgets/cabecalho_editor_dialog.dart`
  - `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
  - `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
  - `lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart`
  - `lib/features/pedido_page/presentation/widgets/resumo_pedido.dart`
  - `lib/features/pedido_page/presentation/widgets/visualizacao_recibo.dart`
  - `lib/features/pedido_page/presentation/widgets/clientes_painel.dart`
  - `lib/features/pedido_page/presentation/widgets/historico_recibos_painel.dart`
  - `lib/features/pedido_page/presentation/widgets/recibo_compartilhamento_dialog.dart`
  - `lib/features/pedido_page/presentation/widgets/recibo_pdf_preview_dialog.dart`
- Saída visual relacionada:
  - `lib/features/pedido_page/services/recibo_pdf_service.dart`
- Testes relacionados:
  - `test/widget_test.dart`
  - `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
  - `test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`
  - `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
  - `test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`
  - `test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`
  - `test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`
  - `test/features/pedido_page/services/recibo_pdf_service_test.dart`

## Estado atual
- O app usa `MaterialApp` em `lib/main.dart` com `ThemeData.fromSeed` direto e ainda não conecta o tema customizado de `lib/utils/tema.dart`.
- `TemaApp` existe e centraliza cores/tipografia, mas os tokens atuais estão mais próximos de azul/verde claro do que da identidade das imagens e das regras do projeto.
- `PedidoPage` usa `Scaffold`, `AppBar`, `PedidoPageLayout`, `CabecalhoApp`, `ReciboPedido` e `ResumoPedido`.
- `PedidoPageLayout` empilha cabeçalho, recibo e resumo em coluna, com largura máxima e rolagem vertical.
- `PedidoPage` ainda envolve `ReciboPedido` com `_PedidoPagePlaceholderSection`, exibindo texto explicativo técnico que não faz parte da experiência final.
- `CabecalhoApp` já é responsivo e expõe identidade, contatos e ações, mas usa superfícies de Material 3 sem se aproximar totalmente do cabeçalho das imagens.
- `ReciboPedido` centraliza ações, formulário, tabela de itens e visualização do recibo em uma coluna única.
- `ReciboFormulario`, `ProdutosServicosTabela`, `ResumoPedido` e `VisualizacaoRecibo` já existem como widgets separados, com boa base para modernização incremental.
- Há painéis/dialogs de clientes, histórico, editor de cabeçalho, compartilhamento e prévia de PDF que também precisam ficar coerentes com o novo estilo.
- Há contrato existente em `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Há contrato legado em `lib/features/recibo/presentation/pages/recibo_page-contrato.md`, mas a tela real atual continua sendo `PedidoPage`.
- O worktree já possui alterações não relacionadas; o executor deve preservá-las.

## Estado esperado
- A interface deve continuar sendo uma ferramenta operacional, com visual moderno, denso e claro, sem parecer landing page.
- As imagens de `lib/resources` devem servir como referência visual, não como imagem final embutida nos componentes.
- A paleta deve refletir a identidade da System Card - RS:
  - laranja como cor principal de marca, alinhado a `#f7900a`;
  - azul como cor de destaque/seções, alinhado a `#0c78ce`;
  - verde para ações positivas, geração/sucesso e valores a pagar;
  - superfícies claras, bordas sutis e bom contraste no modo claro e escuro.
- As cores devem ser centralizadas no tema, evitando `Colors.*` e hexadecimais espalhados em widgets de negócio.
- `main.dart` deve usar o tema customizado do projeto.
- `PedidoPage` deve remover textos técnicos de encaixe e apresentar a experiência final de pedido/recibo.
- Cabeçalho, formulário, tabela, resumo, visualização do recibo, painéis e dialogs devem compartilhar linguagem visual consistente.
- O layout deve permanecer responsivo para desktop, web e mobile, sem overflow em larguras próximas de 390, 768, 1024 e 1366 pixels.
- A ViewModel deve continuar concentrando estado; widgets não devem mover regra de negócio para a UI.
- APIs públicas devem ser preservadas, salvo quando uma alteração localizada for indispensável e justificada.

## Riscos e dependências
- Mudanças amplas de layout podem quebrar testes que procuram textos, botões e ordem visual.
- Alterações em `PedidoPageLayout` podem afetar testes diretos do widget e a composição da `PedidoPage`.
- A troca da paleta no tema pode alterar contraste em claro/escuro; deve ser validada visualmente e com testes de overflow.
- `ReciboPedido` já contém vários `Obx`; a modernização não deve aumentar aninhamentos reativos sem necessidade.
- Widgets como `ClientesPainel` e `HistoricoRecibosPainel` usam `StatefulWidget`; não migrar estado local sem necessidade.
- O PDF é gerado por serviço separado; se o slice tocar a aparência do recibo impresso, precisa manter compatibilidade com testes do serviço.
- O contrato `pedido_page-contrato.md` está com alterações no worktree; qualquer atualização deve preservar conteúdo existente e evitar reescrita completa.
- As referências antigas de `ReciboPage` não devem induzir criação de nova tela ou nova feature paralela.

## Contratos de tela
- Contrato existente que deve ser lido antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contrato legado que pode ser lido apenas como referência histórica:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que precisam ser criados:
  - Nenhum. A tarefa deve continuar usando a `PedidoPage` existente.
- Contratos que precisam ser atualizados:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Há impacto direto em UI. Portanto, cada slice que alterar visual, composição ou interação da `PedidoPage` deve atualizar ou revisar o contrato da tela.

## Estratégia
- Primeiro alinhar tokens de tema e entrada do app para que os componentes consumam uma fonte única de cor/tipografia.
- Depois modernizar a composição geral da `PedidoPage`, removendo texto técnico e ajustando espaçamentos/superfícies.
- Em seguida, modernizar componentes por região: cabeçalho, formulário/tabela/ações, resumo/visualização/dialogs.
- Atualizar testes junto das mudanças de cada região, priorizando comportamento, acessibilidade, textos essenciais e ausência de overflow.
- Consolidar contrato de tela e validações no último slice, sem repetir slices já concluídos.

## Decisão sobre slices
- Haverá slices.
- Motivos:
  - a tarefa altera múltiplas responsabilidades visuais;
  - afeta tema, tela, vários widgets, dialogs e testes;
  - há risco de regressão responsiva;
  - a atualização precisa preservar estado reativo, callbacks e integrações de PDF/impressão/compartilhamento;
  - a validação incremental reduz incerteza e evita refatoração ampla demais.

## Validações recomendadas
- `flutter analyze`
- `flutter test test/widget_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`
- `flutter test test/features/pedido_page/services/recibo_pdf_service_test.dart`, se o serviço de PDF for alterado.
- `flutter test` no fechamento, caso o impacto acumulado seja amplo.
- Verificação responsiva manual ou por testes em larguras próximas de 390, 768, 1024 e 1366 pixels.
