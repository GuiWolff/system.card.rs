import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_card_rs/features/pedido_page/pedido_page.dart';

void main() {
  const logoPngBase64 =
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMB/axc3V8AAAAASUVORK5CYII=';

  testWidgets(
    'CabecalhoApp renderiza identidade, contatos e edição integrada',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CabecalhoApp(
              cabecalho: const CabecalhoEmpresa.systemCardRs(),
              onImprimir: () {},
              onGerarPdf: () {},
              onMaisOpcoes: () {},
              onEditarCabecalho: () {},
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
      expect(find.text('Editar cabeçalho'), findsOneWidget);
      expect(find.text('IMPRIMIR'), findsNothing);
      expect(find.text('GERAR PDF'), findsNothing);
      expect(find.text('MAIS OPÇÕES'), findsNothing);
      expect(_findFaIcon(FontAwesomeIcons.instagram), findsOneWidget);
      expect(_findFaIcon(FontAwesomeIcons.whatsapp), findsOneWidget);
      expect(_findIcon(Icons.call_outlined), findsOneWidget);
      expect(_findIcon(Icons.location_on_outlined), findsOneWidget);
      expect(_findIcon(Icons.edit_outlined), findsOneWidget);
      expect(find.byType(FaIcon), findsNWidgets(2));
      expect(find.text('SC'), findsOneWidget);
    },
  );

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
            onEditarCabecalho: () {},
          ),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
    expect(find.text('SC'), findsNothing);
  });

  testWidgets(
    'CabecalhoApp dispara callback de edição recebido por parâmetro',
    (WidgetTester tester) async {
      var edicoes = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CabecalhoApp(
              cabecalho: const CabecalhoEmpresa.systemCardRs(),
              onEditarCabecalho: () => edicoes++,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Editar cabeçalho'));

      expect(edicoes, 1);
    },
  );

  testWidgets('CabecalhoApp respeita edição desabilitada e feedback', (
    WidgetTester tester,
  ) async {
    var edicoes = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CabecalhoApp(
            cabecalho: const CabecalhoEmpresa.systemCardRs(),
            feedback: 'Cabeçalho salvo.',
            onEditarCabecalho: () => edicoes++,
            editarCabecalhoHabilitado: false,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Editar cabeçalho'));
    await tester.pump();

    expect(edicoes, 0);
    expect(find.text('Cabeçalho salvo.'), findsOneWidget);
  });

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
                onEditarCabecalho: () {},
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    }
  });
}

Finder _findFaIcon(FaIconData icon) {
  return find.byWidgetPredicate(
    (widget) => widget is FaIcon && widget.icon == icon.data,
  );
}

Finder _findIcon(IconData icon) {
  return find.byWidgetPredicate(
    (widget) => widget is Icon && widget.icon == icon,
  );
}
