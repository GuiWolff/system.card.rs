import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_card_rs/features/pedido_page/data/repositories/cabecalho_preferencias_repository.dart';
import 'package:system_card_rs/features/pedido_page/pedido_page.dart';
import 'package:system_card_rs/features/pedido_page/presentation/widgets/pedido_page_layout.dart';

void main() {
  const logoPngBase64 =
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMB/axc3V8AAAAASUVORK5CYII=';

  testWidgets('PedidoPage renderiza bloco inicial de recibo integrado', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: PedidoPage()));

    expect(find.byType(PedidoPage), findsOneWidget);
    expect(find.text('Pedido'), findsOneWidget);
    expect(find.text('SYSTEM CARD - RS'), findsWidgets);
    expect(find.text('Sistemas de Identificação'), findsWidgets);
    expect(find.text('@systemcards'), findsWidgets);
    expect(find.text('Editar cabeçalho'), findsOneWidget);
    expect(find.text('IMPRIMIR'), findsNothing);
    expect(find.text('GERAR PDF'), findsNothing);
    expect(find.text('MAIS OPÇÕES'), findsNothing);
    expect(
      find.text(
        'Bloco inicial real de recibo integrado à composição do pedido.',
      ),
      findsNothing,
    );
    expect(find.text('Recibo'), findsOneWidget);
    expect(find.text('Dados do Recibo'), findsOneWidget);
    expect(find.text('Produtos / Serviços'), findsOneWidget);
    expect(find.text('Adicionar item'), findsOneWidget);
    expect(find.text('RESUMO'), findsOneWidget);
    expect(find.text('Total do Pedido:'), findsOneWidget);
    expect(find.text('Valor Entrada:'), findsOneWidget);
    expect(find.text('Valor a pagar na Entrega:'), findsWidgets);
    expect(find.text('R\$ 0,00'), findsWidgets);
  });

  testWidgets('PedidoPage exibe número automático para recibo novo', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel(
      reciboRepository: _ReciboRepositoryFake(),
    );
    addTearDown(viewModel.dispose);

    await tester.pumpWidget(
      MaterialApp(home: PedidoPage(viewModel: viewModel)),
    );
    await tester.pumpAndSettle();

    expect(viewModel.reciboEmEdicao.numero, '0001');
    expect(
      find.byKey(const ValueKey('recibo-formulario-numero')),
      findsOneWidget,
    );
    expect(find.text('Gerado automaticamente pelo sistema'), findsOneWidget);
  });

  testWidgets('PedidoPage exibe resumo a partir da ViewModel compartilhada', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel(
      totalPedidoCentavos: 12345,
      valorEntradaCentavos: 4500,
    );
    addTearDown(viewModel.dispose);

    await tester.pumpWidget(
      MaterialApp(home: PedidoPage(viewModel: viewModel)),
    );

    expect(find.text('R\$ 123,45'), findsOneWidget);
    expect(find.byKey(const ValueKey('resumo-valor-entrada')), findsOneWidget);
    expect(find.text('R\$ 78,45'), findsWidgets);

    viewModel.atualizarDadosDoRecibo(
      totalPedidoCentavos: 20000,
      valorEntradaCentavos: 7500,
    );
    await tester.pumpAndSettle();

    expect(find.text('R\$ 200,00'), findsOneWidget);
    expect(find.byKey(const ValueKey('resumo-valor-entrada')), findsOneWidget);
    expect(find.text('R\$ 125,00'), findsWidgets);
  });

  testWidgets('PedidoPage mantém edição do recibo integrada ao resumo', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);

    await tester.pumpWidget(
      MaterialApp(home: PedidoPage(viewModel: viewModel)),
    );

    final botaoAdicionar = find.text('Adicionar item');
    await tester.ensureVisible(botaoAdicionar);
    await tester.pumpAndSettle();
    await tester.tap(botaoAdicionar);
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('produto-quantidade-0')),
      '2',
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('produto-descricao-0')),
      'Crachá PVC',
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('produto-valor-unitario-0')),
      '15,00',
    );
    await tester.pumpAndSettle();

    expect(viewModel.totalPedidoCentavos, 3000);
    expect(find.text('R\$ 30,00'), findsWidgets);
  });

  testWidgets('PedidoPage não cria nova linha com valor unitário zero', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);

    await tester.pumpWidget(
      MaterialApp(home: PedidoPage(viewModel: viewModel)),
    );

    final botaoAdicionar = find.text('Adicionar item');
    await tester.ensureVisible(botaoAdicionar);
    await tester.pumpAndSettle();
    await tester.tap(botaoAdicionar);
    await tester.pumpAndSettle();
    await tester.tap(botaoAdicionar);
    await tester.pumpAndSettle();

    expect(viewModel.itens, hasLength(1));
    expect(
      find.text(
        'Informe um valor unitário maior que zero antes de adicionar outro item.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('PedidoPage imprime o mesmo PDF pelo recibo', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);
    _preencherReciboParaPdf(viewModel);
    final pdfBytes = Uint8List.fromList([37, 80, 68, 70]);
    final pdfService = _ReciboPdfServiceFake(pdfBytes);
    final impressaoService = _ReciboImpressaoServiceFake();

    await tester.pumpWidget(
      MaterialApp(
        home: PedidoPage(
          viewModel: viewModel,
          reciboPdfService: pdfService,
          reciboImpressaoService: impressaoService,
        ),
      ),
    );

    final botaoImprimir = find.widgetWithText(OutlinedButton, 'Imprimir');
    await tester.ensureVisible(botaoImprimir);
    await tester.pumpAndSettle();
    await tester.tap(botaoImprimir);
    await tester.pumpAndSettle();

    expect(pdfService.chamadas, 1);
    expect(impressaoService.pdfBytes, same(pdfBytes));
    expect(impressaoService.nomeArquivo, 'recibo-0042.pdf');
    expect(viewModel.imprimindoPdf, isFalse);
    expect(viewModel.ultimaAcaoRecibo, 'impressao-concluida');
    expect(find.text('Recibo enviado para impressão.'), findsOneWidget);
  });

  testWidgets('PedidoPage expõe erro quando a impressão falha', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);
    _preencherReciboParaPdf(viewModel);
    final pdfService = _ReciboPdfServiceFake(Uint8List.fromList([1, 2, 3]));
    final impressaoService = _ReciboImpressaoServiceFake(falhar: true);

    await tester.pumpWidget(
      MaterialApp(
        home: PedidoPage(
          viewModel: viewModel,
          reciboPdfService: pdfService,
          reciboImpressaoService: impressaoService,
        ),
      ),
    );

    final botaoImprimir = find.widgetWithText(OutlinedButton, 'Imprimir');
    await tester.ensureVisible(botaoImprimir);
    await tester.pumpAndSettle();
    await tester.tap(botaoImprimir);
    await tester.pumpAndSettle();

    expect(viewModel.imprimindoPdf, isFalse);
    expect(viewModel.ultimaAcaoRecibo, isNull);
    expect(
      viewModel.erro,
      'Não foi possível imprimir o recibo: Falha simulada na impressão.',
    );
    expect(
      find.text(
        'Não foi possível imprimir o recibo: Falha simulada na impressão.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('PedidoPage abre popup de compartilhamento do PDF', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);
    _preencherReciboParaPdf(viewModel);

    await tester.pumpWidget(
      MaterialApp(home: PedidoPage(viewModel: viewModel)),
    );

    final botaoCompartilhar = find.widgetWithText(
      OutlinedButton,
      'Compartilhar',
    );
    await tester.ensureVisible(botaoCompartilhar);
    await tester.pumpAndSettle();
    await tester.tap(botaoCompartilhar);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Compartilhar recibo'), findsOneWidget);
    expect(find.text('E-mail'), findsOneWidget);
    expect(find.text('WhatsApp'), findsOneWidget);
    expect(find.text('Salvar arquivo'), findsOneWidget);
    expect(_findFaIcon(FontAwesomeIcons.shareNodes), findsWidgets);
    expect(_findFaIcon(FontAwesomeIcons.envelope), findsWidgets);
    expect(_findFaIcon(FontAwesomeIcons.whatsapp), findsWidgets);
    expect(_findFaIcon(FontAwesomeIcons.fileArrowDown), findsWidgets);
  });

  testWidgets('PedidoPage compartilha PDF por e-mail com serviço fake', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);
    _preencherReciboParaPdf(viewModel);
    viewModel.selecionarCliente(
      Cliente(
        nome: 'Cliente PDF',
        telefone: '51999990000',
        email: 'cliente@exemplo.com',
      ),
    );
    final pdfBytes = Uint8List.fromList([37, 80, 68, 70, 45, 49]);
    final pdfService = _ReciboPdfServiceFake(pdfBytes);
    final compartilhamentoService = _ReciboCompartilhamentoServiceFake();

    await tester.pumpWidget(
      MaterialApp(
        home: PedidoPage(
          viewModel: viewModel,
          reciboPdfService: pdfService,
          reciboCompartilhamentoService: compartilhamentoService,
        ),
      ),
    );

    final botaoCompartilhar = find.widgetWithText(
      OutlinedButton,
      'Compartilhar',
    );
    await tester.ensureVisible(botaoCompartilhar);
    await tester.pumpAndSettle();
    await tester.tap(botaoCompartilhar);
    await tester.pumpAndSettle();
    await tester.tap(find.text('E-mail'));
    await tester.pumpAndSettle();

    expect(pdfService.chamadas, 1);
    expect(compartilhamentoService.destino, 'email');
    expect(compartilhamentoService.destinatarioEmail, 'cliente@exemplo.com');
    expect(compartilhamentoService.pdfBytes, same(pdfBytes));
    expect(compartilhamentoService.nomeArquivo, 'recibo-0042.pdf');
    expect(viewModel.compartilhandoPdf, isFalse);
    expect(viewModel.ultimaAcaoRecibo, 'pdf-compartilhado');
    expect(
      find.text(
        'Compartilhamento por e-mail aberto pela folha do sistema. '
        'Destinatário sugerido: cliente@exemplo.com.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('PedidoPage compartilha PDF por WhatsApp com serviço fake', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);
    _preencherReciboParaPdf(viewModel);
    final pdfBytes = Uint8List.fromList([37, 80, 68, 70, 45, 50]);
    final pdfService = _ReciboPdfServiceFake(pdfBytes);
    final compartilhamentoService = _ReciboCompartilhamentoServiceFake(
      resultado: const ReciboCompartilhamentoResultado(
        status: ReciboCompartilhamentoStatus.concluido,
        mensagem: 'Recibo enviado para compartilhamento por WhatsApp.',
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: PedidoPage(
          viewModel: viewModel,
          reciboPdfService: pdfService,
          reciboCompartilhamentoService: compartilhamentoService,
        ),
      ),
    );

    final botaoCompartilhar = find.widgetWithText(
      OutlinedButton,
      'Compartilhar',
    );
    await tester.ensureVisible(botaoCompartilhar);
    await tester.pumpAndSettle();
    await tester.tap(botaoCompartilhar);
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const ValueKey('recibo-compartilhar-whatsapp')),
    );
    await tester.pumpAndSettle();

    expect(pdfService.chamadas, 1);
    expect(compartilhamentoService.destino, 'whatsapp');
    expect(compartilhamentoService.destinatarioEmail, isNull);
    expect(compartilhamentoService.pdfBytes, same(pdfBytes));
    expect(compartilhamentoService.nomeArquivo, 'recibo-0042.pdf');
    expect(viewModel.compartilhandoPdf, isFalse);
    expect(viewModel.ultimaAcaoRecibo, 'pdf-compartilhado');
    expect(
      find.text('Recibo enviado para compartilhamento por WhatsApp.'),
      findsOneWidget,
    );
  });

  testWidgets('PedidoPage salva PDF e trata cancelamento do seletor', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);
    _preencherReciboParaPdf(viewModel);
    final pdfService = _ReciboPdfServiceFake(Uint8List.fromList([1, 2, 3]));
    final compartilhamentoService = _ReciboCompartilhamentoServiceFake(
      resultado: const ReciboCompartilhamentoResultado(
        status: ReciboCompartilhamentoStatus.cancelado,
        mensagem: 'Salvamento cancelado.',
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: PedidoPage(
          viewModel: viewModel,
          reciboPdfService: pdfService,
          reciboCompartilhamentoService: compartilhamentoService,
        ),
      ),
    );

    final botaoCompartilhar = find.widgetWithText(
      OutlinedButton,
      'Compartilhar',
    );
    await tester.ensureVisible(botaoCompartilhar);
    await tester.pumpAndSettle();
    await tester.tap(botaoCompartilhar);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Salvar arquivo'));
    await tester.pumpAndSettle();

    expect(compartilhamentoService.destino, 'salvar');
    expect(viewModel.compartilhandoPdf, isFalse);
    expect(viewModel.ultimaAcaoRecibo, 'compartilhamento-cancelado');
    expect(find.text('Compartilhamento cancelado.'), findsOneWidget);
  });

  testWidgets('PedidoPage abre AlertDialog de PDF pelo recibo', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);
    _preencherReciboParaPdf(viewModel);

    await tester.pumpWidget(
      MaterialApp(
        home: PedidoPage(
          viewModel: viewModel,
          reciboPdfPreviewBuilder: _previewPdfTeste,
        ),
      ),
    );

    final botaoGerarPdf = find.widgetWithText(OutlinedButton, 'Gerar PDF');
    await tester.ensureVisible(botaoGerarPdf);
    await tester.pumpAndSettle();
    await tester.tap(botaoGerarPdf);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Prévia do PDF'), findsOneWidget);
    expect(find.textContaining('recibo-0042.pdf'), findsOneWidget);
    expect(_findFaIcon(FontAwesomeIcons.filePdf), findsWidgets);
    expect(viewModel.ultimaAcaoRecibo, 'pdf-gerado');
    expect(viewModel.gerandoPdf, isFalse);
  });

  testWidgets('PedidoPage não abre PDF quando recibo é inválido', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: PedidoPage(
          viewModel: viewModel,
          reciboPdfPreviewBuilder: _previewPdfTeste,
        ),
      ),
    );

    final botaoGerarPdf = find.widgetWithText(OutlinedButton, 'Gerar PDF');
    await tester.ensureVisible(botaoGerarPdf);
    await tester.pumpAndSettle();
    await tester.tap(botaoGerarPdf);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    expect(viewModel.erro, 'O número do recibo é obrigatório.');
  });

  testWidgets('PedidoPage abre popup e compartilha PDF por e-mail', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);
    _preencherReciboParaPdf(viewModel);
    final pdfBytes = Uint8List.fromList([37, 80, 68, 70]);
    final pdfService = _ReciboPdfServiceFake(pdfBytes);
    final compartilhamentoService = _ReciboCompartilhamentoServiceFake();

    await tester.pumpWidget(
      MaterialApp(
        home: PedidoPage(
          viewModel: viewModel,
          reciboPdfService: pdfService,
          reciboCompartilhamentoService: compartilhamentoService,
        ),
      ),
    );

    final botaoCompartilhar = find.widgetWithText(
      OutlinedButton,
      'Compartilhar',
    );
    await tester.ensureVisible(botaoCompartilhar);
    await tester.pumpAndSettle();
    await tester.tap(botaoCompartilhar);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Compartilhar recibo'), findsOneWidget);
    expect(find.text('E-mail'), findsOneWidget);
    expect(find.text('WhatsApp'), findsOneWidget);
    expect(find.text('Salvar arquivo'), findsOneWidget);
    expect(_findFaIcon(FontAwesomeIcons.shareNodes), findsWidgets);

    await tester.tap(find.text('E-mail'));
    await tester.pumpAndSettle();

    expect(pdfService.chamadas, 1);
    expect(compartilhamentoService.destino, 'email');
    expect(compartilhamentoService.pdfBytes, same(pdfBytes));
    expect(compartilhamentoService.nomeArquivo, 'recibo-0042.pdf');
    expect(viewModel.compartilhandoPdf, isFalse);
    expect(viewModel.ultimaAcaoRecibo, 'pdf-compartilhado');
    expect(
      find.text('Compartilhamento por e-mail aberto pela folha do sistema.'),
      findsOneWidget,
    );
  });

  testWidgets('PedidoPage salva PDF pelo popup de compartilhamento', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);
    _preencherReciboParaPdf(viewModel);
    final pdfBytes = Uint8List.fromList([37, 80, 68, 70, 45]);
    final pdfService = _ReciboPdfServiceFake(pdfBytes);
    final compartilhamentoService = _ReciboCompartilhamentoServiceFake();

    await tester.pumpWidget(
      MaterialApp(
        home: PedidoPage(
          viewModel: viewModel,
          reciboPdfService: pdfService,
          reciboCompartilhamentoService: compartilhamentoService,
        ),
      ),
    );

    final botaoCompartilhar = find.widgetWithText(
      OutlinedButton,
      'Compartilhar',
    );
    await tester.ensureVisible(botaoCompartilhar);
    await tester.pumpAndSettle();
    await tester.tap(botaoCompartilhar);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Salvar arquivo'));
    await tester.pumpAndSettle();

    expect(pdfService.chamadas, 1);
    expect(compartilhamentoService.destino, 'salvar');
    expect(compartilhamentoService.pdfBytes, same(pdfBytes));
    expect(compartilhamentoService.nomeArquivo, 'recibo-0042.pdf');
    expect(viewModel.ultimaAcaoRecibo, 'pdf-salvo');
    expect(find.text('PDF salvo.'), findsOneWidget);
  });

  testWidgets('PedidoPage trata cancelamento do popup de compartilhamento', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);
    _preencherReciboParaPdf(viewModel);
    final pdfService = _ReciboPdfServiceFake(Uint8List.fromList([1, 2, 3]));

    await tester.pumpWidget(
      MaterialApp(
        home: PedidoPage(viewModel: viewModel, reciboPdfService: pdfService),
      ),
    );

    final botaoCompartilhar = find.widgetWithText(
      OutlinedButton,
      'Compartilhar',
    );
    await tester.ensureVisible(botaoCompartilhar);
    await tester.pumpAndSettle();
    await tester.tap(botaoCompartilhar);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();

    expect(pdfService.chamadas, 0);
    expect(viewModel.ultimaAcaoRecibo, 'compartilhamento-cancelado');
    expect(find.text('Compartilhamento cancelado.'), findsOneWidget);
  });

  testWidgets('PedidoPage edita e salva dados do cabeçalho pelo dialog', (
    WidgetTester tester,
  ) async {
    final repository = _CabecalhoRepositoryFake();
    final viewModel = PedidoPageViewModel(cabecalhoRepository: repository);
    addTearDown(viewModel.dispose);

    await tester.pumpWidget(
      MaterialApp(home: PedidoPage(viewModel: viewModel)),
    );

    await tester.tap(
      find.byKey(const ValueKey('pedido-page-editar-cabecalho')),
    );
    await tester.pumpAndSettle();

    expect(_findFaIcon(FontAwesomeIcons.idBadge), findsWidgets);
    expect(_findFaIcon(FontAwesomeIcons.floppyDisk), findsWidgets);

    await tester.enterText(
      find.byKey(const ValueKey('cabecalho-editor-nome')),
      'Empresa Editada',
    );
    await tester.enterText(
      find.byKey(const ValueKey('cabecalho-editor-subtitulo')),
      'Novo subtítulo',
    );
    await tester.enterText(
      find.byKey(const ValueKey('cabecalho-editor-instagram')),
      '@empresaeditada',
    );
    await tester.enterText(
      find.byKey(const ValueKey('cabecalho-editor-whatsapp')),
      '51 99999-0000',
    );
    await tester.enterText(
      find.byKey(const ValueKey('cabecalho-editor-telefone')),
      '51 3333-2222',
    );
    await tester.enterText(
      find.byKey(const ValueKey('cabecalho-editor-endereco')),
      'Rua Atualizada, 100',
    );
    await tester.tap(find.byKey(const ValueKey('cabecalho-editor-salvar')));
    await tester.pumpAndSettle();

    expect(viewModel.cabecalhoEmpresa.nomeEmpresa, 'Empresa Editada');
    expect(repository.cabecalhoSalvo?.instagram, '@empresaeditada');
    expect(find.text('Empresa Editada'), findsOneWidget);
    expect(find.text('Rua Atualizada, 100'), findsOneWidget);
  });

  testWidgets('PedidoPage remove logo e preserva fallback do cabeçalho', (
    WidgetTester tester,
  ) async {
    final repository = _CabecalhoRepositoryFake(
      cabecalho: const CabecalhoEmpresa.systemCardRs().copyWith(
        logoBase64: logoPngBase64,
      ),
    );
    final viewModel = PedidoPageViewModel(cabecalhoRepository: repository);
    addTearDown(viewModel.dispose);
    await viewModel.carregarCabecalho();

    await tester.pumpWidget(
      MaterialApp(home: PedidoPage(viewModel: viewModel)),
    );

    expect(find.byType(Image), findsWidgets);

    await tester.tap(
      find.byKey(const ValueKey('pedido-page-editar-cabecalho')),
    );
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const ValueKey('cabecalho-editor-remover-logo')),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();

    expect(viewModel.cabecalhoEmpresa.logoBase64, isNull);
    expect(repository.cabecalhoSalvo?.logoBase64, isNull);
    expect(find.text('SC'), findsWidgets);
  });

  testWidgets('PedidoPage abre editor do cabeçalho em largura estreita', (
    WidgetTester tester,
  ) async {
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    tester.view.physicalSize = const Size(390, 700);
    tester.view.devicePixelRatio = 1;

    final viewModel = PedidoPageViewModel(
      cabecalhoRepository: _CabecalhoRepositoryFake(),
    );
    addTearDown(viewModel.dispose);

    await tester.pumpWidget(
      MaterialApp(home: PedidoPage(viewModel: viewModel)),
    );

    await tester.tap(
      find.byKey(const ValueKey('pedido-page-editar-cabecalho')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Editar cabeçalho'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('PedidoPage salva, lista e carrega recibo pelo histórico', (
    WidgetTester tester,
  ) async {
    final repository = _ReciboRepositoryFake();
    final viewModel = PedidoPageViewModel(reciboRepository: repository);
    addTearDown(viewModel.dispose);

    viewModel.atualizarNumero('0008');
    viewModel.atualizarCliente('Carla Souza');
    viewModel.atualizarTelefone('51988887777');
    viewModel.adicionarItem(
      const ItemRecibo(
        quantidade: 2,
        descricao: 'Cartão PVC',
        valorUnitarioCentavos: 2500,
      ),
    );
    viewModel.atualizarValorEntradaCentavos(1000);

    await tester.pumpWidget(
      MaterialApp(home: PedidoPage(viewModel: viewModel)),
    );

    final botaoSalvar = find.text('Salvar');
    await tester.ensureVisible(botaoSalvar);
    await tester.pumpAndSettle();
    await tester.tap(botaoSalvar);
    await tester.pumpAndSettle();

    expect(viewModel.reciboAtualSalvo, isTrue);
    expect(repository.salvos.single.numero, '0008');
    expect(find.text('Recibo salvo.'), findsOneWidget);

    viewModel.atualizarCliente('Rascunho local');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Histórico'));
    await tester.pumpAndSettle();

    expect(find.text('Histórico de recibos'), findsOneWidget);
    expect(find.text('Recibo 0008'), findsOneWidget);
    expect(find.text('Carla Souza'), findsOneWidget);
    expect(_findFaIcon(FontAwesomeIcons.clockRotateLeft), findsWidgets);
    expect(_findFaIcon(FontAwesomeIcons.fileArrowUp), findsWidgets);
    expect(_findFaIcon(FontAwesomeIcons.copy), findsWidgets);
    expect(_findFaIcon(FontAwesomeIcons.trashCan), findsWidgets);

    await tester.tap(find.text('Carregar'));
    await tester.pumpAndSettle();

    expect(viewModel.reciboEmEdicao.cliente, 'Carla Souza');
    expect(viewModel.totalPedidoCentavos, 5000);
    expect(find.text('R\$ 40,00'), findsWidgets);
  });

  testWidgets(
    'PedidoPage carrega histórico somente leitura e duplica como editável',
    (WidgetTester tester) async {
      final repository = _ReciboRepositoryFake();
      final salvo = await repository.salvar(
        Recibo(
          numero: '0900',
          cliente: 'Cliente Histórico',
          telefone: '51999999999',
          dataRecebimento: DateTime(2026, 5, 15),
          dataEntrega: DateTime(2026, 5, 20),
          valorEntradaCentavos: 500,
          itens: const [
            ItemRecibo(
              quantidade: 2,
              descricao: 'Crachá PVC',
              valorUnitarioCentavos: 1500,
            ),
          ],
        ),
      );
      final viewModel = PedidoPageViewModel(reciboRepository: repository);
      addTearDown(viewModel.dispose);

      await tester.pumpWidget(
        MaterialApp(home: PedidoPage(viewModel: viewModel)),
      );

      final botaoHistorico = find.widgetWithText(OutlinedButton, 'Histórico');
      await tester.ensureVisible(botaoHistorico);
      await tester.pumpAndSettle();
      await tester.tap(botaoHistorico);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(OutlinedButton, 'Carregar'));
      await tester.pumpAndSettle();

      expect(viewModel.reciboEmEdicao.id, salvo.id);
      expect(viewModel.reciboSomenteLeitura, isTrue);
      expect(
        tester
            .widget<TextFormField>(
              find.byKey(const ValueKey('recibo-formulario-cliente')),
            )
            .enabled,
        isFalse,
      );
      expect(find.byKey(const ValueKey('resumo-valor-entrada')), findsNothing);

      await tester.ensureVisible(botaoHistorico);
      await tester.pumpAndSettle();
      await tester.tap(botaoHistorico);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(OutlinedButton, 'Duplicar'));
      await tester.pumpAndSettle();

      expect(viewModel.reciboSomenteLeitura, isFalse);
      expect(viewModel.reciboEmEdicao.id, isNull);
      expect(
        tester
            .widget<TextFormField>(
              find.byKey(const ValueKey('recibo-formulario-cliente')),
            )
            .enabled,
        isTrue,
      );
      expect(
        find.byKey(const ValueKey('resumo-valor-entrada')),
        findsOneWidget,
      );
    },
  );

  testWidgets('PedidoPageLayout mantém ordem visual dos blocos', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PedidoPageLayout(
            cabecalho: _BlocoTeste(texto: 'Cabeçalho'),
            recibo: _BlocoTeste(texto: 'Recibo'),
            resumo: _BlocoTeste(texto: 'Resumo'),
          ),
        ),
      ),
    );

    final cabecalhoTop = tester.getTopLeft(find.text('Cabeçalho')).dy;
    final reciboTop = tester.getTopLeft(find.text('Recibo')).dy;
    final resumoTop = tester.getTopLeft(find.text('Resumo')).dy;

    expect(cabecalhoTop, lessThan(reciboTop));
    expect(reciboTop, lessThan(resumoTop));
  });

  testWidgets(
    'PedidoPageLayout não gera overflow em larguras representativas',
    (WidgetTester tester) async {
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      const tamanhos = [
        Size(390, 700),
        Size(768, 700),
        Size(1024, 700),
        Size(1366, 768),
      ];

      for (final tamanho in tamanhos) {
        await _pumpPedidoPageEmTamanho(tester, tamanho);
        expect(tester.takeException(), isNull);
      }
    },
  );
}

Future<void> _pumpPedidoPageEmTamanho(WidgetTester tester, Size tamanho) async {
  tester.view.physicalSize = tamanho;
  tester.view.devicePixelRatio = 1;

  await tester.pumpWidget(const MaterialApp(home: PedidoPage()));
}

void _preencherReciboParaPdf(PedidoPageViewModel viewModel) {
  viewModel.atualizarNumero('0042');
  viewModel.atualizarCliente('Cliente PDF');
  viewModel.atualizarTelefone('51999990000');
  viewModel.adicionarItem(
    const ItemRecibo(
      quantidade: 1,
      descricao: 'Crachá PVC',
      valorUnitarioCentavos: 2500,
    ),
  );
}

Widget _previewPdfTeste(
  BuildContext context,
  Uint8List pdfBytes,
  String nomeArquivo,
) {
  return Center(
    child: Text('Prévia de teste: ${pdfBytes.length} bytes - $nomeArquivo'),
  );
}

class _ReciboPdfServiceFake extends ReciboPdfService {
  _ReciboPdfServiceFake(this.bytes);

  final Uint8List bytes;
  int chamadas = 0;

  @override
  Future<Uint8List> gerarPdfA4({
    required Recibo recibo,
    required CabecalhoEmpresa cabecalho,
  }) async {
    chamadas++;
    return bytes;
  }
}

class _ReciboImpressaoServiceFake extends ReciboImpressaoService {
  _ReciboImpressaoServiceFake({this.falhar = false});

  final bool falhar;
  Uint8List? pdfBytes;
  String? nomeArquivo;

  @override
  Future<bool> imprimirPdf({
    required Uint8List pdfBytes,
    required String nomeArquivo,
  }) async {
    if (falhar) {
      throw StateError('Falha simulada na impressão.');
    }

    this.pdfBytes = pdfBytes;
    this.nomeArquivo = nomeArquivo;
    return true;
  }
}

class _ReciboCompartilhamentoServiceFake extends ReciboCompartilhamentoService {
  _ReciboCompartilhamentoServiceFake({
    this.resultado = const ReciboCompartilhamentoResultado(
      status: ReciboCompartilhamentoStatus.concluido,
      mensagem: 'Compartilhamento por e-mail aberto pela folha do sistema.',
    ),
  });

  final ReciboCompartilhamentoResultado resultado;
  String? destino;
  String? destinatarioEmail;
  Uint8List? pdfBytes;
  String? nomeArquivo;

  @override
  Future<ReciboCompartilhamentoResultado> compartilharPorEmail({
    required Uint8List pdfBytes,
    required String nomeArquivo,
    String? destinatarioEmail,
    Rect? origemCompartilhamento,
  }) async {
    destino = 'email';
    this.destinatarioEmail = destinatarioEmail;
    this.pdfBytes = pdfBytes;
    this.nomeArquivo = nomeArquivo;
    final email = destinatarioEmail?.trim();
    if (email == null || email.isEmpty) {
      return resultado;
    }

    return ReciboCompartilhamentoResultado(
      status: resultado.status,
      mensagem:
          'Compartilhamento por e-mail aberto pela folha do sistema. '
          'Destinatário sugerido: $email.',
      caminho: resultado.caminho,
    );
  }

  @override
  Future<ReciboCompartilhamentoResultado> compartilharPorWhatsapp({
    required Uint8List pdfBytes,
    required String nomeArquivo,
    Rect? origemCompartilhamento,
  }) async {
    destino = 'whatsapp';
    this.pdfBytes = pdfBytes;
    this.nomeArquivo = nomeArquivo;
    return resultado;
  }

  @override
  Future<ReciboCompartilhamentoResultado> salvarArquivo({
    required Uint8List pdfBytes,
    required String nomeArquivo,
  }) async {
    destino = 'salvar';
    this.pdfBytes = pdfBytes;
    this.nomeArquivo = nomeArquivo;
    return resultado;
  }
}

class _BlocoTeste extends StatelessWidget {
  const _BlocoTeste({required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Align(alignment: Alignment.topLeft, child: Text(texto)),
    );
  }
}

class _ReciboRepositoryFake implements ReciboRepository {
  final List<Recibo> salvos = <Recibo>[];
  int _proximoId = 1;

  @override
  Future<String> proximoNumero() async {
    var maiorNumero = 0;
    for (final recibo in salvos) {
      final numero = int.tryParse(recibo.numero);
      if (numero != null && numero > maiorNumero) {
        maiorNumero = numero;
      }
    }

    return (maiorNumero + 1).toString().padLeft(4, '0');
  }

  @override
  Future<Recibo> salvar(Recibo recibo) async {
    final agora = DateTime(2026, 5, 15, 10, _proximoId);
    final numero = recibo.numero.trim().isEmpty
        ? await proximoNumero()
        : recibo.numero;
    final salvo = Recibo(
      id: _proximoId++,
      numero: numero,
      cliente: recibo.cliente,
      telefone: recibo.telefone,
      observacoes: recibo.observacoes,
      dataRecebimento: recibo.dataRecebimento,
      dataEntrega: recibo.dataEntrega,
      valorEntradaCentavos: recibo.valorEntradaCentavos,
      itens: recibo.itens,
      criadoEm: agora,
      atualizadoEm: agora,
    );
    salvos.add(salvo);
    return salvo;
  }

  @override
  Future<Recibo> atualizar(Recibo recibo) async {
    final indice = salvos.indexWhere((salvo) => salvo.id == recibo.id);
    if (indice == -1) {
      throw StateError('Recibo não encontrado.');
    }

    final atualizado = Recibo(
      id: recibo.id,
      numero: recibo.numero,
      cliente: recibo.cliente,
      telefone: recibo.telefone,
      observacoes: recibo.observacoes,
      dataRecebimento: recibo.dataRecebimento,
      dataEntrega: recibo.dataEntrega,
      valorEntradaCentavos: recibo.valorEntradaCentavos,
      itens: recibo.itens,
      criadoEm: salvos[indice].criadoEm,
      atualizadoEm: DateTime(2026, 5, 15, 11, recibo.id!),
    );
    salvos[indice] = atualizado;
    return atualizado;
  }

  @override
  Future<Recibo?> buscarPorId(int id) async {
    for (final recibo in salvos) {
      if (recibo.id == id) {
        return recibo;
      }
    }

    return null;
  }

  @override
  Future<List<Recibo>> listarHistorico() async {
    return List<Recibo>.unmodifiable(salvos);
  }

  @override
  Future<List<Recibo>> pesquisarHistorico(String termo) async {
    final termoNormalizado = termo.toLowerCase();
    return salvos
        .where(
          (recibo) =>
              recibo.numero.toLowerCase().contains(termoNormalizado) ||
              recibo.cliente.toLowerCase().contains(termoNormalizado) ||
              recibo.telefone.toLowerCase().contains(termoNormalizado),
        )
        .toList(growable: false);
  }

  @override
  Future<void> excluir(int id) async {
    salvos.removeWhere((recibo) => recibo.id == id);
  }
}

Finder _findFaIcon(FaIconData icon) {
  return find.byWidgetPredicate(
    (widget) => widget is FaIcon && widget.icon == icon.data,
  );
}

class _CabecalhoRepositoryFake implements CabecalhoPreferenciasRepository {
  _CabecalhoRepositoryFake({
    CabecalhoEmpresa cabecalho = const CabecalhoEmpresa.systemCardRs(),
  }) : _cabecalho = cabecalho;

  CabecalhoEmpresa _cabecalho;
  CabecalhoEmpresa? cabecalhoSalvo;

  @override
  CabecalhoEmpresa carregar() => _cabecalho;

  @override
  Future<void> salvar(CabecalhoEmpresa cabecalho) async {
    _cabecalho = cabecalho;
    cabecalhoSalvo = cabecalho;
  }

  @override
  Future<CabecalhoEmpresa> removerLogo() async {
    _cabecalho = _cabecalho.copyWith(
      removerLogoAssetPath: true,
      removerLogoBase64: true,
    );
    cabecalhoSalvo = _cabecalho;
    return _cabecalho;
  }

  @override
  Future<CabecalhoEmpresa> restaurarPadrao() async {
    _cabecalho = const CabecalhoEmpresa.systemCardRs();
    cabecalhoSalvo = _cabecalho;
    return _cabecalho;
  }
}
