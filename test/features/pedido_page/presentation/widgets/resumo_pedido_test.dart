import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_card_rs/features/pedido_page/pedido_page.dart';

void main() {
  testWidgets('ResumoPedido renderiza textos e valores principais', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ResumoPedido(
            totalPedido: 'R\$ 123,45',
            valorEntrada: 'R\$ 45,00',
            valorAPagarEntrega: 'R\$ 78,45',
            onValorEntradaChanged: (_) {},
          ),
        ),
      ),
    );

    expect(find.text('RESUMO'), findsOneWidget);
    expect(find.text('Total do Pedido:'), findsOneWidget);
    expect(find.text('Valor Entrada:'), findsOneWidget);
    expect(find.text('Valor a pagar na Entrega:'), findsOneWidget);
    expect(find.text('R\$ 123,45'), findsOneWidget);
    expect(find.byKey(const ValueKey('resumo-valor-entrada')), findsOneWidget);
    expect(find.text('R\$ 78,45'), findsOneWidget);
  });

  testWidgets('ResumoPedido envia valor de entrada em centavos', (
    WidgetTester tester,
  ) async {
    var valorRecebido = -1;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ResumoPedido(
            totalPedido: 'R\$ 100,00',
            valorEntrada: 'R\$ 0,00',
            valorAPagarEntrega: 'R\$ 100,00',
            onValorEntradaChanged: (valor) => valorRecebido = valor,
          ),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const ValueKey('resumo-valor-entrada')),
      '25,50',
    );
    await tester.pump();

    expect(valorRecebido, 2550);
  });

  testWidgets('ResumoPedido mantém foco ao atualizar valor de entrada', (
    WidgetTester tester,
  ) async {
    var valorEntrada = 'R\$ 0,00';

    Future<void> pumpResumo() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ResumoPedido(
              totalPedido: 'R\$ 100,00',
              valorEntrada: valorEntrada,
              valorAPagarEntrega: 'R\$ 100,00',
              onValorEntradaChanged: (valor) {
                valorEntrada = 'R\$ 0,0$valor';
              },
            ),
          ),
        ),
      );
    }

    await pumpResumo();

    final campo = find.byKey(const ValueKey('resumo-valor-entrada'));
    await tester.tap(campo);
    await tester.enterText(campo, '1');
    await pumpResumo();

    expect(tester.testTextInput.hasAnyClients, isTrue);
    final editableText = tester.widget<EditableText>(
      find.descendant(of: campo, matching: find.byType(EditableText)),
    );
    expect(editableText.focusNode.hasFocus, isTrue);
  });

  testWidgets('ResumoPedido exibe erro de valor de entrada', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ResumoPedido(
            totalPedido: 'R\$ 30,00',
            valorEntrada: 'R\$ 45,00',
            valorAPagarEntrega: '-R\$ 15,00',
            mensagemValorEntrada:
                'O valor de entrada não pode ultrapassar o total do pedido.',
          ),
        ),
      ),
    );

    expect(
      find.text('O valor de entrada não pode ultrapassar o total do pedido.'),
      findsOneWidget,
    );
  });

  testWidgets('ResumoPedido não gera overflow em larguras representativas', (
    WidgetTester tester,
  ) async {
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    const tamanhos = [
      Size(390, 640),
      Size(768, 640),
      Size(1024, 640),
      Size(1366, 720),
    ];

    for (final tamanho in tamanhos) {
      tester.view.physicalSize = tamanho;
      tester.view.devicePixelRatio = 1;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ResumoPedido(
              totalPedido: 'R\$ 123.456,78',
              valorEntrada: 'R\$ 10.000,00',
              valorAPagarEntrega: 'R\$ 113.456,78',
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    }
  });
}
