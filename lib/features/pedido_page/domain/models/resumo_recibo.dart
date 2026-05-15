import 'item_recibo.dart';

class ResumoRecibo {
  const ResumoRecibo({
    required this.totalPedidoCentavos,
    required this.valorEntradaCentavos,
  });

  factory ResumoRecibo.calcular({
    required Iterable<ItemRecibo> itens,
    required int valorEntradaCentavos,
  }) {
    final totalPedidoCentavos = itens.fold<int>(
      0,
      (total, item) => total + item.totalCentavos,
    );

    return ResumoRecibo(
      totalPedidoCentavos: totalPedidoCentavos,
      valorEntradaCentavos: valorEntradaCentavos,
    );
  }

  final int totalPedidoCentavos;
  final int valorEntradaCentavos;

  int get valorAPagarEntregaCentavos =>
      totalPedidoCentavos - valorEntradaCentavos;

  bool get valido => validar().isEmpty;

  List<String> validar() {
    final erros = <String>[];

    if (totalPedidoCentavos < 0) {
      erros.add('O total do pedido não pode ser negativo.');
    }

    if (valorEntradaCentavos < 0) {
      erros.add('O valor de entrada não pode ser negativo.');
    }

    if (valorEntradaCentavos > totalPedidoCentavos) {
      erros.add('O valor de entrada não pode ultrapassar o total do pedido.');
    }

    return erros;
  }
}
