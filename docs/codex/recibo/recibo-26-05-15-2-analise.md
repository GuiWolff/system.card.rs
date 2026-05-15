# Análise da tarefa

## Pedido original
- Gerar PDF do recibo em tamanho A4.
- Ao gerar o PDF, exibir a visualização em um `AlertDialog`.
- Implementar impressão reutilizando a mesma geração de PDF.
- Implementar compartilhamento por e-mail, WhatsApp ou salvamento no Explorer com escolha de caminho.
- Ao compartilhar, abrir um popup com as opções disponíveis.

## Feature correspondente
- Feature real no estado atual do projeto: `lib/features/pedido_page/`.
- A tela impactada é `PedidoPage`, em `lib/features/pedido_page/presentation/pages/pedido_page.dart`.
- O recibo está implementado como bloco interno da `PedidoPage`, por meio de `ReciboPedido`.
- Não criar `ReciboPage`, rota própria, `Scaffold` próprio ou nova estrutura paralela em `lib/features/recibo/`.

## Arquivos relacionados
- `pubspec.yaml`
- `pubspec.lock`
- `lib/features/pedido_page/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page.dart`
- `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
- `lib/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart`
- `lib/features/pedido_page/presentation/widgets/recibo_pedido.dart`
- `lib/features/pedido_page/presentation/widgets/visualizacao_recibo.dart`
- `lib/features/pedido_page/presentation/widgets/cabecalho_app.dart`
- `lib/features/pedido_page/domain/models/recibo.dart`
- `lib/features/pedido_page/domain/models/item_recibo.dart`
- `lib/features/pedido_page/domain/models/resumo_recibo.dart`
- `lib/features/pedido_page/domain/models/cabecalho_empresa.dart`
- `test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- `test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `test/features/pedido_page/presentation/widgets/visualizacao_recibo_test.dart`
- `test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- Possíveis novos arquivos:
  - `lib/features/pedido_page/services/recibo_pdf_service.dart`
  - `lib/features/pedido_page/services/recibo_documento_service.dart`
  - `lib/features/pedido_page/services/recibo_compartilhamento_service.dart`
  - `lib/features/pedido_page/presentation/widgets/recibo_pdf_preview_dialog.dart`
  - `lib/features/pedido_page/presentation/widgets/recibo_compartilhamento_dialog.dart`
  - testes específicos para os novos serviços e widgets.

## Estado atual
- `PedidoPage` é a tela agregadora aberta pelo app.
- `ReciboPedido` renderiza ações de salvar, novo recibo, histórico, clientes, imprimir e gerar PDF.
- As ações de imprimir e gerar PDF apenas chamam `PedidoPageViewModel.prepararImpressao()` e `PedidoPageViewModel.prepararGeracaoPdf()`.
- O estado atual dessas ações é preparatório:
  - `ultimaAcaoRecibo == 'imprimir-preparado'`;
  - `ultimaAcaoRecibo == 'pdf-preparado'`.
- Não existe geração real de PDF.
- Não existe visualização de PDF em `AlertDialog`.
- Não existe impressão real.
- Não existe popup de compartilhamento.
- Não existe salvamento de PDF com escolha de caminho.
- O projeto já possui `file_picker` e `path_provider`.
- O projeto ainda não possui dependências diretas para geração/renderização/impressão de PDF nem compartilhamento de arquivos.
- `VisualizacaoRecibo` renderiza uma prévia Flutter do recibo, mas não gera PDF.
- `VisualizacaoRecibo` ainda usa cabeçalho visual estático; a geração de PDF deve preferir os dados atuais de `CabecalhoEmpresa` vindos da `PedidoPageViewModel`.

## Estado esperado
- A geração de documento deve produzir PDF em tamanho A4 a partir do `Recibo` em edição e do `CabecalhoEmpresa` atual.
- A geração deve ficar em serviço testável da feature, sem `BuildContext` e sem regra pesada dentro do `build`.
- O mesmo serviço/base de geração deve alimentar:
  - visualização do PDF;
  - impressão;
  - compartilhamento;
  - salvamento em arquivo.
- A ação `Gerar PDF` deve abrir um `AlertDialog` com a prévia do PDF.
- A ação `Imprimir` deve chamar impressão real usando o mesmo PDF.
- A ação de compartilhamento deve abrir um popup com opções claras:
  - compartilhar por e-mail;
  - compartilhar por WhatsApp;
  - salvar arquivo escolhendo o caminho.
- Quando a plataforma não permitir direcionar diretamente e-mail ou WhatsApp, o fluxo deve usar o compartilhamento do sistema como fallback e registrar essa limitação no resumo do slice.
- O salvamento no Explorer deve permitir escolha de caminho em desktop, preferencialmente com `file_picker`.
- Web, Desktop e Mobile devem ter fallback explícito, sem uso incondicional de `dart:io` em ambiente Web.
- O fluxo deve preservar `PedidoPageViewModel` sem acesso a `BuildContext`.
- Widgets devem observar estado reativo com `Obx` quando o estado vier da ViewModel.

## Riscos e dependências
- As APIs dos pacotes de PDF, impressão e compartilhamento podem variar por versão; os slices devem conferir a API instalada após adicionar dependências.
- Compartilhamento direcionado especificamente para WhatsApp ou e-mail pode não ser garantido em todas as plataformas.
- `mailto:` não é uma solução confiável para anexar PDF; se usado, precisa de fallback claro.
- `share_plus` ou a API de compartilhamento do pacote de impressão podem abrir a folha de compartilhamento do sistema, sem garantir o aplicativo final escolhido.
- Salvamento com caminho escolhido tem suporte diferente entre Web, Windows, macOS, Linux, Android e iOS.
- Uso de `dart:io` precisa ser isolado ou condicionado para não quebrar Web.
- O PDF precisa preservar acentuação em UTF-8 e layout A4 legível.
- Logo em base64 pode falhar ou ser grande; o PDF deve manter fallback textual quando a logo não puder ser renderizada.
- A prévia em `AlertDialog` precisa ter limites de largura/altura para evitar overflow.
- O documento PDF não deve duplicar regra de cálculo monetário; deve consumir os totais do domínio.
- A ação de gerar/imprimir/compartilhar deve validar o recibo ou, se permitir rascunho, justificar isso no resumo do slice.

## Contratos de tela
- Contratos existentes que devem ser lidos antes da alteração:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`
  - `lib/features/recibo/presentation/pages/recibo_page-contrato.md` apenas como contrato legado de referência.
- Contratos que precisam ser criados:
  - Nenhum contrato novo de Page/View/Tela, porque a tarefa deve continuar usando a `PedidoPage`.
- Contratos que precisam ser atualizados:
  - `lib/features/pedido_page/presentation/pages/pedido_page-contrato.md`.
- Não há criação de `ReciboPage`; portanto o contrato legado de `ReciboPage` não deve conduzir a criação de uma tela nova.

## Estratégia
- Criar primeiro a base de geração de PDF A4 como serviço isolado e testável.
- Integrar a visualização do PDF em `AlertDialog` somente depois da base de geração existir.
- Implementar impressão reutilizando exatamente a mesma geração de bytes do PDF.
- Implementar o popup de compartilhamento/salvamento por último, porque depende do PDF funcional e envolve maior variação entre plataformas.
- Manter cada etapa pequena para permitir validações intermediárias com `flutter analyze` e testes específicos.

## Decisão sobre slices
- Haverá slices.
- Justificativa:
  - a tarefa altera múltiplas responsabilidades: serviço de documento, UI, ViewModel/coordenação, dependências e testes;
  - envolve integração com plugins de plataforma;
  - afeta ações existentes de cabeçalho/recibo;
  - exige compatibilidade Web/Desktop/Mobile;
  - possui risco de regressão no fluxo atual de salvar, histórico, clientes e resumo;
  - precisa de validações intermediárias antes de chegar ao compartilhamento.

## Validações recomendadas
- `flutter pub get`
- `flutter analyze`
- `flutter test test/features/pedido_page/presentation/viewmodels/pedido_page_view_model_test.dart`
- `flutter test test/features/pedido_page/presentation/widgets/recibo_pedido_test.dart`
- `flutter test test/features/pedido_page/presentation/pages/pedido_page_test.dart`
- Testes específicos dos novos serviços de PDF/compartilhamento.
- `flutter test` no fechamento final, se o impacto acumulado for amplo.
