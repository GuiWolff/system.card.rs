import 'package:flutter/material.dart';

class PedidoPageLayout extends StatelessWidget {
  const PedidoPageLayout({
    required this.cabecalho,
    required this.recibo,
    required this.resumo,
    super.key,
  });

  final Widget cabecalho;
  final Widget recibo;
  final Widget resumo;

  static const double _larguraMaxima = 1240;
  static const double _larguraResumoLateral = 340;
  static const double _breakpointResumoLateral = 1180;
  static const double _paddingAmplo = 28;
  static const double _paddingCompacto = 16;
  static const double _espacamentoAmplo = 18;
  static const double _espacamentoCompacto = 12;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompacto = constraints.maxWidth < 720;
        final usarResumoLateral =
            constraints.maxWidth >= _breakpointResumoLateral;
        final paddingHorizontal = isCompacto ? _paddingCompacto : _paddingAmplo;
        final espacamento = isCompacto
            ? _espacamentoCompacto
            : _espacamentoAmplo;
        final colorScheme = Theme.of(context).colorScheme;
        final paddingTopo = isCompacto ? 12.0 : 20.0;
        final paddingRodape = isCompacto ? _paddingCompacto : _paddingAmplo;
        final alturaMinima =
            (constraints.maxHeight - paddingTopo - paddingRodape)
                .clamp(0.0, double.infinity)
                .toDouble();

        return ColoredBox(
          color: colorScheme.surfaceContainerLowest,
          child: SafeArea(
            bottom: false,
            child: Scrollbar(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  paddingHorizontal,
                  paddingTopo,
                  paddingHorizontal,
                  paddingRodape,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: alturaMinima),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: _larguraMaxima,
                      ),
                      child: _PedidoWorkspace(
                        cabecalho: cabecalho,
                        recibo: recibo,
                        resumo: resumo,
                        espacamento: espacamento,
                        usarResumoLateral: usarResumoLateral,
                        larguraResumoLateral: _larguraResumoLateral,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PedidoWorkspace extends StatelessWidget {
  const _PedidoWorkspace({
    required this.cabecalho,
    required this.recibo,
    required this.resumo,
    required this.espacamento,
    required this.usarResumoLateral,
    required this.larguraResumoLateral,
  });

  final Widget cabecalho;
  final Widget recibo;
  final Widget resumo;
  final double espacamento;
  final bool usarResumoLateral;
  final double larguraResumoLateral;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        cabecalho,
        SizedBox(height: espacamento),
        if (usarResumoLateral)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: recibo),
              SizedBox(width: espacamento),
              SizedBox(width: larguraResumoLateral, child: resumo),
            ],
          )
        else ...[
          recibo,
          SizedBox(height: espacamento),
          resumo,
        ],
      ],
    );
  }
}
