import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_card_rs/features/pedido_page/pedido_page.dart';

void main() {
  const logoPngBase64 =
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMB/axc3V8AAAAASUVORK5CYII=';

  testWidgets('CabecalhoApp renderiza identidade, contatos e ações', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CabecalhoApp(
            cabecalho: const CabecalhoEmpresa.systemCardRs(),
            onImprimir: () {},
            onGerarPdf: () {},
            onMaisOpcoes: () {},
          ),
        ),
      ),
    );

    expect(find.text('SYSTEM CARD - RS'), findsOneWidget);
    expect(find.text('Sistemas de Identificação'), findsOneWidget);
    expect(find.text('@systemcards'), findsOneWidget);
    expect(find.text('51 998020198'), findsOneWidget);
    expect(find.text('51 30551025'), findsOneWidget);
    expect(
      find.text('Rua 20 de Setembro, 528 - Centro - Guaíba - RS'),
      findsOneWidget,
    );
    expect(find.text('IMPRIMIR'), findsOneWidget);
    expect(find.text('GERAR PDF'), findsOneWidget);
    expect(find.text('MAIS OPÇÕES'), findsOneWidget);
    expect(find.text('SC'), findsOneWidget);
  });

  testWidgets('CabecalhoApp renderiza logo base64 quando existir', (
    WidgetTester tester,
  ) async {
    final cabecalho = const CabecalhoEmpresa.systemCardRs().copyWith(
      logoBase64: logoPngBase64,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CabecalhoApp(
            cabecalho: cabecalho,
            onImprimir: () {},
            onGerarPdf: () {},
            onMaisOpcoes: () {},
          ),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
    expect(find.text('SC'), findsNothing);
  });

  testWidgets('CabecalhoApp dispara callbacks recebidos por parâmetro', (
    WidgetTester tester,
  ) async {
    var imprimir = 0;
    var gerarPdf = 0;
    var maisOpcoes = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CabecalhoApp(
            cabecalho: const CabecalhoEmpresa.systemCardRs(),
            onImprimir: () => imprimir++,
            onGerarPdf: () => gerarPdf++,
            onMaisOpcoes: () => maisOpcoes++,
          ),
        ),
      ),
    );

    await tester.tap(find.text('IMPRIMIR'));
    await tester.tap(find.text('GERAR PDF'));
    await tester.tap(find.byKey(const ValueKey('cabecalho-mais-opcoes-menu')));
    await tester.pump();

    expect(imprimir, 1);
    expect(gerarPdf, 1);
    expect(maisOpcoes, 1);
  });

  testWidgets('CabecalhoApp respeita ações desabilitadas e em andamento', (
    WidgetTester tester,
  ) async {
    var imprimir = 0;
    final cabecalho = const CabecalhoEmpresa.systemCardRs().copyWith(
      acoesDisponiveis: const [
        CabecalhoAcao(
          id: CabecalhoAcaoId.imprimir,
          rotulo: 'IMPRIMIR',
          habilitada: false,
        ),
        CabecalhoAcao(
          id: CabecalhoAcaoId.gerarPdf,
          rotulo: 'GERAR PDF',
          emAndamento: true,
        ),
        CabecalhoAcao(id: CabecalhoAcaoId.maisOpcoes, rotulo: 'MAIS OPÇÕES'),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CabecalhoApp(
            cabecalho: cabecalho,
            feedback: 'PDF preparado para integração futura.',
            onImprimir: () => imprimir++,
            onGerarPdf: () {},
            onMaisOpcoes: () {},
          ),
        ),
      ),
    );

    await tester.tap(find.text('IMPRIMIR'));
    await tester.pump();

    expect(imprimir, 0);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('PDF preparado para integração futura.'), findsOneWidget);
  });

  testWidgets(
    'CabecalhoApp abre menu de mais opções e retorna item escolhido',
    (WidgetTester tester) async {
      CabecalhoMenuOpcao? opcaoSelecionada;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CabecalhoApp(
              cabecalho: const CabecalhoEmpresa.systemCardRs(),
              onImprimir: () {},
              onGerarPdf: () {},
              onMaisOpcoes: () {},
              onSelecionarMaisOpcao: (opcao) => opcaoSelecionada = opcao,
            ),
          ),
        ),
      );

      await tester.tap(
        find.byKey(const ValueKey('cabecalho-mais-opcoes-menu')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Salvar recibo'), findsOneWidget);
      expect(find.text('Abrir histórico'), findsOneWidget);
      expect(find.text('Novo recibo'), findsOneWidget);

      await tester.tap(find.text('Novo recibo'));
      await tester.pumpAndSettle();

      expect(opcaoSelecionada, CabecalhoMenuOpcao.novoRecibo);
    },
  );

  testWidgets('CabecalhoApp não gera overflow em larguras representativas', (
    WidgetTester tester,
  ) async {
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
      tester.view.physicalSize = tamanho;
      tester.view.devicePixelRatio = 1;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: CabecalhoApp(
                cabecalho: const CabecalhoEmpresa.systemCardRs(),
                onImprimir: () {},
                onGerarPdf: () {},
                onMaisOpcoes: () {},
                onSelecionarMaisOpcao: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    }
  });
}
