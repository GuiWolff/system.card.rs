# Contexto
Você é um desenvolvedor Senior em Dart / Flutter.
Leia a análise desta tarefa antes de executar qualquer alteração.
Esta tarefa foi dividida em 5 slices.

## Análise da tarefa
- `docs/codex/cabecalho/cabecalho-26-05-14-1-analise.md`

## Diretriz arquitetural obrigatória
- Esta tarefa não deve criar nem tratar `ReciboPage` como uma tela/rota própria.
- O app já possui a feature agregadora `pedido_page`.
- A tela principal é `PedidoPage`, localizada em `lib/features/pedido_page/presentation/pages/pedido_page.dart`.
- O recibo deve ser tratado como widget/bloco interno da composição da `PedidoPage`, dentro da feature `pedido_page`.
- O cabeçalho desta tarefa também deve ser implementado como widget da feature `pedido_page` e integrado no slot de cabeçalho da `PedidoPage`.
- Não criar a feature `lib/features/recibo/` para esta tarefa.
- Não criar, exportar ou registrar `ReciboPage`.
- Se algum documento de slice antigo mencionar `ReciboPage`, `recibo_page.dart`, `recibo_page-contrato.md` ou `lib/features/recibo/`, adapte a execução para `PedidoPage`, `pedido_page-contrato.md` e `lib/features/pedido_page/`.

## Objetivo geral
- Implementar, em etapas pequenas, o cabeçalho responsivo da System Card - RS como widget integrado à `PedidoPage`, usando `lib/resources/cabecalho.png` e `lib/resources/tema.jpeg` como referências visuais.
- O cabeçalho deve ser composto por widgets Flutter, conter identidade, contatos e ações, e respeitar as diretrizes do `AGENTS.md`.
- A `PedidoPage` deve continuar sendo a page agregadora da experiência de pedido, reunindo cabeçalho, recibo e resumo em uma composição única.
- O recibo não é uma page nesta tarefa; ele é um bloco/widget da feature `pedido_page`.

## Arquivos principais envolvidos
- Existentes:
  - `AGENTS.md`
  - `pubspec.yaml`
  - `lib/main.dart`
  - `test/widget_test.dart`
  - `lib/resources/cabecalho.png`
  - `lib/resources/tema.jpeg`
  - `lib/features/pedido_page/pedido_page.dart`
  - `lib/features/pedido_page/presentation/pages/pedido_page.dart`
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/pedido_page/presentation/widgets/pedido_page_layout.dart`
  - `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
  - `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
  - `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- Esperados durante a execução, se ainda não existirem:
  - `lib/features/pedido_page/presentation/widgets/cabecalho_app.dart`
  - `lib/features/pedido_page/domain/models/cabecalho_empresa.dart`
  - `test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`
- Permitidos apenas se forem realmente necessários para substituir placeholders internos:
  - `lib/features/pedido_page/presentation/widgets/recibo_formulario.dart`
  - `lib/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart`
  - `lib/features/pedido_page/presentation/widgets/resumo_pedido.dart`

## Contratos de tela
- Contrato relacionado:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- Contratos que cada slice deve criar, atualizar ou revisar:
  - Slice 1: revisar `pedido_page-contrato.md` para registrar que a tarefa é de integração de widget na `PedidoPage`, não criação de nova page.
  - Slice 2: revisar `pedido_page-contrato.md` para manter os dados necessários do cabeçalho alinhados à `PedidoPageViewModel` ou aos modelos da feature.
  - Slice 3: atualizar `pedido_page-contrato.md` com comportamento visual e responsivo do cabeçalho integrado à `PedidoPage`.
  - Slice 4: atualizar `pedido_page-contrato.md` com estados e regras das ações do cabeçalho.
  - Slice 5: revisar `pedido_page-contrato.md` após validações finais.

## Adaptação obrigatória dos slices
- Execute os arquivos de slice listados abaixo, mas aplique esta regra de adaptação antes de qualquer alteração:
  - onde estiver escrito `ReciboPage`, leia `PedidoPage`;
  - onde estiver escrito `lib/features/recibo/`, leia `lib/features/pedido_page/`;
  - onde estiver escrito `recibo_page-contrato.md`, leia `pedido_page-contrato.md`;
  - onde estiver indicado criar uma tela de recibo, substitua por integrar ou manter um widget/bloco de recibo dentro da `PedidoPage`;
  - onde estiver indicado trocar a tela inicial para uma tela de recibo, mantenha o app abrindo a `PedidoPage`.
- A `PedidoPage` deve orquestrar os blocos e repassar estado/callbacks.
- O widget de cabeçalho não deve buscar dados globais nem conhecer detalhes internos do recibo.
- O widget/bloco de recibo, quando existir, deve comunicar alterações por callbacks ou ViewModel da `PedidoPage`.

## Slices da tarefa

### Slice 1/5 - Preparação da integração na PedidoPage
Arquivo: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_1.md`
Resumo esperado: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_1-resumo.md`

Atividades:
1. Confirmar a estrutura atual da feature `pedido_page`.
2. Garantir que `PedidoPage` continua sendo a tela inicial/agregadora.
3. Garantir que os assets necessários estão registrados em `pubspec.yaml`, sem duplicação.
4. Atualizar ou manter testes da `PedidoPage` para validar que a tela real abre.
5. Revisar `pedido_page-contrato.md` registrando que recibo e cabeçalho são widgets/blocos internos da `PedidoPage`.

Validações:
- `flutter analyze`
- `flutter test`

### Slice 2/5 - Dados do cabeçalho na feature pedido_page
Arquivo: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_2.md`
Resumo esperado: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_2-resumo.md`

Atividades:
1. Modelar os dados necessários do cabeçalho dentro da feature `pedido_page`.
2. Criar ou ajustar a `PedidoPageViewModel` para expor identidade, contatos e ações do cabeçalho quando essa for a fonte de estado mais adequada.
3. Adicionar testes para os dados padrão do cabeçalho usando caminhos de teste da feature `pedido_page`.
4. Revisar `pedido_page-contrato.md` com os dados renderizados e as responsabilidades da `PedidoPage`.

Validações:
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`

### Slice 3/5 - Widget visual responsivo integrado
Arquivo: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_3.md`
Resumo esperado: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_3-resumo.md`

Atividades:
1. Criar `CabecalhoApp` como widget composto em `lib/features/pedido_page/presentation/widgets/cabecalho_app.dart`.
2. Implementar layout desktop, tablet e mobile sem renderizar `cabecalho.png` como imagem única.
3. Integrar `CabecalhoApp` ao slot de cabeçalho da `PedidoPage`.
4. Preservar o recibo como widget/bloco da própria `PedidoPage`; não criar `ReciboPage`.
5. Criar testes de widget para conteúdo e ausência de overflow em larguras representativas.
6. Atualizar `pedido_page-contrato.md`.

Validações:
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`

### Slice 4/5 - Ações do cabeçalho
Arquivo: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_4.md`
Resumo esperado: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_4-resumo.md`

Atividades:
1. Conectar os botões "IMPRIMIR", "GERAR PDF" e "MAIS OPÇÕES" a callbacks ou estado da `PedidoPageViewModel`.
2. Implementar estados habilitado, desabilitado e feedback temporário sem criar fluxo completo de PDF/impressão fora do escopo.
3. Testar acionamento dos botões e menu usando a integração com `PedidoPage` quando necessário.
4. Atualizar `pedido_page-contrato.md` com as regras de interação.

Validações:
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/widgets/cabecalho_app_test.dart`
- `flutter test`

### Slice 5/5 - Fechamento responsivo e validação
Arquivo: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_5.md`
Resumo esperado: `docs/codex/cabecalho/cabecalho-26-05-14-1-parte_5-resumo.md`

Atividades:
1. Revisar responsividade, acessibilidade, semântica e consistência visual do cabeçalho dentro da `PedidoPage`.
2. Garantir que testes antigos do template foram substituídos por testes coerentes com a `PedidoPage`.
3. Confirmar que nenhuma `ReciboPage` ou feature `lib/features/recibo/` foi criada para esta tarefa.
4. Rodar validações finais.
5. Atualizar `pedido_page-contrato.md` e o resumo final do fechamento.

Validações:
- `flutter analyze`
- `flutter test`

## Regras gerais
- Executar apenas um slice por vez.
- Nunca executar slices em paralelo.
- Nunca avançar para o próximo slice sem o resumo do slice atual.
- Se um resumo de slice já existir e estiver válido, não repetir esse slice.
- Cada slice deve considerar o estado atualizado do código produzido pelo slice anterior.
- Cada slice que alterar UI deve criar ou atualizar o contrato da `PedidoPage`.
- Preservar alterações existentes no worktree.
- Não fazer commit automaticamente.
- Seguir `AGENTS.md`, mantendo português pt-BR, UTF-8 e arquitetura vertical feature-first.
- Não assumir que arquivos citados em documentos antigos existem no worktree atual. Verificar antes de importar ou depender deles.
- Não renderizar `cabecalho.png` como cabeçalho final inteiro. A imagem deve ser referência visual.
- Não introduzir uma tela ou rota de recibo para esta tarefa.
- Manter recibo, cabeçalho e resumo como partes integradas da feature `pedido_page`.

## Resultado esperado
- Ao final dos 5 slices, o app deve iniciar na `PedidoPage` com cabeçalho responsivo da System Card - RS integrado.
- O cabeçalho deve exibir identidade, contatos e ações de forma acessível, testável e sem overflow.
- O recibo deve permanecer como widget/bloco integrado na composição da `PedidoPage`, não como page independente.
- A implementação deve ter `pedido_page-contrato.md` atualizado e validações registradas nos resumos dos slices.
