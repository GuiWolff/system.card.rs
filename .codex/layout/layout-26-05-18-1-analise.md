# Análise da tarefa

## Pedido original
- Modernizar o app todo, deixando a interface com cara de software de caixa empresarial, atualizada para um layout de 2026 em estilo Microsoft.
- Manter `FaIcon` apenas onde o ícone for de WhatsApp ou Instagram.
- Migrar os demais ícones visíveis para ícones nativos do Flutter, preferencialmente `Icon` com `Icons.*`.
- Criar slices com poucas responsabilidades para reduzir risco de estouro de contexto.

## Regras e skills aplicáveis
- Fontes lidas antes da análise:
  - `AGENTS.md`.
  - `.codex/rules/RULE.md`.
  - `.codex/skills/argo-flutter-dev/SKILL.md`.
  - `.codex/skills/argo-flutter-dev/references/tema.md`.
  - `.codex/skills/argo-rule-manager/SKILL.md`.
  - `.codex/base-prompt-tarefas.md`.
- `argo-flutter-dev` é aplicável porque a tarefa envolve Flutter, UI, tema, widgets, testes, responsividade e validações.
- `references/tema.md` é aplicável porque a tarefa altera tema, cores, superfícies, tipografia e contraste.
- `argo-rule-manager` foi consultada porque este fluxo gera prompts persistentes de execução em `.codex/`, mas a tarefa não pede alteração de regras, skills ou referências.
- Referências externas de design consultadas para orientar o conceito visual, sem substituir regras locais:
  - Fluent 2 Design System: `https://fluent2.microsoft.design/`.
  - Fluent 2 Color: `https://fluent2.microsoft.design/color`.

## Feature correspondente
- Feature principal: `pedido_page`.
- Caminho real: `lib/features/pedido_page/`.
- O app atual possui uma tela principal real: `PedidoPage`.
- O contrato legado `lib/features/recibo/presentation/pages/recibo_page-contrato.md` existe apenas como referência histórica; a tela real em execução continua sendo `PedidoPage`.

## Arquivos relacionados
- Arquivos de app e tema:
  - `lib/main.dart`.
  - `lib/utils/tema.dart`.
  - `pubspec.yaml`.
  - `pubspec.lock`.
- Page, layout e contrato:
  - `lib/features/pedido_page/presentation/pages/pedido_page.dart`.
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
  - `lib/features/pedido_page/presentation/widgets/pedido_page_layout.dart`.
- Widgets de apresentação impactados:
  - `lib/features/pedido_page/presentation/widgets/cabecalho_app.dart`.
  - `lib/features/pedido_page/presentation/widgets/cabecalho_editor_dialog.dart`.
  - `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`.
  - `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`.
  - `lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart`.
  - `lib/features/pedido_page/presentation/widgets/resumo_pedido.dart`.
  - `lib/features/pedido_page/presentation/widgets/visualizacao_recibo.dart`.
  - `lib/features/pedido_page/presentation/widgets/clientes_painel.dart`.
  - `lib/features/pedido_page/presentation/widgets/historico_recibos_painel.dart`.
  - `lib/features/pedido_page/presentation/widgets/recibo_compartilhamento_dialog.dart`.
  - `lib/features/pedido_page/presentation/widgets/recibo_pdf_preview_dialog.dart`.
- Estado e contratos públicos que devem ser preservados:
  - `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`.
  - `lib/features/pedido_page/domain/models/`.
  - `lib/features/pedido_page/domain/repositories/`.
  - `lib/features/pedido_page/services/`.
- Testes relacionados:
  - `test/widget_test.dart`.
  - `test/features/pedido_page/presentation/pages/pedido_page_test.dart`.
  - `test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`.
  - `test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`.
  - `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`.
  - `test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`.
  - `test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`.

## Estado atual
- `lib/main.dart` inicia `PedidoPage` com `ThemeMode.light`, `TemaApp.temaClaro()` e `TemaApp.temaEscuro()`.
- `lib/utils/tema.dart` já usa `ThemeData` com `useMaterial3: true`, `ColorScheme.fromSeed`, superfícies semânticas e tipografia própria.
- A identidade visual atual está baseada principalmente em laranja como cor primária e azul como destaque no código real.
- Há divergência entre algumas referências textuais de tema e o código real; a execução deve tratar `lib/utils/tema.dart` e a referência de tema como fontes que precisam ser conciliadas, sem trocar marca ou semântica visual por impulso.
- `PedidoPage` é a Page agregadora do fluxo de caixa/recibo, abrindo cabeçalho, recibo, visualização, produtos/serviços, resumo, clientes, histórico, compartilhamento, PDF e impressão.
- A composição atual é funcional, mas ainda tem aparência de cards empilhados e controles separados, menos próxima de uma aplicação empresarial de caixa com comandos densos e layout de trabalho.
- Vários arquivos de apresentação estão grandes:
  - `pedido_page.dart` tem mais de 500 linhas.
  - `cabecalho_app.dart`, `cabecalho_editor_dialog.dart`, `produtos_servicos_tabela.dart` e `visualizacao_recibo.dart` também passam de 500 linhas.
  - `pedido_page_view_model.dart` passa de 1000 linhas, mas a tarefa é visual e não deve refatorar o estado sem necessidade.
- O uso de `FontAwesome` está espalhado pela apresentação e pelos testes:
  - `cabecalho_app.dart`.
  - `cabecalho_editor_dialog.dart`.
  - `recibo_pedido.dart`.
  - `recibo_formulario.dart`.
  - `produtos_servicos_tabela.dart`.
  - `visualizacao_recibo.dart`.
  - `clientes_painel.dart`.
  - `historico_recibos_painel.dart`.
  - `recibo_compartilhamento_dialog.dart`.
  - `recibo_pdf_preview_dialog.dart`.
- Os testes de UI validam muitos `FaIcon` e `FontAwesomeIcons`, inclusive para ícones que não são WhatsApp nem Instagram.
- `font_awesome_flutter` deve permanecer no projeto se Instagram e WhatsApp continuarem usando `FaIcon`.
- Os assets `lib/resources/icon_whatsapp.svg` e `lib/resources/icon_instagram.svg` existem como legado; a tarefa não pede remoção.

## Estado esperado
- O app deve parecer uma ferramenta de caixa empresarial moderna:
  - mais densa e operacional;
  - com hierarquia clara de comandos;
  - com painéis de trabalho previsíveis;
  - com superfícies neutras, bordas sutis, foco em legibilidade e baixa ornamentação;
  - com responsividade estável para Web/Desktop/Mobile.
- O estilo visual deve se aproximar de uma leitura Microsoft/Fluent atual usando Flutter Material 3:
  - comandos principais agrupados como barra de ações;
  - superfícies discretas;
  - estados de foco, hover, desabilitado e erro coerentes;
  - densidade adequada para uso repetitivo;
  - tipografia sem escala exagerada dentro de painéis.
- O app não deve virar landing page, nem usar hero decorativo, gradientes, ilustrações soltas ou cards aninhados.
- A tela principal deve continuar sendo `PedidoPage`; não criar nova rota, nova Page ou feature paralela para este escopo.
- `FaIcon` deve ficar restrito a WhatsApp e Instagram:
  - permitido: `FontAwesomeIcons.whatsapp`.
  - permitido: `FontAwesomeIcons.instagram`.
  - proibido para demais ícones visíveis: `FontAwesomeIcons.phone`, `filePdf`, `trashCan`, `shareNodes`, `floppyDisk`, `calendarDays`, `user`, `locationDot`, `xmark`, `copy` e equivalentes.
- Ícones não relacionados a marca devem usar os nativos do Flutter, por exemplo `Icons.save_outlined`, `Icons.print_outlined`, `Icons.picture_as_pdf_outlined`, `Icons.person_outline`, `Icons.call_outlined`, `Icons.location_on_outlined`, `Icons.delete_outline`, `Icons.search`, `Icons.close`, `Icons.upload_file_outlined`.
- Testes devem ser atualizados para validar a nova regra visual:
  - `FaIcon` apenas para WhatsApp/Instagram;
  - `Icon`/`Icons.*` para os demais casos.
- Contrato da `PedidoPage` deve ser atualizado em cada slice com impacto visual.

## Riscos e dependências
- O escopo é amplo e impacta quase todos os widgets visíveis da feature `pedido_page`.
- Migrar ícones de volta para `Icons.*` quebra testes existentes que procuram `FaIcon`.
- `FaIcon` e `Icon` têm métricas diferentes; botões, campos e linhas podem precisar de ajuste de tamanho para evitar desalinhamento.
- Alterar tema global pode causar regressões em dialogs, campos, botões e PDF preview.
- A aparência "Microsoft" é uma direção visual, não uma dependência; não adicionar pacote `fluent_ui` sem necessidade.
- A implementação deve preservar comportamento de recibo, persistência SQLite, geração de PDF, impressão, compartilhamento, clientes e histórico.
- O uso de `BuildContext` deve permanecer fora da ViewModel.
- Não refatorar `PedidoPageViewModel` apenas por tamanho; só tocar estado se uma necessidade visual concreta exigir.
- Não remover `font_awesome_flutter`, porque a regra permite WhatsApp e Instagram com `FaIcon`.
- Não remover `flutter_svg` ou assets SVG sem confirmar que a remoção é segura e faz parte do escopo.
- Os arquivos grandes devem ser tratados com mudanças localizadas; se for necessário extrair widgets, cada extração deve ter responsabilidade clara e permanecer dentro da feature.

## Contratos de tela
- Contrato existente que deve ser lido antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Contrato legado que pode ser lido apenas como referência histórica:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`.
- Contratos que precisam ser criados:
  - Nenhum. A tarefa impacta a `PedidoPage` existente e widgets internos da mesma tela.
- Contratos que precisam ser atualizados:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Contrato revisado por este gerador:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`, com uma seção de revisão planejada da modernização.
- Impacto em UI:
  - Sim. A tarefa altera tema, layout, cabeçalho, formulário, ações, tabela, resumo, visualização, dialogs, painéis e ícones visíveis.

## Estratégia
- Dividir a modernização por camada visual e área da tela.
- Começar pelo tema global para estabelecer tokens, densidade, superfícies e estados visuais.
- Em seguida ajustar o shell da `PedidoPage` e o layout principal, sem misturar com os widgets internos.
- Migrar áreas funcionais em slices separados:
  - cabeçalho e editor;
  - ações e formulário de recibo;
  - tabela e resumo;
  - visualização e painéis auxiliares.
- Atualizar testes junto do slice que muda o widget correspondente.
- Encerrar com auditoria de ícones, imports, responsividade e validações completas.

## Decisão sobre slices
- Haverá slices.
- Justificativa:
  - A tarefa altera múltiplas responsabilidades de UI.
  - Impacta tema, Page, layout, widgets, dialogs, painéis e testes.
  - A migração de ícones atravessa vários arquivos.
  - A modernização visual ampla tem alto risco de regressão responsiva.
  - Slices pequenos permitem validar comportamento e aparência por área.

## Validações recomendadas
- `flutter analyze`.
- `flutter test test/widget_test.dart`.
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`.
- `flutter test test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`.
- `flutter test test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`.
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`.
- `flutter test test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`.
- `flutter test test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`.
- `flutter test`, no fechamento, se viável.
- Varredura final:
  - `rg -n "FontAwesomeIcons|FaIcon|font_awesome_flutter" lib/features/pedido_page/presentation test/features/pedido_page/presentation`
  - confirmar que qualquer ocorrência remanescente está ligada somente a WhatsApp ou Instagram.
