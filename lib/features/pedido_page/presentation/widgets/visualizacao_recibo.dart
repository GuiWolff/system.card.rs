import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_card_rs/features/pedido_page/domain/models/item_recibo.dart';
import 'package:system_card_rs/features/pedido_page/domain/models/recibo.dart';

class VisualizacaoRecibo extends StatelessWidget {
  const VisualizacaoRecibo({required this.recibo, super.key});

  final Recibo recibo;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border.all(color: colorScheme.outlineVariant),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _CabecalhoEmpresa(textTheme: textTheme),
                const SizedBox(height: 24),
                _DadosCliente(recibo: recibo),
                const SizedBox(height: 10),
                _ObservacoesRecibo(observacoes: recibo.observacoes),
                _TabelaItens(itens: recibo.itens),
                const SizedBox(height: 18),
                Align(
                  alignment: Alignment.centerRight,
                  child: _TotaisRecibo(recibo: recibo),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CabecalhoEmpresa extends StatelessWidget {
  const _CabecalhoEmpresa({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final compacto = constraints.maxWidth < 560;

        return Wrap(
          spacing: 20,
          runSpacing: 16,
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: compacto ? constraints.maxWidth : 330,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 78,
                    height: 78,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: colorScheme.primary, width: 3),
                    ),
                    child: Text(
                      'SC',
                      style: textTheme.headlineSmall?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SYSTEM CARD - RS',
                          style: textTheme.headlineSmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Sistemas de Identificação',
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: compacto ? constraints.maxWidth : 260,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ContatoEmpresa(
                    icone: FontAwesomeIcons.instagram,
                    texto: '@systemcards',
                    corIcone: colorScheme.primary,
                  ),
                  _ContatoEmpresa(
                    icone: FontAwesomeIcons.whatsapp,
                    texto: '51 998020198',
                    corIcone: colorScheme.tertiary,
                  ),
                  _ContatoEmpresa(
                    icone: FontAwesomeIcons.phone,
                    texto: '51 30551025',
                    corIcone: colorScheme.onSurface,
                  ),
                  _ContatoEmpresa(
                    icone: FontAwesomeIcons.locationDot,
                    texto: 'Rua 20 de Setembro, 528\nCentro - Guaíba - RS',
                    corIcone: colorScheme.onSurface,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ContatoEmpresa extends StatelessWidget {
  const _ContatoEmpresa({
    required this.icone,
    required this.texto,
    required this.corIcone,
  });

  final FaIconData icone;
  final String texto;
  final Color corIcone;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FaIcon(icone, size: 17, color: corIcone),
          const SizedBox(width: 8),
          Expanded(child: Text(texto, style: textTheme.bodySmall)),
        ],
      ),
    );
  }
}

class _DadosCliente extends StatelessWidget {
  const _DadosCliente({required this.recibo});

  final Recibo recibo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final compacto = constraints.maxWidth < 520;
            final larguraCampo = compacto
                ? constraints.maxWidth
                : (constraints.maxWidth - 20) / 2;

            return Wrap(
              spacing: 20,
              runSpacing: 8,
              children: [
                SizedBox(
                  width: larguraCampo,
                  child: _LinhaDado(
                    rotulo: 'Recebido:',
                    valor: _formatarData(recibo.dataRecebimento),
                  ),
                ),
                SizedBox(
                  width: larguraCampo,
                  child: _LinhaDado(
                    rotulo: 'Entrega:',
                    valor: _formatarData(recibo.dataEntrega),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        _LinhaDado(rotulo: 'Cliente:', valor: _valorOuTraco(recibo.cliente)),
        const Divider(height: 8),
        _LinhaDado(rotulo: 'Fone:', valor: _valorOuTraco(recibo.telefone)),
        const Divider(height: 8),
      ],
    );
  }
}

class _LinhaDado extends StatelessWidget {
  const _LinhaDado({required this.rotulo, required this.valor});

  final String rotulo;
  final String valor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(rotulo, style: textTheme.bodyLarge),
        const SizedBox(width: 8),
        Expanded(child: Text(valor, style: textTheme.bodyLarge)),
      ],
    );
  }
}

class _ObservacoesRecibo extends StatelessWidget {
  const _ObservacoesRecibo({required this.observacoes});

  final String observacoes;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(border: Border.all(color: colorScheme.outline)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ColoredBox(
            color: colorScheme.onSurface,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                'Observações',
                textAlign: TextAlign.center,
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.surface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 86),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                _valorOuVazio(observacoes),
                style: textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabelaItens extends StatelessWidget {
  const _TabelaItens({required this.itens});

  final List<ItemRecibo> itens;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: colorScheme.outline),
          right: BorderSide(color: colorScheme.outline),
          bottom: BorderSide(color: colorScheme.outline),
        ),
      ),
      child: Column(
        children: [
          const _CabecalhoTabela(),
          if (itens.isEmpty)
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text('Nenhum produto/serviço informado.'),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: itens.length,
              separatorBuilder: (_, _) =>
                  Divider(height: 1, color: colorScheme.outline),
              itemBuilder: (context, indice) {
                return _LinhaItemTabela(item: itens[indice]);
              },
            ),
        ],
      ),
    );
  }
}

class _CabecalhoTabela extends StatelessWidget {
  const _CabecalhoTabela();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ColoredBox(
      color: colorScheme.onSurface,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Row(
          children: [
            SizedBox(
              width: 58,
              child: Text(
                'Qtde.',
                textAlign: TextAlign.center,
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.surface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Produtos',
                textAlign: TextAlign.center,
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.surface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              width: 110,
              child: Text(
                'Vl. Total',
                textAlign: TextAlign.right,
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.surface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LinhaItemTabela extends StatelessWidget {
  const _LinhaItemTabela({required this.item});

  final ItemRecibo item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: 78,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                item.quantidade.toString(),
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium,
              ),
            ),
          ),
          VerticalDivider(width: 1, color: colorScheme.outline),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                _valorOuTraco(item.descricao),
                style: textTheme.bodyMedium,
              ),
            ),
          ),
          VerticalDivider(width: 1, color: colorScheme.outline),
          SizedBox(
            width: 118,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                _formatarCentavosSemSimbolo(item.totalCentavos),
                textAlign: TextAlign.right,
                style: textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TotaisRecibo extends StatelessWidget {
  const _TotaisRecibo({required this.recibo});

  final Recibo recibo;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 540),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                _RotuloTotal(texto: 'Total do Pedido'),
                _RotuloTotal(texto: 'Valor Entrada'),
                _RotuloTotal(texto: 'Valor a pagar na Entrega'),
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.outline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _ValorTotal(
                  texto: _formatarCentavosSemSimbolo(
                    recibo.totalPedidoCentavos,
                  ),
                ),
                _ValorTotal(
                  texto: _formatarCentavosSemSimbolo(
                    recibo.valorEntradaCentavos,
                  ),
                ),
                _ValorTotal(
                  texto: _formatarCentavosSemSimbolo(
                    recibo.valorAPagarEntregaCentavos,
                  ),
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.tertiary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RotuloTotal extends StatelessWidget {
  const _RotuloTotal({required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Flexible(
            child: Text(
              texto,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.titleMedium,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final pontos = (constraints.maxWidth / 6).floor();
                return Text(
                  ''.padRight(pontos.clamp(0, 40), '.'),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ValorTotal extends StatelessWidget {
  const _ValorTotal({required this.texto, this.style});

  final String texto;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 132,
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colorScheme.outline)),
      ),
      child: Text(
        texto,
        textAlign: TextAlign.right,
        style: style ?? textTheme.titleMedium,
      ),
    );
  }
}

String _formatarData(DateTime? data) {
  if (data == null) {
    return '-';
  }

  return '${data.day.toString().padLeft(2, '0')}/'
      '${data.month.toString().padLeft(2, '0')}/'
      '${data.year.toString().padLeft(4, '0')}';
}

String _formatarCentavosSemSimbolo(int centavos) {
  final sinal = centavos < 0 ? '-' : '';
  final valorAbsoluto = centavos.abs();
  final reais = valorAbsoluto ~/ 100;
  final centavosRestantes = valorAbsoluto % 100;

  return '$sinal$reais,${centavosRestantes.toString().padLeft(2, '0')}';
}

String _valorOuTraco(String valor) {
  final texto = valor.trim();
  return texto.isEmpty ? '-' : texto;
}

String _valorOuVazio(String valor) {
  return valor.trim();
}
