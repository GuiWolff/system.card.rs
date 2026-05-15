import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_card_rs/features/pedido_page/pedido_page.dart';

void main() {
  testWidgets('VisualizacaoRecibo renderiza dados do recibo e totais', (
    WidgetTester tester,
  ) async {
    final recibo = Recibo(
      numero: '0007',
      cliente: 'João da Silva',
      telefone: '(51) 99999-9999',
      observacoes: 'Retirar no balcão.',
      dataRecebimento: DateTime(2024, 5, 24),
      dataEntrega: DateTime(2024, 5, 31),
      valorEntradaCentavos: 2000,
      itens: const [
        ItemRecibo(
          quantidade: 2,
          descricao: 'Crachá em PVC',
          valorUnitarioCentavos: 1500,
        ),
        ItemRecibo(
          quantidade: 1,
          descricao: 'Cordão Personalizado',
          valorUnitarioCentavos: 1200,
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: VisualizacaoRecibo(recibo: recibo),
          ),
        ),
      ),
    );

    expect(find.text('SYSTEM CARD - RS'), findsOneWidget);
    expect(find.text('Sistemas de Identificação'), findsOneWidget);
    expect(find.text('@systemcards'), findsOneWidget);
    expect(find.text('Recebido:'), findsOneWidget);
    expect(find.text('24/05/2024'), findsOneWidget);
    expect(find.text('Entrega:'), findsOneWidget);
    expect(find.text('31/05/2024'), findsOneWidget);
    expect(find.text('João da Silva'), findsOneWidget);
    expect(find.text('(51) 99999-9999'), findsOneWidget);
    expect(find.text('Retirar no balcão.'), findsOneWidget);
    expect(find.text('Crachá em PVC'), findsOneWidget);
    expect(find.text('Cordão Personalizado'), findsOneWidget);
    expect(find.text('Total do Pedido'), findsOneWidget);
    expect(find.text('42,00'), findsOneWidget);
    expect(find.text('20,00'), findsOneWidget);
    expect(find.text('22,00'), findsOneWidget);
  });

  testWidgets('ReciboPedido integra visualização usando reciboEmEdicao', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ReciboPedido(viewModel: viewModel),
          ),
        ),
      ),
    );

    await tester.enterText(find.byKey(const ValueKey('Cliente-')), 'Ana Lima');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Adicionar item'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('descricao-0-')),
      'Porta Crachá Vertical',
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('valor-unitario-0-0')),
      '8,00',
    );
    await tester.pumpAndSettle();

    expect(find.text('Visualização do Recibo'), findsOneWidget);
    expect(find.text('Ana Lima'), findsWidgets);
    expect(find.text('Porta Crachá Vertical'), findsWidgets);
    expect(find.text('8,00'), findsWidgets);
  });
}
