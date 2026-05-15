# Análise da tarefa

## Pedido original
- Criar uma análise para o cabeçalho de um app a ser desenvolvido, usando `lib/resources/cabecalho.png` como referência visual principal.
- Considerar `lib/resources/tema.jpeg` como referência do contexto da tela e do padrão visual dos campos do app.
- Seguir as diretrizes do projeto descritas em `AGENTS.md`.
- Identificar os dados necessários para o cabeçalho.
- Criar slices pequenos para dividir a implementação futura.

## Feature correspondente
- Feature provável: `recibo`.
- Caminho esperado: `lib/features/recibo/`.
- Justificativa: `tema.jpeg` mostra a janela "System Card - RS | Recibo", com cabeçalho, formulário de recibo, produtos/serviços, resumo e visualização do recibo. O cabeçalho deve ser tratado como parte da tela principal de recibo, não como uma feature isolada horizontal.

## Arquivos relacionados
- Arquivos existentes:
  - `AGENTS.md`
  - `pubspec.yaml`
  - `lib/main.dart`
  - `test/widget_test.dart`
  - `lib/resources/cabecalho.png`
  - `lib/resources/tema.jpeg`
- Arquivos de planejamento criados por esta análise:
  - `docs/codex/cabecalho/cabecalho-26-05-14-1.md`
  - `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_1.md`
  - `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_2.md`
  - `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_3.md`
  - `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_4.md`
  - `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_5.md`
  - `docs/codex/cabecalho/cabecalho-26-05-14-1-resumo.md`
- Arquivos esperados na implementação futura:
  - `lib/features/recibo/presentation/pages/recibo_page.dart`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
  - `lib/features/recibo/presentation/widgets/cabecalho_app.dart`
  - `lib/features/recibo/presentation/viewmodels/recibo_page_view_model.dart`
  - `lib/features/recibo/domain/models/cabecalho_empresa.dart`
  - `test/features/recibo/presentation/widgets/cabecalho_app_test.dart`
  - `test/features/recibo/presentation/viewmodels/recibo_page_view_model_test.dart`

## Estado atual
- O projeto atual está próximo do template padrão do Flutter.
- `lib/main.dart` ainda contém `MyHomePage`, contador e `setState`.
- `test/widget_test.dart` ainda testa o contador do template.
- Não existe atualmente a pasta `lib/features/`.
- Não existe `lib/observable/`, apesar de `AGENTS.md` citar esse padrão como diretriz preferencial.
- Não existe `lib/utils/tema.dart` no worktree atual, apesar de documentos antigos em `docs/codex/tema/` citarem esse arquivo.
- `pubspec.yaml` ainda não registra `lib/resources/` como assets.
- As imagens disponíveis são referências visuais, não uma implementação reutilizável do cabeçalho.

## Estado esperado
- O app deve ter uma tela de recibo responsiva com cabeçalho no topo, seguindo arquitetura vertical por feature.
- O cabeçalho deve ser composto por widgets Flutter, não renderizado como uma imagem única do print `cabecalho.png`.
- O cabeçalho deve exibir:
  - logomarca da System Card - RS;
  - nome "SYSTEM CARD - RS";
  - subtítulo "Sistemas de Identificação";
  - Instagram `@systemcards`;
  - WhatsApp `51 998020198`;
  - telefone `51 30551025`;
  - endereço `Rua 20 de Setembro, 528 - Centro - Guaíba - RS`;
  - ação principal "IMPRIMIR";
  - ação principal "GERAR PDF";
  - ação secundária "MAIS OPÇÕES".
- O cabeçalho deve se adaptar a desktop, tablet e mobile:
  - em telas largas, identidade, contatos e ações ficam na mesma linha;
  - em largura intermediária, contatos e ações podem quebrar para uma segunda linha mantendo alinhamento;
  - em telas pequenas, identidade, contatos e ações devem empilhar sem overflow horizontal.
- As ações do cabeçalho devem ser conectadas por callbacks ou estado do ViewModel, sem lógica pesada dentro do widget.

## Dados necessários para o cabeçalho
- Identidade:
  - caminho do asset da logomarca;
  - nome da empresa;
  - subtítulo institucional;
  - texto alternativo/semantics da logomarca.
- Contatos:
  - identificador do Instagram;
  - telefone de WhatsApp;
  - telefone fixo/comercial;
  - endereço completo;
  - ícone semântico de cada canal;
  - rótulos acessíveis para leitores de tela.
- Ações:
  - rótulo visível de cada botão;
  - ícone de cada botão;
  - callback de imprimir;
  - callback de gerar PDF;
  - callback ou itens do menu "Mais opções";
  - estado habilitado/desabilitado;
  - estado de carregamento quando impressão/PDF estiver em andamento;
  - mensagens de erro ou feedback quando a ação ainda não estiver disponível.
- Responsividade:
  - largura disponível;
  - breakpoints ou regras por `LayoutBuilder`;
  - tamanhos mínimo/máximo da logomarca;
  - espaçamentos horizontais e verticais;
  - regra para exibir botões com texto completo ou versão compacta.
- Tema:
  - cor principal da marca para o nome;
  - cor de destaque para ações;
  - cor de sucesso para "GERAR PDF";
  - cor neutra para "MAIS OPÇÕES";
  - cor de fundo do cabeçalho;
  - estilos de texto para título, subtítulo, contato e botão.

## Riscos e dependências
- O print `cabecalho.png` tem 1377x126 e representa um cabeçalho pronto; usar essa imagem diretamente quebraria responsividade, acessibilidade e interação dos botões.
- Não há asset de logomarca isolado no estado atual. A implementação deve verificar se um logo dedicado será adicionado ou criar fallback visual controlado sem recortar arquivos sem autorização.
- As ações "IMPRIMIR" e "GERAR PDF" dependem de funcionalidades que ainda não existem no código atual.
- O app atual usa `setState` do template; a implementação deve evitar espalhar esse padrão e concentrar estado em ViewModel quando houver estado de tela.
- Como `TemaApp` e `TemaService` não existem no worktree atual, os slices devem verificar o estado real antes de assumir a API de tema citada no `AGENTS.md`.
- É necessário atualizar o teste inicial do contador quando `MyHomePage` for substituída pela tela real.
- O cabeçalho precisa evitar overflow em larguras pequenas, principalmente por causa do endereço e dos três botões.

## Contratos de tela
- Contratos existentes que devem ser lidos antes da alteração:
  - Nenhum contrato existente foi encontrado para a tela de recibo.
- Contratos criados nesta etapa de planejamento:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`
- Contratos que precisam ser atualizados durante a implementação:
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`, sempre que a tela, o cabeçalho, ações visuais, estados responsivos ou dados renderizados forem alterados.
- Há impacto em UI porque a tarefa define a estrutura visual e responsiva do cabeçalho da tela principal do app.

## Estratégia
- Criar primeiro a estrutura mínima da feature `recibo` e substituir o template Flutter por uma tela real controlada.
- Modelar os dados do cabeçalho antes de desenhar o widget, para separar conteúdo, estado e apresentação.
- Implementar o cabeçalho como componente responsivo composto, usando `LayoutBuilder`, `Wrap`, `Flex` ou widgets equivalentes.
- Integrar os botões por callbacks, mantendo impressão e geração de PDF como ações conectáveis sem implementar fluxos complexos fora do escopo do cabeçalho.
- Fechar com testes de widget para desktop, tablet e mobile, além de `flutter analyze`.

## Decisão sobre slices
- Haverá slices.
- Motivos:
  - a tarefa altera múltiplas responsabilidades: estrutura de feature, tela, modelo de dados, ViewModel, widget responsivo e testes;
  - envolve UI responsiva com risco de overflow;
  - prepara ações futuras de impressão e PDF;
  - exige atualização de contrato de tela;
  - o estado atual do projeto ainda é o template Flutter, então a implementação precisa ser incremental.

## Validações recomendadas
- `flutter analyze`
- `flutter test`
- `flutter test test/features/recibo/presentation/widgets/cabecalho_app_test.dart`
- `flutter test test/features/recibo/presentation/viewmodels/recibo_page_view_model_test.dart`
- Verificação manual ou teste de widget com larguras aproximadas de 390, 768, 1024 e 1366 pixels.
