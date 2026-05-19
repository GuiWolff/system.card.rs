import 'package:flutter/services.dart';

class MonetarioInputFormatter extends TextInputFormatter {
  const MonetarioInputFormatter();

  static final RegExp _naoDigitos = RegExp(r'\D');

  static int converterParaCentavos(String valor) {
    final digitos = valor.replaceAll(_naoDigitos, '');
    if (digitos.isEmpty) {
      return 0;
    }

    return int.tryParse(digitos) ?? 0;
  }

  static String formatarCentavos(int centavos) {
    final sinal = centavos < 0 ? '-' : '';
    final valorAbsoluto = centavos.abs();
    final reais = valorAbsoluto ~/ 100;
    final centavosRestantes = valorAbsoluto % 100;

    return '$sinal$reais,${centavosRestantes.toString().padLeft(2, '0')}';
  }

  static String formatarTexto(String valor) {
    return formatarCentavos(converterParaCentavos(valor));
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final texto = formatarTexto(newValue.text);

    return TextEditingValue(
      text: texto,
      selection: TextSelection.collapsed(offset: texto.length),
    );
  }
}
