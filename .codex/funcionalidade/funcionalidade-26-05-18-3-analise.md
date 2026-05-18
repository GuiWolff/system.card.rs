# Análise da tarefa

## Pedido original
- Planejar ajustes na feature de recibos para:
  - formatar inputs monetários em reais deslocando a vírgula automaticamente para a esquerda, de modo que `235` vire `2,35`;
  - ao salvar recibo, remover o último item quando ele tiver descrição vazia e valor `0,00`;
  - pesquisar clientes enquanto o usuário digita o nome, exibindo sugestões estilo combobox no formato `Nome - Telefone - E-mail`, omitindo telefone/e-mail quando não existirem;
  - mover a ação de imprimir para a visualização do PDF, junto da ação de compartilhar;
  - remover a ação de compartilhar da linha de ações rápidas do recibo;
  - corrigir a exceção `The Scrollbar's ScrollController has no ScrollPosition attached`.

## Regras e skills aplicáveis
- Fontes lidas antes da análise:
  - `AGENTS.md`;
  - `.codex/rules/RULE.md`;
  - `.codex/skills/argo-flutter-dev/SKILL.md`;
  - `.codex/skills/argo-flutter-dev/references/tema.md`;
  - `.codex/base-prompt-tarefas.md`.
- A skill `.codex/skills/argo-flutter-dev/SKILL.md` é aplicável porque a tarefa envolve Dart/Flutter, UI, ViewModel, estado, widgets, testes e validação.
- A referência `.codex/skills/argo-flutter-dev/references/tema.md` é aplicável porque há alteração visual no campo de cliente, nas ações do recibo, na prévia do PDF e na rolagem da tela.
- `.codex/skills/argo-rule-manager/SKILL.md` não é aplicável porque a tarefa não altera regras persistentes, skills ou referências de skills.

## Feature correspondente
- Feature: `pedido_page`.
- Caminho principal: `lib/features/pedido_page/`.
- A tela agregadora é `lib/features/pedido_page/presentation/pages/pedido_page.dart`.

## Arquivos relacionados
- Produção:
  - `lib/features/pedido_page/presentation/pages/pedido_page.dart`;
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`;
  - `lib/features/pedido_page/presentation/widgets/pedido_page_layout.dart`;
  - `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`;
  - `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`;
  - `lib/features/pedido_page/presentation/widgets/resumo_pedido.dart`;
  - `lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart`;
  - `lib/features/pedido_page/presentation/widgets/recibo_pdf_preview_dialog.dart`;
  - `lib/features/pedido_page/presentation/widgets/recibo_compartilhamento_dialog.dart`;
  - `lib/features/pedido_page/presentation/widgets/clientes_painel.dart`;
  - `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`;
  - `lib/features/pedido_page/presentation/input_formatters/telefone_input_formatter.dart`;
  - possível novo formatter em `lib/features/pedido_page/presentation/input_formatters/`;
  - `lib/features/pedido_page/domain/models/cliente.dart`;
  - `lib/features/pedido_page/domain/models/item_recibo.dart`;
  - `lib/features/pedido_page/domain/models/recibo.dart`;
  - `lib/features/pedido_page/domain/repositories/cliente_repository.dart`;
  - `lib/features/pedido_page/data/repositories/cliente_repository_sqlite.dart`;
  - `lib/features/pedido_page/services/recibo_impressao_service.dart`;
  - `lib/features/pedido_page/services/recibo_compartilhamento_service.dart`;
  - `lib/features/pedido_page/services/recibo_pdf_service.dart`.
- Testes:
  - `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`;
  - `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`;
  - `test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`;
  - `test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`;
  - `test/features/pedido_page/presentation/pages/pedido_page_test.dart`;
  - possível novo teste para formatter monetário em `test/features/pedido_page/presentation/input_formatters/`.

## Estado atual
- Os campos monetários de `ReciboFormulario`, `ResumoPedido` e `ProdutosServicosTabela` aceitam `0-9`, ponto e vírgula e convertem o texto com interpretação decimal direta.
- Hoje, digitar `235` é interpretado como `235,00`, não como `2,35`.
- O valor unitário já é exibido como `reais,centavos`, mas o input ainda permite digitação manual da vírgula.
- O salvamento em `PedidoPageViewModel.salvarRecibo()` valida o recibo completo antes de persistir; se o último item foi criado por Enter e está com descrição vazia e valor `0`, a validação falha com erro de descrição obrigatória.
- `PedidoPageViewModel.solicitarNovoItem()` cria um item vazio quando o item de referência tem valor unitário maior que zero.
- O campo `Cliente` do formulário é um campo de texto simples que chama `onClienteChanged`.
- A feature já possui cadastro, listagem, pesquisa e seleção de clientes no painel `ClientesPainel`, além de `PedidoPageViewModel.pesquisarClientes()` e `ClienteRepository.pesquisar()`.
- A área `Ações do recibo` em `ReciboPedido` exibe ações para salvar, novo recibo, histórico, clientes, imprimir, gerar PDF e compartilhar.
- `ReciboPdfPreviewDialog` já exibe a prévia do PDF com ações de compartilhar, salvar arquivo e fechar, mas não possui ação de imprimir.
- `PedidoPageLayout` usa `Scrollbar` envolvendo `SingleChildScrollView` sem `ScrollController` explícito. Em alguns cenários de desktop/web, o `Scrollbar` tenta usar um `PrimaryScrollController` sem posição anexada e dispara a exceção informada.

## Estado esperado
- Todos os inputs monetários de recibo devem permitir digitação por centavos:
  - `2` deve virar `0,02`;
  - `23` deve virar `0,23`;
  - `235` deve virar `2,35`;
  - `2350` deve virar `23,50`.
- A regra deve ser centralizada em um formatter/helper reutilizável para evitar três conversões divergentes.
- A camada de domínio deve continuar recebendo valores monetários como centavos inteiros.
- Ao salvar, se o último item tiver descrição vazia e `valorUnitarioCentavos == 0`, ele deve ser removido antes da validação e da persistência.
- A remoção automática deve atingir somente o último item acidental; itens intermediários ou itens com descrição/valor preenchidos devem continuar sendo validados normalmente.
- Ao digitar no campo de cliente, a UI deve pesquisar clientes e exibir sugestões no próprio formulário, em estilo combobox.
- Cada sugestão deve mostrar o nome e, quando existirem, telefone formatado e e-mail: `Nome - Telefone - E-mail`.
- Selecionar um cliente deve preencher os dados atuais do recibo usando a regra existente de seleção de cliente da ViewModel.
- A linha de ações rápidas do recibo não deve mais exibir `Imprimir` nem `Compartilhar`; a entrada para o fluxo deve ser `Gerar PDF`.
- A prévia do PDF deve concentrar as ações `Imprimir`, `Compartilhar`, `Salvar arquivo` e `Fechar`, reutilizando os bytes já gerados para a prévia.
- A rolagem da `PedidoPage` deve usar o mesmo `ScrollController` no `Scrollbar` e no `SingleChildScrollView`, evitando a exceção de `ScrollPosition`.

## Riscos e dependências
- Formatter monetário:
  - risco de quebrar sincronização de `TextEditingController` enquanto o campo está focado;
  - risco de reposicionar o cursor de forma ruim durante digitação/apagamento;
  - risco de manter conversores duplicados com regras diferentes em `ReciboFormulario`, `ResumoPedido` e `ProdutosServicosTabela`.
- Limpeza do último item:
  - deve ocorrer antes de `reciboEmEdicao.validar()`;
  - deve preservar a ordem dos itens remanescentes;
  - não deve apagar itens válidos ou itens não finais.
- Combobox de clientes:
  - deve reaproveitar `ClienteRepository` e `PedidoPageViewModel`;
  - deve evitar colocar `BuildContext` na ViewModel;
  - deve lidar com pesquisas rápidas sem exibir resultado muito antigo sobre termo mais novo;
  - deve preservar o painel `ClientesPainel` existente.
- Ações de PDF:
  - a impressão pela prévia deve usar os mesmos bytes e nome de arquivo já gerados, sem gerar outro PDF desnecessariamente;
  - remover ações visuais não deve remover serviços legados sem necessidade;
  - `ReciboPedido` é exportado no barrel da feature, então mudanças de API pública devem ser evitadas ou justificadas.
- Scrollbar:
  - ao converter `PedidoPageLayout` para `StatefulWidget`, o controller deve ser descartado em `dispose()`;
  - o layout responsivo atual deve ser preservado.
- O worktree já possui alterações pré-existentes em arquivos de layout, widgets, testes e contrato da `PedidoPage`; a execução deve preservar essas mudanças.

## Contratos de tela
- Contrato existente que deve ser lido antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Contratos que precisam ser criados:
  - nenhum, porque a tarefa não cria nova Page/View/Tela.
- Contratos que precisam ser atualizados:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`, porque a tarefa altera comportamento visível da `PedidoPage`, formulário de recibo, ações do recibo, prévia do PDF e rolagem.

## Estratégia
- Dividir a tarefa em slices independentes e sequenciais:
  1. criar/aplicar formatter monetário único;
  2. tratar remoção do último item acidental no salvamento;
  3. adicionar autocomplete/combobox de cliente no formulário;
  4. reorganizar ações de imprimir/compartilhar para a prévia de PDF;
  5. corrigir o `Scrollbar` e executar validação final ampla.
- Cada slice deve atualizar testes específicos e o contrato da `PedidoPage` quando alterar comportamento visual ou público.

## Decisão sobre slices
- Haverá slices.
- Justificativa:
  - a tarefa altera múltiplas responsabilidades: input formatter, ViewModel, UI, fluxo de PDF, rolagem e testes;
  - envolve estado reativo, pesquisa em repository, dialogs e serviços de plataforma;
  - há risco de regressão em fluxo de salvamento, PDF e responsividade;
  - slices pequenos permitem validar cada comportamento antes de avançar.

## Validações recomendadas
- Por slice:
  - `dart format` nos arquivos alterados;
  - testes específicos do slice;
  - `flutter analyze` quando houver alteração em `lib/`.
- Validação final recomendada:
  - `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`;
  - `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`;
  - `flutter test test/features/pedido_page/presentation/widgets/resumo_pedido_test.dart`;
  - `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`;
  - `flutter analyze`.
