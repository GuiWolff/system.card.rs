import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_card_rs/features/pedido_page/presentation/input_formatters/monetario_input_formatter.dart';

void main() {
  const formatter = MonetarioInputFormatter();

  test('formata digitação monetária por centavos', () {
    final casos = <String, String>{
      '2': '0,02',
      '23': '0,23',
      '235': '2,35',
      '2350': '23,50',
      '2,350': '23,50',
      'R\$ 2.350,00': '2350,00',
    };

    for (final caso in casos.entries) {
      final resultado = formatter.formatEditUpdate(
        TextEditingValue.empty,
        TextEditingValue(
          text: caso.key,
          selection: TextSelection.collapsed(offset: caso.key.length),
        ),
      );

      expect(resultado.text, caso.value);
      expect(resultado.selection.baseOffset, caso.value.length);
    }
  });

  test('converte texto monetário formatado para centavos', () {
    expect(MonetarioInputFormatter.converterParaCentavos(''), 0);
    expect(MonetarioInputFormatter.converterParaCentavos('0,02'), 2);
    expect(MonetarioInputFormatter.converterParaCentavos('2,35'), 235);
    expect(MonetarioInputFormatter.converterParaCentavos('R\$ 23,50'), 2350);
  });

  test('formata centavos sem símbolo de moeda', () {
    expect(MonetarioInputFormatter.formatarCentavos(0), '0,00');
    expect(MonetarioInputFormatter.formatarCentavos(235), '2,35');
    expect(MonetarioInputFormatter.formatarCentavos(2350), '23,50');
    expect(MonetarioInputFormatter.formatarCentavos(-15), '-0,15');
  });
}
