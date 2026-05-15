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

  static const double _larguraMaxima = 1120;
  static const double _paddingAmplo = 32;
  static const double _paddingCompacto = 16;
  static const double _espacamentoAmplo = 20;
  static const double _espacamentoCompacto = 14;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompacto = constraints.maxWidth < 720;
        final paddingHorizontal = isCompacto ? _paddingCompacto : _paddingAmplo;
        final espacamento = isCompacto
            ? _espacamentoCompacto
            : _espacamentoAmplo;

        return ColoredBox(
          color: Theme.of(context).colorScheme.surfaceContainerLowest,
          child: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    paddingHorizontal,
                    isCompacto ? 12 : 24,
                    paddingHorizontal,
                    isCompacto ? _paddingCompacto : _paddingAmplo,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: _larguraMaxima,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          cabecalho,
                          SizedBox(height: espacamento),
                          recibo,
                          SizedBox(height: espacamento),
                          resumo,
                        ],
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
