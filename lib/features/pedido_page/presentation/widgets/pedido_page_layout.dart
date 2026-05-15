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
  static const double _espacamento = 16;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompacto = constraints.maxWidth < 720;
        final paddingHorizontal = isCompacto ? _paddingCompacto : _paddingAmplo;

        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: paddingHorizontal,
                vertical: isCompacto ? _paddingCompacto : _paddingAmplo,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _larguraMaxima),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      cabecalho,
                      const SizedBox(height: _espacamento),
                      recibo,
                      const SizedBox(height: _espacamento),
                      resumo,
                    ],
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
