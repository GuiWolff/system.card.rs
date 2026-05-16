import 'package:flutter_test/flutter_test.dart';
import 'package:system_card_rs/main.dart';

void main() {
  testWidgets('MyApp abre a PedidoPage', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Pedido'), findsWidgets);
    expect(find.text('SYSTEM CARD - RS'), findsWidgets);
    expect(find.text('Editar cabeçalho'), findsOneWidget);
    expect(find.text('IMPRIMIR'), findsNothing);
    expect(find.text('Recibo'), findsOneWidget);
    expect(find.text('Dados do Recibo'), findsOneWidget);
    expect(find.text('RESUMO'), findsOneWidget);
    expect(find.text('Total do Pedido:'), findsOneWidget);
  });
}
