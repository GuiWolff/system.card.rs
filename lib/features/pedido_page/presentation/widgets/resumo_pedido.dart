import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResumoPedido extends StatelessWidget {
  const ResumoPedido({
    required this.totalPedido,
    required this.valorEntrada,
    required this.valorAPagarEntrega,
    this.mensagemValorEntrada,
    this.onValorEntradaChanged,
    super.key,
  });

  final String totalPedido;
  final String valorEntrada;
  final String valorAPagarEntrega;
  final String? mensagemValorEntrada;
  final ValueChanged<int>? onValorEntradaChanged;

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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RESUMO',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 16),
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
                      ),
                      _CampoResumoPedido(
                        largura: larguraCampo,
                        rotulo: 'Valor Entrada:',
                        valor: valorEntrada,
                        mensagemErro: mensagemValorEntrada,
                        onChanged: onValorEntradaChanged,
                      ),
                      _CampoResumoPedido(
                        largura: larguraCampo,
                        rotulo: 'Valor a pagar na Entrega:',
                        valor: valorAPagarEntrega,
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

class _CampoResumoPedido extends StatelessWidget {
  const _CampoResumoPedido({
    required this.largura,
    required this.rotulo,
    required this.valor,
    this.mensagemErro,
    this.onChanged,
    this.destaque = false,
  });

  final double largura;
  final String rotulo;
  final String valor;
  final String? mensagemErro;
  final ValueChanged<int>? onChanged;
  final bool destaque;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final corDestaque = colorScheme.tertiary;

    return SizedBox(
      width: largura,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            rotulo,
            style: textTheme.labelLarge?.copyWith(
              color: destaque ? corDestaque : colorScheme.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          if (onChanged == null)
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 48),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: destaque
                    ? corDestaque.withValues(alpha: 0.14)
                    : colorScheme.surface,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: destaque ? corDestaque : colorScheme.outlineVariant,
                ),
              ),
              child: Text(
                valor,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleMedium?.copyWith(
                  color: destaque ? corDestaque : colorScheme.onSurface,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          else
            TextFormField(
              key: ValueKey('resumo-valor-entrada-$valor'),
              initialValue: valor.replaceFirst('R\$ ', ''),
              decoration: InputDecoration(
                errorText: mensagemErro,
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
              onChanged: (texto) => onChanged!(_converterMoeda(texto)),
            ),
          if (onChanged == null && mensagemErro != null) ...[
            const SizedBox(height: 6),
            Text(
              mensagemErro!,
              style: textTheme.bodySmall?.copyWith(color: colorScheme.error),
            ),
          ],
        ],
      ),
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
