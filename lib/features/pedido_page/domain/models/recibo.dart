import 'item_recibo.dart';
import 'resumo_recibo.dart';

class Recibo {
  Recibo({
    this.id,
    required this.numero,
    required this.cliente,
    Iterable<ItemRecibo> itens = const <ItemRecibo>[],
    this.valorEntradaCentavos = 0,
    this.dataRecebimento,
    this.dataEntrega,
    this.telefone = '',
    this.observacoes = '',
    this.criadoEm,
    this.atualizadoEm,
  }) : itens = List<ItemRecibo>.unmodifiable(itens);

  final int? id;
  final String numero;
  final String cliente;
  final DateTime? dataRecebimento;
  final DateTime? dataEntrega;
  final String telefone;
  final String observacoes;
  final List<ItemRecibo> itens;
  final int valorEntradaCentavos;
  final DateTime? criadoEm;
  final DateTime? atualizadoEm;

  int get totalPedidoCentavos => resumo.totalPedidoCentavos;

  int get valorAPagarEntregaCentavos => resumo.valorAPagarEntregaCentavos;

  ResumoRecibo get resumo {
    return ResumoRecibo.calcular(
      itens: itens,
      valorEntradaCentavos: valorEntradaCentavos,
    );
  }

  bool get valido => validar().isEmpty;

  List<String> validar() {
    final erros = <String>[];

    if (numero.trim().isEmpty) {
      erros.add('O número do recibo é obrigatório.');
    }

    if (cliente.trim().isEmpty) {
      erros.add('O cliente é obrigatório.');
    }

    for (var indice = 0; indice < itens.length; indice++) {
      final numeroDoItem = indice + 1;
      for (final erro in itens[indice].validar()) {
        erros.add('Item $numeroDoItem: $erro');
      }
    }

    erros.addAll(resumo.validar());

    return erros;
  }

  Recibo copyWith({
    int? id,
    String? numero,
    String? cliente,
    DateTime? dataRecebimento,
    DateTime? dataEntrega,
    String? telefone,
    String? observacoes,
    Iterable<ItemRecibo>? itens,
    int? valorEntradaCentavos,
    DateTime? criadoEm,
    DateTime? atualizadoEm,
  }) {
    return Recibo(
      id: id ?? this.id,
      numero: numero ?? this.numero,
      cliente: cliente ?? this.cliente,
      dataRecebimento: dataRecebimento ?? this.dataRecebimento,
      dataEntrega: dataEntrega ?? this.dataEntrega,
      telefone: telefone ?? this.telefone,
      observacoes: observacoes ?? this.observacoes,
      itens: itens ?? this.itens,
      valorEntradaCentavos: valorEntradaCentavos ?? this.valorEntradaCentavos,
      criadoEm: criadoEm ?? this.criadoEm,
      atualizadoEm: atualizadoEm ?? this.atualizadoEm,
    );
  }
}
