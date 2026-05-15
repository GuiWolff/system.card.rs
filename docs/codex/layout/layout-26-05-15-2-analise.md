# Análise da tarefa

## Pedido original
- Ajustar o layout da `PedidoPage` e dos widgets do recibo:
  - retirar os botões `Imprimir`, `Gerar PDF` e `MAIS OPÇÕES` do cabeçalho;
  - colocar `Visualização do Recibo` em uma row com `Dados do Recibo`;
  - fazer `Ações do recibo` ocupar toda a largura disponível do widget pai;
  - corrigir o desalinhamento do cabeçalho azul da grid `Produtos / Serviços`;
  - mover o botão `Editar cabeçalho` para dentro do próprio cabeçalho;
  - usar ícones representativos para Instagram, WhatsApp, telefone e endereço, com Instagram e WhatsApp usando ícones de identidade dos apps;
  - modernizar o widget/dialog `Editar cabeçalho`;
  - adicionar campo de e-mail ao cadastro de cliente/usuário e permitir que esse dado participe do fluxo de compartilhamento por e-mail quando aplicável.

## Feature correspondente
- Feature principal: `pedido_page`.
- Caminho provável: `lib/features/pedido_page/`.
- A tela impactada é a `PedidoPage`, que agrega cabeçalho, recibo, clientes, compartilhamento e resumo dentro da mesma feature vertical.

## Arquivos relacionados
- Produção:
  - `lib/features/pedido_page/presentation/pages/pedido_page.dart`
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/pedido_page/presentation/widgets/cabecalho_app.dart`
  - `lib/features/pedido_page/presentation/widgets/cabecalho_editor_dialog.dart`
  - `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
  - `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
  - `lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart`
  - `lib/features/pedido_page/presentation/widgets/visualizacao_recibo.dart`
  - `lib/features/pedido_page/presentation/widgets/clientes_painel.dart`
  - `lib/features/pedido_page/presentation/widgets/recibo_compartilhamento_dialog.dart`
  - `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
  - `lib/features/pedido_page/domain/models/cabecalho_empresa.dart`
  - `lib/features/pedido_page/domain/models/cliente.dart`
  - `lib/features/pedido_page/domain/repositories/cliente_repository.dart`
  - `lib/features/pedido_page/data/dtos/cliente_dto.dart`
  - `lib/features/pedido_page/data/datasources/recibo_database.dart`
  - `lib/features/pedido_page/data/repositories/cliente_repository_sqlite.dart`
  - `lib/features/pedido_page/services/recibo_compartilhamento_service.dart`
  - `lib/features/pedido_page/pedido_page.dart`
  - `pubspec.yaml`, apenas se for necessário adicionar pacote de ícones de marca.
- Testes:
  - `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
  - `test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`
  - `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
  - `test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`
  - `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
  - `test/features/pedido_page/data/datasources/recibo_database_test.dart`
  - `test/features/pedido_page/data/repositories/cliente_repository_sqlite_test.dart`
  - `test/features/pedido_page/services/recibo_compartilhamento_service_test.dart`

## Estado atual
- `PedidoPage` renderiza um botão `Editar cabeçalho` fora do `CabecalhoApp`, acima do card do cabeçalho.
- `CabecalhoApp` renderiza identidade, contatos e ações vindas de `CabecalhoEmpresa.acoesDisponiveis`, incluindo `IMPRIMIR`, `GERAR PDF` e `MAIS OPÇÕES`.
- `CabecalhoEmpresa.systemCardRs()` ainda define ações padrão para imprimir, gerar PDF e mais opções.
- Os contatos do cabeçalho usam `Icons.alternate_email` para Instagram e `Icons.chat_bubble_outline` para WhatsApp; não há pacote de ícones de marca no `pubspec.yaml` atual.
- `CabecalhoEditorDialog` permite editar nome, subtítulo, Instagram, WhatsApp, telefone, endereço e logo, com layout funcional em `AlertDialog`.
- `ReciboPedido` empilha, nesta ordem: ações, formulário `Dados do Recibo`, tabela `Produtos / Serviços` e `Visualização do Recibo`.
- `_ReciboAcoes` usa `DecoratedBox` dentro de `Column(crossAxisAlignment: CrossAxisAlignment.start)`, então o bloco tende a medir apenas o conteúdo em vez de preencher a largura do pai.
- `ProdutosServicosTabela` usa cabeçalho com `Row`, mas as linhas usam `Wrap` com larguras fixas diferentes. A captura anexada mostra o cabeçalho azul desalinhado em relação aos campos das linhas.
- `ClientesPainel` cadastra cliente apenas com nome e telefone.
- `Cliente`, `ClienteDto`, `ClienteRepositorySqlite` e a tabela SQLite `clientes` não possuem e-mail.
- `ReciboCompartilhamentoService` já possui opção de compartilhamento por e-mail, mas usa `share_plus` com folha do sistema e não possui destinatário de e-mail vindo do cadastro.
- `ReciboCompartilhamentoDialog` já exibe as opções `E-mail`, `WhatsApp` e `Salvar arquivo`.

## Estado esperado
- O cabeçalho deve continuar exibindo identidade e contatos, mas sem os botões `Imprimir`, `Gerar PDF` e `MAIS OPÇÕES`.
- O botão `Editar cabeçalho` deve fazer parte do próprio `CabecalhoApp`, mantendo estado desabilitado enquanto o cabeçalho estiver carregando ou salvando.
- O layout do cabeçalho deve preservar responsividade em mobile, tablet e desktop, sem overflow.
- Instagram e WhatsApp devem usar ícones reconhecíveis dos aplicativos. Telefone e endereço devem usar ícones semânticos adequados.
- O `CabecalhoEditorDialog` deve ficar visualmente mais moderno, mantendo as mesmas responsabilidades e sem mover regra de negócio para o widget.
- Em larguras amplas, `Dados do Recibo` e `Visualização do Recibo` devem aparecer lado a lado em uma row responsiva. Em larguras menores, devem empilhar sem overflow.
- `Ações do recibo` deve ocupar a largura disponível do pai.
- A tabela `Produtos / Serviços` deve alinhar cabeçalho e células usando as mesmas larguras, espaçamentos e padding nas versões amplas.
- Em larguras compactas, a tabela deve continuar empilhando campos de forma legível.
- O cadastro de clientes deve aceitar e-mail opcional, persistir esse campo e exibi-lo quando existir.
- O fluxo de compartilhamento por e-mail deve conseguir usar o e-mail cadastrado quando a integração da plataforma permitir. Quando a API abrir apenas a folha de compartilhamento do sistema, a limitação deve ficar registrada no resumo do slice.

## Riscos e dependências
- Remover visualmente ações do cabeçalho pode quebrar testes existentes que esperam `IMPRIMIR`, `GERAR PDF` e `MAIS OPÇÕES` em `CabecalhoApp`.
- Alterar o construtor público de `CabecalhoApp` deve ser feito de forma aditiva, preferindo novos parâmetros opcionais para preservar compatibilidade.
- Não remover enums/classes públicas como `CabecalhoAcaoId`, `CabecalhoMenuOpcao` ou callbacks legados sem necessidade explícita.
- Usar ícones reais de Instagram/WhatsApp pode exigir dependência nova ou assets SVG pequenos. Se adicionar dependência, atualizar `pubspec.yaml` e `pubspec.lock` no slice correspondente e validar compatibilidade Web/Desktop/Mobile.
- A grid de produtos precisa manter edição inline e `ListView.separated`, evitando regressão em input formatters e callbacks.
- Adicionar e-mail a clientes exige migração SQLite incremental. O banco atual está em `ReciboDatabase.version == 2`; a mudança deve elevar a versão e preservar dados existentes.
- `share_plus` pode não permitir definir destinatário obrigatório com anexo em todas as plataformas. O planejamento deve evitar prometer envio direto para um e-mail específico quando a plataforma só oferecer a folha de compartilhamento.
- O worktree já possui alterações em arquivos de produção, testes, contratos e planejamentos. Preservar essas alterações e não reverter nada.

## Contratos de tela
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md`, apenas como referência legada.
- Contratos que precisam ser atualizados:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos que precisam ser criados:
  - Nenhum. A tarefa impacta a `PedidoPage` já existente e widgets internos da mesma composição.
- Este gerador revisou os contratos como insumo de planejamento. O contrato da `PedidoPage` deve ser atualizado incrementalmente nos slices que alterarem UI, pois o arquivo já estava modificado no worktree antes deste planejamento.

## Estratégia
- Fatiar a tarefa para isolar riscos:
  1. Ajustar cabeçalho, botão de edição, ícones e dialog de edição.
  2. Ajustar composição do recibo, largura de ações e alinhamento da tabela.
  3. Adicionar e-mail ao domínio e à persistência de clientes com migração SQLite.
  4. Integrar e-mail na UI de clientes e no fluxo de compartilhamento por e-mail, respeitando limites de plataforma.
- Em cada slice, atualizar os testes diretamente afetados e registrar a mudança no contrato da `PedidoPage`.
- Manter a arquitetura vertical feature-first dentro de `lib/features/pedido_page/`.
- Evitar mover regras de negócio para widgets; usar a `PedidoPageViewModel` para estado e coordenação.

## Decisão sobre slices
- Haverá slices.
- Justificativa:
  - a tarefa altera múltiplas responsabilidades: cabeçalho, dialog, layout de recibo, tabela, domínio, SQLite, ViewModel, UI de clientes e compartilhamento;
  - envolve estado reativo e repository;
  - afeta mais de um widget principal;
  - exige migração incremental de banco;
  - tem risco de regressão visual e funcional;
  - precisa de validações intermediárias para reduzir incerteza.

## Validações recomendadas
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/clientes_painel_test.dart`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `flutter test test/features/pedido_page/data/datasources/recibo_database_test.dart`
- `flutter test test/features/pedido_page/data/repositories/cliente_repository_sqlite_test.dart`
- `flutter test test/features/pedido_page/services/recibo_compartilhamento_service_test.dart`
- `flutter test`, no fechamento, se o impacto acumulado for amplo.
