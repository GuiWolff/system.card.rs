import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    this.somenteLeitura = false,
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
  final bool somenteLeitura;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dados do Recibo',
          style: textTheme.titleMedium?.copyWith(
            color: colorScheme.secondary,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final largura = constraints.maxWidth;
            final colunas = largura >= 900
                ? 3
                : largura >= 640
                ? 2
                : 1;
            final larguraCampo = colunas == 1
                ? largura
                : (largura - (12 * (colunas - 1))) / colunas;

            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _CampoFormulario(
                  chave: 'recibo-formulario-numero',
                  largura: larguraCampo,
                  label: 'Número do recibo',
                  valorInicial: recibo.numero,
                  helperText: 'Gerado automaticamente pelo sistema',
                  readOnly: true,
                  somenteLeitura: somenteLeitura,
                  prefixIcon: FontAwesomeIcons.hashtag,
                  onChanged: onNumeroChanged,
                  textInputAction: TextInputAction.next,
                ),
                _CampoFormulario(
                  chave: 'recibo-formulario-recebido',
                  largura: larguraCampo,
                  label: 'Recebido',
                  valorInicial: _formatarData(recibo.dataRecebimento),
                  hintText: 'dd/mm/aaaa',
                  prefixIcon: FontAwesomeIcons.calendarDays,
                  keyboardType: TextInputType.datetime,
                  somenteLeitura: somenteLeitura,
                  onChanged: (valor) {
                    final data = _converterData(valor);
                    if (data != null) {
                      onDataRecebimentoChanged(data);
                    }
                  },
                  textInputAction: TextInputAction.next,
                ),
                _CampoFormulario(
                  chave: 'recibo-formulario-entrega',
                  largura: larguraCampo,
                  label: 'Entrega',
                  valorInicial: _formatarData(recibo.dataEntrega),
                  hintText: 'dd/mm/aaaa',
                  prefixIcon: FontAwesomeIcons.calendarCheck,
                  keyboardType: TextInputType.datetime,
                  somenteLeitura: somenteLeitura,
                  onChanged: (valor) {
                    final data = _converterData(valor);
                    if (data != null) {
                      onDataEntregaChanged(data);
                    }
                  },
                  textInputAction: TextInputAction.next,
                ),
                _CampoFormulario(
                  chave: 'recibo-formulario-cliente',
                  largura: larguraCampo,
                  label: 'Cliente',
                  valorInicial: recibo.cliente,
                  prefixIcon: FontAwesomeIcons.user,
                  somenteLeitura: somenteLeitura,
                  onChanged: onClienteChanged,
                  textInputAction: TextInputAction.next,
                ),
                _CampoFormulario(
                  chave: 'recibo-formulario-telefone',
                  largura: larguraCampo,
                  label: 'Telefone',
                  valorInicial: TelefoneInputFormatter.formatar(
                    recibo.telefone,
                  ),
                  prefixIcon: FontAwesomeIcons.phone,
                  keyboardType: TextInputType.phone,
                  inputFormatters: const [TelefoneInputFormatter()],
                  somenteLeitura: somenteLeitura,
                  onChanged: onTelefoneChanged,
                  textInputAction: TextInputAction.next,
                ),
                _CampoFormulario(
                  chave: 'recibo-formulario-valor-entrada',
                  largura: larguraCampo,
                  label: 'Valor de entrada',
                  valorInicial: valorEntradaFormatado.replaceFirst('R\$ ', ''),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  prefixIcon: FontAwesomeIcons.moneyBill,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                  ],
                  somenteLeitura: somenteLeitura,
                  onChanged: (valor) =>
                      onValorEntradaChanged(_converterMoeda(valor)),
                  textInputAction: TextInputAction.next,
                ),
                _CampoFormulario(
                  chave: 'recibo-formulario-observacoes',
                  largura: largura,
                  label: 'Observações',
                  valorInicial: recibo.observacoes,
                  maxLines: 3,
                  prefixIcon: FontAwesomeIcons.noteSticky,
                  somenteLeitura: somenteLeitura,
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

class _CampoFormulario extends StatefulWidget {
  const _CampoFormulario({
    required this.chave,
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
    this.somenteLeitura = false,
    this.prefixIcon,
  });

  final String chave;
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
  final bool somenteLeitura;
  final FaIconData? prefixIcon;

  @override
  State<_CampoFormulario> createState() => _CampoFormularioState();
}

class _CampoFormularioState extends State<_CampoFormulario> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.valorInicial);
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant _CampoFormulario oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.valorInicial != oldWidget.valorInicial && !_focusNode.hasFocus) {
      _sincronizarTexto(widget.valorInicial);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.largura,
      child: TextFormField(
        key: ValueKey(widget.chave),
        controller: _controller,
        focusNode: _focusNode,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hintText,
          helperText: widget.helperText,
          prefixIcon: widget.prefixIcon == null
              ? null
              : FaIcon(widget.prefixIcon),
        ),
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        maxLines: widget.maxLines,
        textInputAction: widget.textInputAction,
        readOnly: widget.readOnly || widget.somenteLeitura,
        enabled: !widget.somenteLeitura,
        onChanged: widget.somenteLeitura ? null : widget.onChanged,
      ),
    );
  }

  void _sincronizarTexto(String texto) {
    if (_controller.text == texto) {
      return;
    }

    _controller.value = TextEditingValue(
      text: texto,
      selection: TextSelection.collapsed(offset: texto.length),
    );
  }
}
