import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:system_card_rs/features/pedido_page/domain/models/recibo.dart';
import 'package:system_card_rs/features/pedido_page/presentation/input_formatters/telefone_input_formatter.dart';

class ReciboFormulario extends StatelessWidget {
  const ReciboFormulario({
    required this.recibo,
    required this.valorEntradaFormatado,
    required this.onNumeroChanged,
    required this.onDataRecebimentoChanged,
    required this.onDataEntregaChanged,
    required this.onClienteChanged,
    required this.onTelefoneChanged,
    required this.onValorEntradaChanged,
    required this.onObservacoesChanged,
    super.key,
  });

  final Recibo recibo;
  final String valorEntradaFormatado;
  final ValueChanged<String> onNumeroChanged;
  final ValueChanged<DateTime> onDataRecebimentoChanged;
  final ValueChanged<DateTime> onDataEntregaChanged;
  final ValueChanged<String> onClienteChanged;
  final ValueChanged<String> onTelefoneChanged;
  final ValueChanged<int> onValorEntradaChanged;
  final ValueChanged<String> onObservacoesChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dados do Recibo', style: textTheme.titleMedium),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final largura = constraints.maxWidth;
            final usarDuasColunas = largura >= 760;
            final larguraCampo = usarDuasColunas ? (largura - 12) / 2 : largura;

            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _CampoFormulario(
                  largura: larguraCampo,
                  label: 'Número do recibo',
                  valorInicial: recibo.numero,
                  helperText: 'Gerado automaticamente pelo sistema',
                  readOnly: true,
                  onChanged: onNumeroChanged,
                  textInputAction: TextInputAction.next,
                ),
                _CampoFormulario(
                  largura: larguraCampo,
                  label: 'Recebido',
                  valorInicial: _formatarData(recibo.dataRecebimento),
                  hintText: 'dd/mm/aaaa',
                  keyboardType: TextInputType.datetime,
                  onChanged: (valor) {
                    final data = _converterData(valor);
                    if (data != null) {
                      onDataRecebimentoChanged(data);
                    }
                  },
                  textInputAction: TextInputAction.next,
                ),
                _CampoFormulario(
                  largura: larguraCampo,
                  label: 'Entrega',
                  valorInicial: _formatarData(recibo.dataEntrega),
                  hintText: 'dd/mm/aaaa',
                  keyboardType: TextInputType.datetime,
                  onChanged: (valor) {
                    final data = _converterData(valor);
                    if (data != null) {
                      onDataEntregaChanged(data);
                    }
                  },
                  textInputAction: TextInputAction.next,
                ),
                _CampoFormulario(
                  largura: larguraCampo,
                  label: 'Cliente',
                  valorInicial: recibo.cliente,
                  onChanged: onClienteChanged,
                  textInputAction: TextInputAction.next,
                ),
                _CampoFormulario(
                  largura: larguraCampo,
                  label: 'Telefone',
                  valorInicial: TelefoneInputFormatter.formatar(
                    recibo.telefone,
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: const [TelefoneInputFormatter()],
                  onChanged: onTelefoneChanged,
                  textInputAction: TextInputAction.next,
                ),
                _CampoFormulario(
                  largura: larguraCampo,
                  label: 'Valor de entrada',
                  valorInicial: valorEntradaFormatado.replaceFirst('R\$ ', ''),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                  ],
                  onChanged: (valor) =>
                      onValorEntradaChanged(_converterMoeda(valor)),
                  textInputAction: TextInputAction.next,
                ),
                _CampoFormulario(
                  largura: largura,
                  label: 'Observações',
                  valorInicial: recibo.observacoes,
                  maxLines: 3,
                  onChanged: onObservacoesChanged,
                  textInputAction: TextInputAction.newline,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  static String _formatarData(DateTime? data) {
    if (data == null) {
      return '';
    }

    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year.toString().padLeft(4, '0')}';
  }

  static DateTime? _converterData(String valor) {
    final partes = valor.trim().split('/');
    if (partes.length != 3) {
      return null;
    }

    final dia = int.tryParse(partes[0]);
    final mes = int.tryParse(partes[1]);
    final ano = int.tryParse(partes[2]);
    if (dia == null || mes == null || ano == null) {
      return null;
    }

    final data = DateTime(ano, mes, dia);
    if (data.day != dia || data.month != mes || data.year != ano) {
      return null;
    }

    return data;
  }

  static int _converterMoeda(String valor) {
    final semEspacos = valor.trim().replaceAll('R\$', '').replaceAll(' ', '');
    if (semEspacos.isEmpty) {
      return 0;
    }

    final normalizado = semEspacos.replaceAll('.', '').replaceAll(',', '.');
    final valorDecimal = double.tryParse(normalizado);
    if (valorDecimal == null) {
      return 0;
    }

    return (valorDecimal * 100).round();
  }
}

class _CampoFormulario extends StatelessWidget {
  const _CampoFormulario({
    required this.largura,
    required this.label,
    required this.valorInicial,
    required this.onChanged,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
    this.textInputAction,
    this.helperText,
    this.readOnly = false,
  });

  final double largura;
  final String label;
  final String valorInicial;
  final ValueChanged<String> onChanged;
  final String? hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final TextInputAction? textInputAction;
  final String? helperText;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: largura,
      child: TextFormField(
        key: ValueKey('$label-$valorInicial'),
        initialValue: valorInicial,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          helperText: helperText,
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        textInputAction: textInputAction,
        readOnly: readOnly,
        onChanged: onChanged,
      ),
    );
  }
}
