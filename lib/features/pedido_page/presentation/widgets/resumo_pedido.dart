import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResumoPedido extends StatelessWidget {
  const ResumoPedido({
    required this.totalPedido,
    required this.valorEntrada,
    required this.valorAPagarEntrega,
    this.mensagemValorEntrada,
    this.onValorEntradaChanged,
    this.somenteLeitura = false,
    super.key,
  });

  final String totalPedido;
  final String valorEntrada;
  final String valorAPagarEntrega;
  final String? mensagemValorEntrada;
  final ValueChanged<int>? onValorEntradaChanged;
  final bool somenteLeitura;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      container: true,
      label: 'Resumo financeiro do pedido',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.04),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 20,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'RESUMO',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, constraints) {
                  final compacto = constraints.maxWidth < 720;
                  final larguraCampo = compacto
                      ? constraints.maxWidth
                      : (constraints.maxWidth - 24) / 3;

                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _CampoResumoPedido(
                        largura: larguraCampo,
                        rotulo: 'Total do Pedido:',
                        valor: totalPedido,
                        icon: Icons.summarize_outlined,
                      ),
                      _CampoResumoPedido(
                        largura: larguraCampo,
                        rotulo: 'Valor Entrada:',
                        valor: valorEntrada,
                        icon: Icons.payments_outlined,
                        mensagemErro: mensagemValorEntrada,
                        onChanged: somenteLeitura
                            ? null
                            : onValorEntradaChanged,
                      ),
                      _CampoResumoPedido(
                        largura: larguraCampo,
                        rotulo: 'Valor a pagar na Entrega:',
                        valor: valorAPagarEntrega,
                        icon: Icons.local_shipping_outlined,
                        destaque: true,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CampoResumoPedido extends StatefulWidget {
  const _CampoResumoPedido({
    required this.largura,
    required this.rotulo,
    required this.valor,
    required this.icon,
    this.mensagemErro,
    this.onChanged,
    this.destaque = false,
  });

  final double largura;
  final String rotulo;
  final String valor;
  final IconData icon;
  final String? mensagemErro;
  final ValueChanged<int>? onChanged;
  final bool destaque;

  @override
  State<_CampoResumoPedido> createState() => _CampoResumoPedidoState();
}

class _CampoResumoPedidoState extends State<_CampoResumoPedido> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _textoEditavel);
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant _CampoResumoPedido oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_textoEditavel != oldWidget.valor.replaceFirst('R\$ ', '') &&
        !_focusNode.hasFocus) {
      _sincronizarTexto(_textoEditavel);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String get _textoEditavel => widget.valor.replaceFirst('R\$ ', '');

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final corDestaque = colorScheme.tertiary;

    return SizedBox(
      width: widget.largura,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: widget.destaque
                    ? corDestaque
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  widget.rotulo,
                  style: textTheme.labelLarge?.copyWith(
                    color: widget.destaque
                        ? corDestaque
                        : colorScheme.onSurface,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          if (widget.onChanged == null)
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 48),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: widget.destaque
                    ? corDestaque.withValues(alpha: 0.14)
                    : colorScheme.surface,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: widget.destaque
                      ? corDestaque
                      : colorScheme.outlineVariant,
                ),
              ),
              child: Text(
                widget.valor,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleMedium?.copyWith(
                  color: widget.destaque ? corDestaque : colorScheme.onSurface,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          else
            TextFormField(
              key: const ValueKey('resumo-valor-entrada'),
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                errorText: widget.mensagemErro,
                prefixText: 'R\$ ',
              ),
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
              ],
              onChanged: (texto) => widget.onChanged!(_converterMoeda(texto)),
            ),
          if (widget.onChanged == null && widget.mensagemErro != null) ...[
            const SizedBox(height: 6),
            Text(
              widget.mensagemErro!,
              style: textTheme.bodySmall?.copyWith(color: colorScheme.error),
            ),
          ],
        ],
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
