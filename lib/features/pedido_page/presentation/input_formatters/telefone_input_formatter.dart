import 'package:flutter/services.dart';

class TelefoneInputFormatter extends TextInputFormatter {
  const TelefoneInputFormatter();

  static const maximoDigitos = 11;

  static String formatar(String telefone) {
    final digitos = telefone.replaceAll(RegExp(r'\D'), '');
    final limitado = digitos.length > maximoDigitos
        ? digitos.substring(0, maximoDigitos)
        : digitos;

    if (limitado.length <= 2) {
      return limitado;
    }

    final ddd = limitado.substring(0, 2);
    final restante = limitado.substring(2);

    if (restante.length <= 4) {
      return '($ddd) $restante';
    }

    if (restante.length <= 8) {
      return '($ddd) ${restante.substring(0, 4)}-${restante.substring(4)}';
    }

    return '($ddd) ${restante.substring(0, 1)} '
        '${restante.substring(1, 5)}-${restante.substring(5)}';
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final texto = formatar(newValue.text);

    return TextEditingValue(
      text: texto,
      selection: TextSelection.collapsed(offset: texto.length),
    );
  }
}
