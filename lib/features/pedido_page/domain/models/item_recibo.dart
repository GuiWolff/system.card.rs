class ItemRecibo {
  const ItemRecibo({
    this.id,
    required this.quantidade,
    required this.descricao,
    required this.valorUnitarioCentavos,
    this.ordem = 0,
  });

  final int? id;
  final int ordem;
  final int quantidade;
  final String descricao;
  final int valorUnitarioCentavos;

  int get totalCentavos => quantidade * valorUnitarioCentavos;

  bool get valido => validar().isEmpty;

  List<String> validar() {
    final erros = <String>[];

    if (quantidade <= 0) {
      erros.add('A quantidade do item deve ser maior que zero.');
    }

    if (descricao.trim().isEmpty) {
      erros.add('A descrição do item é obrigatória.');
    }

    if (valorUnitarioCentavos < 0) {
      erros.add('O valor unitário do item não pode ser negativo.');
    }

    return erros;
  }

  ItemRecibo copyWith({
    int? id,
    int? ordem,
    int? quantidade,
    String? descricao,
    int? valorUnitarioCentavos,
  }) {
    return ItemRecibo(
      id: id ?? this.id,
      ordem: ordem ?? this.ordem,
      quantidade: quantidade ?? this.quantidade,
      descricao: descricao ?? this.descricao,
      valorUnitarioCentavos:
          valorUnitarioCentavos ?? this.valorUnitarioCentavos,
    );
  }
}
